<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.Collection" %>
<%@ page import="model.Pokemon" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/Style.css?v=<%= System.currentTimeMillis() %>">
    <meta charset="UTF-8">
    <title>PokéCave | Carte Collezionabili</title>
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
        </nav>
    </header>
    
    <main>
    	<div class="main-container">
    		<div class="grid">
			<%
				// Recuperiamo la lista passata regolarmente dalla CatalogoServlet
				Collection<Pokemon> prodotti = (Collection<Pokemon>) request.getAttribute("listaProdotti");
				
				if (prodotti != null && !prodotti.isEmpty()) {
					int contatoreCard = 0;
					
					for (Pokemon p : prodotti) {
						String nomeOriginale = p.getNome();
						if (nomeOriginale == null) continue;
						
						String nomeMinuscolo = nomeOriginale.toLowerCase().trim();
						
						// Visualizziamo il prodotto se contiene "card" o fa parte del tipo corretto
						if (nomeMinuscolo.contains("card") || (p.getTipo() != null && p.getTipo().toLowerCase().contains("cart"))) {
							contatoreCard++;
							
							String nomeFilePulito = nomeMinuscolo.replace(" ", "").trim();
							if (nomeFilePulito.equals("cardpikachuex238")) {
								nomeFilePulito = "cardpikaex238";
							}
			%>
					<div class="grid-elements">
						<div class="grid-element-img">
							<img src="images/<%= nomeFilePulito %>.jpg" 
							     alt="<%= p.getNome() %>" 
							     onerror="this.src='images/poke.png'" 
							     width="100%">
						</div>	
						
						<div class="grid-element-footer">
							<%
								java.util.Set<Integer> wishlistCorrente = (java.util.Set<Integer>) session.getAttribute("wishlistIds");
								boolean isInWishlist = (wishlistCorrente != null && wishlistCorrente.contains(p.getId()));
							%>
						    <a href="javascript:void(0);" class="wishlist-toggle" data-id="<%= p.getId() %>">
						        <img class="heart-normal <%= isInWishlist ? "hidden" : "" %>" width="24" src="images/heart.svg" alt="heart"/>    
						        <img class="heart-positive <%= isInWishlist ? "" : "hidden" %>" width="24" src="images/heart_positive.svg" alt="heart_positive"/>
						    </a>

							<div class="name-product"><%= p.getNome() %> - €<%= String.format("%.2f", p.getPrezzo()) %></div>
							
							<a href="DettaglioProdottoServlet?id=<%= p.getId()%>" class="cart_shop" data-id="<%= p.getId() %>">
								<img width="24" class="cart" src="images/cart.svg" alt="cart"/>
							</a>
						</div>	
					</div>
			<%
						}
					}
					
					if (contatoreCard == 0) {
			%>
						<div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666; font-weight: bold;">
							<p>Nessuna Card trovata nel catalogo.</p>
						</div>
			<%
					}
				} else {
			%>
				<div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666; font-weight: bold;">
					<p>Nessun prodotto disponibile. Accedi tramite il menu Shop per caricare i dati dal Database.</p>
				</div>
			<%
				}
			%>
			</div>
    	</div>
    </main>
    
    <script src="<%= request.getContextPath() %>/js/box.js?v=<%= System.currentTimeMillis() %>"></script>
    <script src="<%= request.getContextPath() %>/js/add-shop.js?v=<%= System.currentTimeMillis() %>"></script>
	<script src="<%= request.getContextPath() %>/js/buy-item.js?v=<%= System.currentTimeMillis() %>"></script>
    
    <footer>
    	<span class="rights">PokéCave - All rights reserved</span>
    </footer>
</body>
</html>