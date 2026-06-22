<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%@ page import="model.Pokemon" %>
<%@ page import="model.PokemonDAO" %>
<%@ page import="java.util.Collection" %>
<%
    //sicurezza per cui solo gli admin entrano (Allineato con il valore "AMMINISTRATORE" del Database)
    Utente adminUser = (Utente) session.getAttribute("utente");
    if (adminUser == null || !"AMMINISTRATORE".equalsIgnoreCase(adminUser.getRuolo())) {
        response.sendRedirect("Login.jsp?errore=permessi");
        return;
    }

    //recuperiamo tutti i prodotti attivi dal tuo DAO
    PokemonDAO pokemonDAO = new PokemonDAO();
    Collection<Pokemon> listaProdotti = pokemonDAO.doRetrieveAll();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pok&eacute;Cave - Admin Panel</title>
    <style> /*meglio rimanere qua tutto*/
        body { font-family: sans-serif; background: #f4f4f4; padding: 20px; }
        .admin-container { max-width: 1000px; margin: 0 auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        h2, h3 { color: #333; border-bottom: 2px solid #e3350d; padding-bottom: 8px; }
        .form-group { margin-bottom: 12px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 4px; }
        .form-group input, .form-group textarea { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn { padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; color: white; display: inline-block; text-align: center; }
        .btn-add { background: #e3350d; width: 100%; padding: 12px; }
        .btn-update { background: #28a745; }
        .btn-delete { background: #dc3545; text-decoration: none; padding: 8px 15px; font-size: 14px; }
        
        /*stile tabella*/
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; vertical-align: middle; }
        th { background: #f8f9fa; }
        .input-table { width: 80px; padding: 5px; }
        .form-inline { display: inline; margin: 0; padding: 0; }
    </style>
</head>
<body>

<div class="admin-container">
    <h2>Pannello Amministratore Pok&eacute;Cave</h2>
    
    <% if(request.getParameter("success") != null) { %>
        <div style="color: green; font-weight: bold; margin-bottom: 15px;">Operazione completata con successo!</div>
    <% } %>
    <% if(request.getParameter("error") != null) { %>
        <div style="color: red; font-weight: bold; margin-bottom: 15px;">Si è verificato un errore.</div>
    <% } %>

    <h3>Aggiungi Nuovo Prodotto</h3>
    <form action="GestioneAdminServlet" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="action" value="add">
        <div class="form-group">
            <label>Nome</label> <input type="text" name="nome" required>
        </div>
        <div style="display: flex; gap: 15px;">
            <div class="form-group" style="flex: 1;">
                <label>Tipo (card/box/gadget)</label> <input type="text" name="tipo" required>
            </div>
            <div class="form-group" style="flex: 1;">
                <label>Prezzo (&euro;)</label> <input type="number" name="prezzo" step="0.01" required>
            </div>
            <div class="form-group" style="flex: 1;">
                <label>Quantit&agrave;</label> <input type="number" name="quantita" required>
            </div>
            <div class="form-group" style="flex: 1;">
                <label>ID Catalogo</label> <input type="number" name="idCatalogo" required>
            </div>
        </div>
        <div class="form-group">
            <label>Descrizione</label> <textarea name="descrizione" rows="3" required></textarea>
        </div>
        <div class="form-group">
            <label>Immagine Prodotto</label> <input type="file" name="immagine" accept="image/*" required>
        </div>
        <button type="submit" class="btn btn-add">Salva Nuovo Prodotto</button>
    </form>

    <h3 style="margin-top: 40px;">Gestione Prodotti Esistenti</h3>
    <table>
        <thead>
            <tr>
                <th>Foto</th>
                <th>Nome</th>
                <th>Tipo</th>
                <th>Prezzo (&euro;)</th>
                <th>Quantit&agrave;</th>
                <th>Azioni</th>
            </tr>
        </thead>
        <tbody>
            <% if(listaProdotti != null && !listaProdotti.isEmpty()) { 
                for(Pokemon p : listaProdotti) { %>
                <tr>
                    <td><img src="<%= p.getUrlImmagine() %>" width="40" alt="p_img" onerror="this.src='img/default.png';"></td>
                    <td><strong><%= p.getNome() %></strong></td>
                    <td><%= p.getTipo() %></td>
                    
                    <form action="GestioneAdminServlet" method="POST" class="form-inline">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="id" value="<%= p.getId() %>">
                        <td>
                            <input type="number" name="prezzo" value="<%= p.getPrezzo() %>" step="0.01" class="input-table" required>
                        </td>
                        <td>
                            <input type="number" name="quantita" value="<%= p.getQuantita() %>" class="input-table" required>
                        </td>
                        <td>
                            <button type="submit" class="btn btn-update">Modifica</button>
                            <a href="GestioneAdminServlet?action=delete&id=<%= p.getId() %>" class="btn btn-delete" onclick="return confirm('Sicuro di voler eliminare questo prodotto?');">Elimina</a>
                        </td>
                    </form>
                </tr>
            <% } } else { %>
                <tr><td colspan="6">Nessun prodotto presente nel catalogo.</td></tr>
            <% } %>
        </tbody>
    </table>
    
    <p style="text-align: center; margin-top: 20px;"><a href="Index.jsp">Torna alla Home del sito</a></p>
</div>

</body>
</html>