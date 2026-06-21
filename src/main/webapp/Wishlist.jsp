<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%@ page import="model.Pokemon" %>
<%@ page import="java.util.Collection" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/Style.css?v=<%= System.currentTimeMillis() %>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
				        <li><a class="list-link" href="CatalogoServlet?categoria=carte">Card</a></li>
				        <li><a class="list-link" href="CatalogoServlet?categoria=box">Box</a></li>
				        <li><a class="list-link" href="CatalogoServlet?categoria=gadget">Gadget</a></li>
				        
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
                        // Se è amministratore, aggiungiamo il tasto Admin
                        if ("AMMINISTRATORE".equalsIgnoreCase(utenteLoggato.getRuolo())) {
                %>
                            <a class="single-link" href="PannelloAdmin.jsp" style="color: #e3350d; font-weight: bold;">Admin Panel</a>
                            <span>|</span>
                <%      } %>
                        <a class="single-link" href="Checkout.jsp">Checkout</a>
                        <span>|</span>
                        <a class="single-link" href="LogoutServlet">Logout</a>
                <% 
                    } else { 
                %>
                        <a class="single-link" href="Login.jsp">User</a>
                <% 
                    } 
                %>
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