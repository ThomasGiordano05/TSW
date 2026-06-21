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
    <title>PokéCave | Gadget</title>
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
                <script src="<%= request.getContextPath() %>/js/menu.js"></script>
                	
                <span>|</span>
                <a class="single-link" href="Wishlist.jsp">Wishlist</a>
                <span>|</span>
                <a class="single-link" href="Carrello.jsp">Carrello</a>
                
                <% 
			    Utente utenteLoggato = (Utente) session.getAttribute("utente");
			    if (utenteLoggato != null) { 
			    	if ("admin".equalsIgnoreCase(utenteLoggato.getRuolo())) {
		        %>
		                    <span>|</span>
		                    <a class="single-link" href="PannelloAdmin.jsp" style="color: #e3350d; font-weight: bold;">Admin Panel</a>
		        <% 
		                    }
		        %>
			    <span>|</span>
			    <a class="single-link" href="Checkout.jsp">Checkout</a>
			    <span>|</span>
			    <a class="single-link" href="LogoutServlet">Logout</a>
			<% } else { %>
			    <span>|</span>
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
					int contatoreGadget = 0;
					
					for (Pokemon p : prodotti) {
						String nomeOriginale = p.getNome();
						if (nomeOriginale == null) continue;
						
						String nomeMinuscolo = nomeOriginale.toLowerCase().trim();
						
						// FILTRO: Mostra il prodotto se il tipo è 'gadget' o se il nome contiene 'gadget'
						if ("gadget".equalsIgnoreCase(p.getTipo()) || nomeMinuscolo.contains("gadget")) {
							contatoreGadget++;
							
							// Generazione del nome file immagine pulito come in card.jsp (es. "peluche pikachu" -> "peluchepikachu.jpg")
							String nomeFilePulito = nomeMinuscolo.replace(" ", "").trim();
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
							
							<a href="javascript:void(0);" class="cart_shop" data-id="<%= p.getId() %>">
								<img width="24" class="cart" src="images/cart.svg" alt="cart"/>
							</a>
						</div>	
					</div>
			<%
						}
					}
					
					if (contatoreGadget == 0) {
			%>
						<div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #666; font-weight: bold;">
							<p>Nessun Gadget trovato nel catalogo.</p>
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
    <script src="<%= request.getContextPath() %>/js/buy-item.js?v=<%= System.currentTimeMillis() %>"></script>
    
    <footer>
    	<span class="rights">PokéCave - All rights reserved</span>
    </footer>
</body>
</html>