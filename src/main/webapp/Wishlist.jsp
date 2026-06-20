<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%@ page import="model.Pokemon" %>
<%@ page import="java.util.Collection" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/Style.css?v=<%= System.currentTimeMillis() %>">
    <meta charset="UTF-8">
    <title>Wishlist | PokéCave</title>
</head>
<body>
    <header class="navbar">
        <a href="Index.jsp">
            <img class="logo" src="images/poke.png" alt="poke"/>
        </a>
        
        <nav>
            <div class="link">
                <a class="single-link" href="#" id="shop">Shop</a>
                <div id="shop-block" class="hidden">
                    <ul>
                        <li><a class="list-link" href="Shop.jsp">Shop</a></li>
                        <li><a class="list-link" href="Card.jsp">Card</a></li>
                        <li><a class="list-link" href="Box.jsp">Box</a></li>
                        <li><a class="list-link" href="Gadget.jsp">Gadget</a></li>
                    </ul>
                </div>    
                <script src="${pageContext.request.contextPath}/js/menu.js"></script>
                
                <span>|</span>
                <a class="single-link" href="Wishlist.jsp">Wishlist</a>
                <span>|</span>
                <a class="single-link" href="Carrello.jsp">Carrello</a>
                <span>|</span>
                
                <% 
                    Utente utenteLoggato = (Utente) session.getAttribute("utente");
                    if (utenteLoggato != null) { 
                %>
                    <a class="single-link" href="<%= "admin".equals(utenteLoggato.getRuolo()) ? "admin/PannelloAdmin.jsp" : "Profilo.jsp" %>">
                        <%= utenteLoggato.getNome() %>
                    </a>
                    <span>|</span>
                    <a class="single-link" href="Checkout.jsp">Checkout</a>
                    <span>|</span>
                    <a class="single-link" href="LogoutServlet">Logout</a>
                <% } else { %>
                    <a class="single-link" href="Login.jsp">Accedi / Registrati</a>
                <% } %>
            </div>    
        </nav>
    </header>
    
    <main>
        <div class="main-container">
            <div class="container-cart-wish">
                <% 
                    Collection<Pokemon> wishlist = (Collection<Pokemon>) session.getAttribute("wishlist");
                    if (wishlist != null && !wishlist.isEmpty()) {
                        for (Pokemon p : wishlist) {
                %>
                    <div class="single-cart-element-wish">
                        <div class="img-single-cart-element-wish"></div>
                        <div class="info-single-cart-element-wish">
                            <div class="title-single-cart-element-wish"><%= p.getNome() %></div>
                            <div class="description-single-cart-element-wish">€<%= p.getPrezzo() %></div>
                        </div>
                        
                        <div class="container-heart-wish">
                            <img class="heart-positive" width="24" src="images/heart_positive.svg" alt="Rimuovi" onclick="rimuoviDaWishlist(<%= p.getId() %>)" style="cursor: pointer;"/>
                        </div>
                    </div>
                <% 
                        } 
                    } else {
                %>
                    <p style="text-align:center;">La tua wishlist è vuota.</p>
                <% } %>    
            </div>
        </div>
    </main>
    
    <footer>    
        <span class="rights">PokéCave - All rights reserved</span>
    </footer>
    
    <script src="${pageContext.request.contextPath}/js/carosello.js"></script>
</body>
</html>