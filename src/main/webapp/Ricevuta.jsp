<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%@ page import="model.Ordine" %>
<%@ page import="model.OrdineDAO" %>
<%@ page import="model.ArticoloCarrello" %>
<%@ page import="java.util.ArrayList" %>
<%
    // 1. Controllo di Sicurezza
    Utente utente = (Utente) session.getAttribute("utente");
    if (utente == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // 2. Recupero ID dall'URL
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect("Profilo.jsp");
        return;
    }

    int idOrdine = Integer.parseInt(idParam);
    OrdineDAO ordineDao = new OrdineDAO();
    
    // 3. FIX RIGA 26: Cambiato doRetrieveBy in doRetrieveById per combaciare con il DAO
    Ordine ordineCorrente = ordineDao.doRetrieveById(idOrdine); 
    
    // 4. Recupero dei prodotti legati all'ordine
    ArrayList<ArticoloCarrello> prodottiOrdine = null;
    if (ordineCorrente != null) {
        prodottiOrdine = ordineDao.getProdottiOrdine(idOrdine); 
    } else {
        out.println("<h3 style='color:red; text-align:center; font-family:sans-serif; margin-top:50px;'>Errore: Ordine #" + idOrdine + " non trovato nel database.</h3>");
        out.println("<p style='text-align:center;'><a href='Profilo.jsp'>Torna al Profilo</a></p>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pok&eacute;Cave - Ricevuta Ordine #000<%= ordineCorrente.getIdOrdine() %></title>
    <style>
        body { font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; color: #333; background: #f9f9f9; padding: 30px; margin: 0; }
        .invoice-box { max-width: 800px; margin: auto; padding: 30px; border: 1px solid #eee; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); background: #fff; border-radius: 8px; }
        .invoice-box table { width: 100%; line-height: inherit; text-align: left; border-collapse: collapse; }
        .invoice-box table td { padding: 10px; vertical-align: top; }
        .invoice-box table tr td:nth-child(2) { text-align: right; }
        .invoice-box table tr.top table td { padding-bottom: 20px; }
        .invoice-box table tr.top table td.title { font-size: 38px; line-height: 40px; color: #e3350d; font-weight: bold; letter-spacing: 1px; }
        .invoice-box table tr.information table td { padding-bottom: 40px; }
        .invoice-box table tr.heading td { background: #f8f9fa; border-bottom: 2px solid #ddd; font-weight: bold; color: #555; }
        .invoice-box table tr.item td { border-bottom: 1px solid #eee; }
        .invoice-box table tr.item.last td { border-bottom: none; }
        .invoice-box table tr.total td:nth-child(2) { border-top: 2px solid #e3350d; font-weight: bold; font-size: 22px; color: #e3350d; padding-top: 15px; }
        .btn-container { text-align: center; margin-top: 30px; }
        .btn-actions { padding: 12px 35px; background: #e3350d; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; font-weight: bold; text-decoration: none; display: inline-block; transition: background 0.2s; }
        .btn-actions:hover { background: #c92c0a; }
        .link-back { display: block; margin-top: 15px; color: #666; text-decoration: none; font-size: 14px; }
        .link-back:hover { text-decoration: underline; }
        
        @media print {
            .btn-container, .navbar, footer { display: none !important; }
            body { background: white; padding: 0; }
            .invoice-box { box-shadow: none; border: none; padding: 0; }
        }
    </style>
</head>
<body>

    <div class="invoice-box">
        <table>
            <tr class="top">
                <td colspan="2">
                    <table>
                        <tr>
                            <td class="title">Pok&eacute;Cave</td>
                            <td>
                                <strong>Ricevuta ID:</strong> #000<%= ordineCorrente.getIdOrdine() %><br>
                                <strong>Stato:</strong> Pagato con Successo<br>
                                <strong>Metodo:</strong> Carta di Credito (Simulazione)
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            
            <tr class="information">
                <td colspan="2">
                    <table>
                        <tr>
                            <td>
                                <strong>Dati Cliente:</strong><br>
                                <%= utente.getNome() %> <%= utente.getCognome() %><br>
                                Email: <%= utente.getEmail() %>
                            </td>
                            <td>
                                <strong>Tipo Spedizione:</strong><br>
                                Spedizione Corriere Espresso<br>
                                Consegna 24/48h Garantita
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            
            <tr class="heading">
                <td>Pokémon / Articolo</td>
                <td>Prezzo Unit.</td>
                <td>IVA</td>
                <td>Totale</td>
            </tr>
            
            <% 
                if (prodottiOrdine != null && !prodottiOrdine.isEmpty()) {
                    for (ArticoloCarrello prod : prodottiOrdine) { 
                        double prezzoTot = prod.getPrezzoTotaleArticolo();
            %>
                <tr class="item">
                    <td><%= prod.getquantitaScelta() %>x <%= prod.getPokemon().getNome() %></td>
                    <td>&euro; <%= String.format("%.2f", prod.getPokemon().getPrezzo()) %></td>
                    <td>22%</td>
                    <td>&euro; <%= String.format("%.2f", prezzoTot) %></td>
                </tr>
            <% 
                    } // Chiude il for
                } else { // Chiude l'if e apre l'else
            %>
                <tr class="item">
                    <td colspan="4" style="color: #999; font-style: italic;">Nessun dettaglio articolo trovato.</td>
                </tr>
            <% 
                } // Chiude l'else
            %>
            <tr class="total">
    <td colspan="2" style="font-size: 12px; font-weight: normal; color: #666;">
        IVA inclusa nel totale: &euro; <%= String.format("%.2f", ordineCorrente.getTotale() - (ordineCorrente.getTotale() / 1.22)) %>
    </td>
    <td colspan="2" style="text-align: right;">
        Totale Ricevuta: &euro; <%= String.format("%.2f", ordineCorrente.getTotale()) %>
    </td>
</tr>
        </table>
    </div>

    <div class="btn-container">
        <button onclick="window.print();" class="btn-actions">Stampa o Salva in PDF</button>
        <a href="Profilo.jsp" class="link-back">&larr; Torna alla tua Cronologia Ordini</a>
    </div>

</body>
</html>