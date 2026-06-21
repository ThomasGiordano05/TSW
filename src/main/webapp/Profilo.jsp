<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.Utente" %>
<%@ page import="model.Ordine" %>
<%@ page import="model.OrdineDAO" %>
<%
    // Controllo Sicurezza: Se non sei loggato, fuori di qui!
    Utente utenteLoggato = (Utente) session.getAttribute("utente");
    if (utenteLoggato == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/Style.css?v=<%= System.currentTimeMillis() %>">
    <meta charset="UTF-8">
    <title>PokéCave - Il tuo Profilo</title>
    <style>
        /* Stili aggiuntivi per rendere la pagina profilo pulita e leggibile */
        .profilo-container { max-width: 800px; margin: 0 auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .info-utente { margin-bottom: 30px; padding-bottom: 20px; border-bottom: 2px solid #f0f0f0; }
        .table-ordini { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .table-ordini th, .table-ordini td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        .table-ordini th { background-color: #f8f9fa; }
        .btn-ricevuta { background-color: #ffcc00; color: #333; padding: 5px 10px; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .btn-ricevuta:hover { background-color: #e6b800; }
    </style>
</head>
<body>
    <header class="navbar">
        <a href="Index.jsp"><img class="logo" src="images/poke.png" alt="poke"/></a>
        <nav>
            <div class="link">
                <a class="single-link" href="CatalogoServlet">Shop</a>
                <span>|</span>
                <a class="single-link" href="Wishlist.jsp">Wishlist</a>
                <span>|</span>
                <a class="single-link" href="Carrello.jsp">Carrello</a>
                <span>|</span>
                <a class="single-link" href="Profilo.jsp"><%= utenteLoggato.getNome() %></a>
                <span>|</span>
                <a class="single-link" href="LogoutServlet">Logout</a>
            </div>
        </nav>
    </header>

    <main>
        <div class="main-container">
            <div class="profilo-container">
                
                <div class="info-utente">
                    <h2>Benvenuto, <%= utenteLoggato.getNome() %>!</h2>
                    <p><strong>Nome:</strong> <%= utenteLoggato.getNome() %></p>
                    <p><strong>Cognome:</strong> <%= utenteLoggato.getCognome() %></p>
                    <p><strong>Email:</strong> <%= utenteLoggato.getEmail() %></p>
                </div>

                <div class="ordini-utente">
                    <h2>La tua Cronologia Ordini</h2>
                    <%
                        OrdineDAO ordineDao = new OrdineDAO();
                        // Recuperiamo gli ordini tramite il metodo che hai già preparato nel DAO!
                        ArrayList<Ordine> listaOrdini = ordineDao.doRetrieveByCliente(utenteLoggato.getId());
                        
                        if (listaOrdini != null && !listaOrdini.isEmpty()) {
                    %>
                        <table class="table-ordini">
                            <thead>
                                <tr>
                                    <th>Numero Ordine</th>
                                    <th>Totale</th>
                                    <th>Azioni</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% for (Ordine o : listaOrdini) { %>
                                <tr>
                                    <td>#000<%= o.getIdOrdine() %></td>
                                    <td>€ <%= String.format("%.2f", o.getTotale()) %></td>
                                    <td><a href="Ricevuta.jsp?id=<%= o.getIdOrdine() %>" class="btn-ricevuta">Vedi Ricevuta</a></td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    <% } else { %>
                        <p style="color: #666; font-style: italic;">Non hai ancora effettuato ordini. Visita lo <a href="CatalogoServlet">Shop</a> per iniziare!</p>
                    <% } %>
                </div>

            </div>
        </div>
    </main>

    <footer>
        <span class="rights">PokéCave - All rights reserved</span>
    </footer>
</body>
</html>