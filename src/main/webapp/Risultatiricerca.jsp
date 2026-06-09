<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Pokemon" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pokécave -- Risultati</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Style.css?v=2">
</head>
<body>

    <div class="risultati-container">

    <%
        String itemCercato = (String) request.getAttribute("itemcercato");
        ArrayList<Pokemon> lista = (ArrayList<Pokemon>) request.getAttribute("Risultatiricerca");

        if (lista == null || lista.isEmpty()) {
    %>
            <h2 class="risultati-titolo">Risultati della ricerca per: <span>"<%= itemCercato %>"</span></h2>
            <p class="messaggio-vuoto">Spiacenti, non abbiamo trovato nessun Pokémon che corrisponda alla tua ricerca.</p>
    <%
        } 

        if (lista != null && !lista.isEmpty()) {
    %>
            <h2 class="risultati-titolo">Risultati della ricerca per: <span>"<%= itemCercato %>"</span></h2>
            
            <div class="prodotti-grid">
            <%
                for(Pokemon p : lista) {
            %>
                    <div class="pokemon-card">
                        <h3 class="pokemon-nome"><%= p.getNome() %></h3>
                        <p class="pokemon-prezzo"><%= p.getPrezzo() %> €</p>
                        <button class="pokemon-btn">Vedi Dettaglio</button>
                    </div>
            <%
                } 
            %>
            </div>
    <%
        } 
    %>

    </div>

</body>
</html>