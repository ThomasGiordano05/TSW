<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.Collection" %>
<%@ page import="model.Pokemon" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="css/Style.css?v=<%= System.currentTimeMillis() %>">
	<meta charset="UTF-8">
	<title>PokéCave</title>
</head>
<body>
	<header class="navbar">
        <nav>
            <div class="link">
                <a href="Index.jsp">
                    <img class="logo" src="images/poke.png" alt="poke"/>
                </a>

                <a class="single-link" href="CatalogoServlet" id="shop">Shop</a>

                <div id="shop-block" class="hidden">
                    <ul>
                        <li><a class="list-link" href="CatalogoServlet?categoria=Card">Card</a></li>
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
			<form class="cerca-container" action="CercaProdottoServlet" method="GET">
				<div class="pokeball-icon"></div>
				<input id="barraRicerca" class="cerca-input" type="text" name="testoCercato" placeholder="Cerca Prodotto" required autocomplete="off">
				
				<div id="risultati-suggerimenti" class="suggerimenti-box"></div>
				
				<script src="${pageContext.request.contextPath}/js/search.js?v=<%= System.currentTimeMillis() %>"></script>
			</form>
			
			<div class="grid">
			<%
				Collection<Pokemon> prodotti = (Collection<Pokemon>) request.getAttribute("listaProdotti");
				
				if (prodotti != null && !prodotti.isEmpty()) {
					for (Pokemon p : prodotti) {
			%>
					<div class="grid-elements">
						<div class="grid-element-img">
							<img src="<%= p.getUrlImmagine() %>" 
							     alt="<%= p.getNome() %>" 
							     onerror="this.src='images/poke.png'" 
							     width="100%">						
							     
							     </div>	
						<div class="grid-element-footer">
							<img class="heart-normal" width="24" src="images/heart.svg" alt="heart"/>    
							<img class="heart-positive hidden" width="24" src="images/heart_positive.svg" alt="heart_positive"/>

							<div class="name-product"><%= p.getNome() %> - €<%= String.format("%.2f", p.getPrezzo()) %></div>
							
							<a href="javascript:void(0);" class="cart_shop" data-id="<%= p.getId() %>">
								<img width="24" class="cart" src="images/cart.svg" alt="cart"/>
							</a>
						</div>	
					</div>
			<%
					}
				} else {
			%>
				<div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666; font-weight: bold;">
					<p>Nessun prodotto disponibile nel catalogo o corrispondente alla ricerca in questo momento.</p>
				</div>
			<%
				}
			%>
			</div> 
		</div> 
	</main>
	
	<script src="${pageContext.request.contextPath}/js/box.js"></script>
	<script src="${pageContext.request.contextPath}/js/cart.js"></script>
	
	<footer>
		<span class="rights">PokéCave - All rights reserved</span>
	</footer>
</body>
</html>