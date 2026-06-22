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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PokéCave</title>
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
				        <li><a class="list-link" href="CatalogoServlet">Shop</a></li>
				        <li><a class="list-link" href="CatalogoServlet?categoria=carte">Card</a></li>
				        <li><a class="list-link" href="CatalogoServlet?categoria=gadget">Gadget</a></li>
				        
				    </ul>
				</div>	
                <script src="${pageContext.request.contextPath}/js/menu.js"></script>
                	
              		
                <span>&nbsp|&nbsp</span>
                <a class="single-link" href="Carrello.jsp">Carrello</a>
                
                <span>&nbsp|&nbsp</span>
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
		    <a class="single-link" href="Login.jsp">User</a>
		<% } %>
            </div>   
            <div class="navbutton-container" id="navbutton-container">
				    <button class="navbutton" id="navbutton">
				        <img src="images/hamburger-icon.svg" alt="Menu">
				    </button>
				
				    <div class="dropdown hidden" id="dropdown">
				    	
				        <a href="CatalogoServlet" class="nav-link">Shop</a>
				        <a href="CatalogoServlet?categoria=carte" class="nav-link">Card</a>
				        <a href="CatalogoServlet?categoria=box" class="nav-link">Box</a>
				        <a href="CatalogoServlet?categoria=gadget" class="nav-link">Gadget</a>
				        <a href="Carrello.jsp"  class="nav-link">Carrello</a>
				        <% 
					    if (utenteLoggato != null) {
					    %>
					    	<a class="nav-link" href="<%= "admin".equals(utenteLoggato.getRuolo()) ? "admin/PannelloAdmin.jsp" : "Profilo.jsp" %>">
		        				<%= utenteLoggato.getNome() %>
		    				</a>
					    	<a href="Checkout.jsp" class="nav-link">Checkout</a>
					    	
					    	<a class="nav-link" href="LogoutServlet">Logout</a>
					    <%
					    	}else{
					    %>
				        <a href="Login.jsp" class="nav-link">User</a>
				        <%
					    	}
				        %>
				    </div>
				</div> 
        </nav>
    </header>
    
    <main>
    	<div class="main-container">
    		<div class="grid margin-product">
			<%
				Collection<Pokemon> prodotti = (Collection<Pokemon>) request.getAttribute("listaProdotti");
				
				if (prodotti != null && !prodotti.isEmpty()) {
					int contatoreBox = 0;
					for (Pokemon p : prodotti) {
						String nomeOriginale = p.getNome();
						String nomeMinuscolo = nomeOriginale.toLowerCase().trim();
						
						//mostriamo SOLO i prodotti che sono di tipo Box o Etb
						if (nomeMinuscolo.contains("box") || nomeMinuscolo.contains("etb")) {
							contatoreBox++;
							
							// RISOLUZIONE INTEGRALE 404 IMMAGINI: Mappatura esatta basata sui file reali
							String nomeFilePulito = "";
							String estensione = ".jpg"; // Struttura predefinita per i box su disco
							
							// Rimuove spazi vuoti interni, parentesi e diciture
							String senzaDettagli = nomeMinuscolo.replaceAll("\\(.*\\)", "");
							nomeFilePulito = senzaDettagli.replace(" ", "").trim();
			%>
					<div class="grid-elements">
						<div class="grid-element-img">
							<img src="images/<%= nomeFilePulito %><%= estensione %>" 
							     alt="<%= p.getNome() %>" 
							     onerror="this.src='images/poke.png'" 
							     width="100%">
						</div>	
						
						<div class="grid-element-footer">
							<%
								
								java.util.Set<Integer> wishlistCorrente = (java.util.Set<Integer>) session.getAttribute("wishlistIds");
								boolean isInWishlist = (wishlistCorrente != null && wishlistCorrente.contains(p.getId()));
							%>
						    

							<div class="name-product"><%= p.getNome() %> - €<%= String.format("%.2f", p.getPrezzo()) %></div>
							
							<a href="DettaglioProdottoServlet?id=<%= p.getId()%>" class="cart_shop" data-id="<%= p.getId() %>">
								<img width="24" class="cart" src="images/cart.svg" alt="cart"/>
							</a>
						</div>	
					</div>
			<%
						}
					}
					
					if (contatoreBox == 0) {
			%>
						<div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666; font-weight: bold;">
							<p>Nessun prodotto di tipo Box disponibile in questo momento.</p>
						</div>
			<%
					}
				} else {
			%>
				<div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666; font-weight: bold;">
					<p>Nessun prodotto disponibile nel catalogo.</p>
				</div>
			<%
				}
			%>
			</div>
    		
    	</div>
    </main>
    
    <script src="<%= request.getContextPath() %>/js/box.js?v=<%= System.currentTimeMillis() %>"></script>
    <script src="${pageContext.request.contextPath}/js/menu_responsive.js"></script>
    <script src="<%= request.getContextPath() %>/js/add-shop.js?v=<%= System.currentTimeMillis() %>"></script>
	<script src="<%= request.getContextPath() %>/js/buy-item.js?v=<%= System.currentTimeMillis() %>"></script>
    
    <footer>
    	<span class="rights">PokéCave - All rights reserved</span>
    </footer>
    
</body>
</html>
