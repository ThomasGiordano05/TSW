<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%
    // CONTROLLO DI SICUREZZA: Solo gli utenti loggati possono accedere al checkout
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
    <title>Checkout | PokéCave</title>
</head>
<body>
    <header class="navbar">
        <nav>
            <div class="link">
                <a href="Index.jsp"><img class="logo" src="images/poke.png" alt="poke"/></a>
                <a class="single-link" href="CatalogoServlet" id="shop">Shop</a>
                
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
            <div class="check-out" style="position: relative; width: 60%; height: auto; border: 1px solid #000; padding: 2rem;">
                <p class="title-checkout">Conferma Ordine</p>
                <p class="text-checkout">Ciao <%= utenteLoggato.getNome() %>, conferma per completare l'acquisto.</p>
                
                <form action="CheckoutServlet" method="POST">
                    <button type="submit" class="btn" style="width: 250px;">Completa l'Ordine</button>
                </form>
                
                <br>
                <a href="Index.jsp" class="redirect-link">Torna alla Home</a>
            </div>
        </div>
    </main>

    <footer>
        <span class="rights">PokéCave - All rights reserved</span>
    </footer>
</body>
</html>