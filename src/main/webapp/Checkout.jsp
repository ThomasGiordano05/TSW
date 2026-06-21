<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%@ page import="model.Carrello" %>
<%@ page import="model.ArticoloCarrello" %>
<%
    // Sicurezza: Solo gli utenti loggati possono fare il checkout
    Utente utente = (Utente) session.getAttribute("utente");
    Carrello cart = (Carrello) session.getAttribute("carrello");
    
    if (utente == null) {
        response.sendRedirect("Login.jsp?errore=nologin");
        return;
    }
    // Se il carrello è vuoto o inesistente, rimanda allo shop
    if (cart == null || cart.getArticoli().isEmpty()) {
        response.sendRedirect("CatalogoServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/Style.css?v=<%= System.currentTimeMillis() %>">
    <meta charset="UTF-8">
    <title>Pok&eacute;Cave - Checkout Sicuro</title>
    <style>
        .checkout-container { display: flex; max-width: 1000px; margin: 40px auto; gap: 30px; }
        .checkout-form { flex: 2; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .checkout-summary { flex: 1; background: #f8f9fa; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); height: fit-content; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        .btn-pay { width: 100%; background-color: #e3350d; color: white; padding: 15px; border: none; border-radius: 5px; font-size: 18px; cursor: pointer; margin-top: 20px; }
        .btn-pay:hover { background-color: #c92c0a; }
        .summary-item { display: flex; justify-content: space-between; margin-bottom: 10px; border-bottom: 1px solid #ddd; padding-bottom: 5px; }
    </style>
</head>
<body>
    <header class="navbar">
        <a href="Index.jsp"><img class="logo" src="images/poke.png" alt="poke"/></a>
    </header>

    <main>
        <div class="checkout-container">
            
            <div class="checkout-form">
                <h2>Dettagli Spedizione e Pagamento</h2>
                
                <%
                    String errore = request.getParameter("error");
                    if (errore != null) {
                %>
                    <div style="background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 12px; margin-bottom: 20px; border-radius: 5px; font-family: sans-serif; font-weight: bold;">
                        ❌ Errore d'acquisto: 
                        <% if(errore.equals("campivuoti")) { %>
                            Assicurati di aver compilato tutti i campi.
                        <% } else if(errore.equals("transazione_fallita")) { %>
                            Il Database ha rifiutato l'ordine. Controlla la console dell'IDE!
                        <% } else { %>
                            <%= errore %>
                        <% } %>
                    </div>
                <% } %>

                <form action="CheckoutServlet" method="POST">
                    
                    <h3>Indirizzo di Consegna</h3>
                    
                    <%-- TORNA IL TUO LAYOUT ORIGINALE BELLISSIMO A RIGA UNICA --%>
                    <div class="form-group">
                        <label>Indirizzo (Via e Civico)</label>
                        <input type="text" name="indirizzo" required placeholder="Es. Via Roma, 10">
                    </div>
                    <div class="form-group" style="display: flex; gap: 10px;">
                        <div style="flex: 2;"><label>Citt&agrave;</label><input type="text" name="citta" required></div>
                        <div style="flex: 1;"><label>CAP</label><input type="text" name="cap" required pattern="[0-9]{5}"></div>
                    </div>

                    <h3 style="margin-top: 30px;">Metodo di Pagamento (Simulazione)</h3>
                    <div class="form-group">
                        <label>Titolare Carta</label>
                        <input type="text" name="titolare" value="<%= utente.getNome() %> <%= utente.getCognome() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Numero Carta</label>
                        <input type="text" name="numero_carta" placeholder="1234 5678 9101 1121" required pattern="[0-9\s]{16,19}">
                    </div>
                    <div class="form-group" style="display: flex; gap: 10px;">
                        <div><label>Scadenza</label><input type="text" name="scadenza" placeholder="MM/AA" required></div>
                        <div><label>CVV</label><input type="text" name="cvv" placeholder="123" required pattern="[0-9]{3}"></div>
                    </div>

                    <button type="submit" class="btn-pay">Paga € <%= String.format("%.2f", cart.getTotale()) %> e Completa Ordine</button>
                </form>
            </div>

            <div class="checkout-summary">
                <h3>Riepilogo Ordine</h3>
                <% for (ArticoloCarrello art : cart.getArticoli()) { %>
                    <div class="summary-item">
                        <span><%= art.getquantitaScelta() %>x <%= art.getPokemon().getNome() %></span>
                        <span>€ <%= String.format("%.2f", art.getPrezzoTotaleArticolo()) %></span>
                    </div>
                <% } %>
                <h2 style="text-align: right; margin-top: 20px;">Totale: € <%= String.format("%.2f", cart.getTotale()) %></h2>
            </div>

        </div>
    </main>
</body>
</html>