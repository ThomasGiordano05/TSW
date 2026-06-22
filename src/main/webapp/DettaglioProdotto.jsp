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
    <title>
        <%= (request.getAttribute("prodotto") != null) ? ((model.Pokemon)request.getAttribute("prodotto")).getNome() : "Prodotto non trovato" %>
    </title>
</head>
<body>
    <header class="navbar">
      
      	<a href="#">
      		<img class="logo" src="images/poke.png" alt="poke"/>
      	</a>
        
        <nav>
            <div class="link">
                <a class="single-link" href="#" id="shop">Shop</a>

				<div id="shop-block" class="hidden">
				    <ul>
				        <li><a class="list-link" href="CatalogoServlet?categoria=carte">Card</a></li>
				        <li><a class="list-link" href="CatalogoServlet?categoria=box">Box</a></li>
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
				    <span>&nbsp|&nbsp</span>
				    <a class="single-link" href="Checkout.jsp">Checkout</a>
				    <span>&nbsp|&nbsp</span>
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
    	<div class="main-container container-product-dettaglio">
            <%
                //recuperiamo il prodotto impostato dalla Servlet di dettaglio
                Pokemon p = (Pokemon) request.getAttribute("prodotto");
                
                if (p != null) {
                    String nomeOriginale = p.getNome();
                    String nomeMinuscolo = (nomeOriginale != null) ? nomeOriginale.toLowerCase().trim() : "";
                    
                    //pulizia del nome per l'immagine coerente con la logica locale
                    String nomeFilePulito = nomeMinuscolo.replace(" ", "").trim();
                    if (nomeFilePulito.equals("cardpikachuex238")) {
                        nomeFilePulito = "cardpikaex238";
                    }
            %>
                    <div class="dettaglio-prodotto-container">
                        <div class="title-product-dettaglio">
                            <h1><%= p.getNome() %></h1>
                        </div>
                        
                        <div class="image-product-dettaglio">
                            <img src="images/<%= nomeFilePulito %>.jpg" 
                                 alt="<%= p.getNome() %>" 
                                 onerror="this.src='images/poke.png'">
                        </div>
                        
                        <div class="descrizione-product-dettaglio">
                            <p><%= (p.getDescrizione() != null) ? p.getDescrizione() : "Nessuna descrizione disponibile per questo articolo." %></p>
                        </div>
                        
                        <div class="prezzo-product-dettaglio">
                            Prezzo: €<%= String.format("%.2f", p.getPrezzo()) %>
                        </div>
                        
                        <button class="acquista-product-dettaglio cart_shop" data-id="<%= p.getId() %>">
                            Acquista Ora
                        </button>
                    </div>
            <%
                } else {
            %>
                    <div style="text-align: center; padding: 40px; color: #666; font-weight: bold;">
                        <p>Prodotto non trovato. Assicurati di aver selezionato un articolo valido.</p>
                    </div>
            <%
                }
            %>
    	</div>
    </main>
    
    <footer>
    	<span class="rights">PokéCave - All rights reserved</span>
    </footer>
    
    <script src="${pageContext.request.contextPath}/js/box.js"></script>
    <script src="${pageContext.request.contextPath}/js/cart.js"></script>
    
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        const btnAcquista = document.querySelector(".acquista-product-dettaglio");
        
        if (btnAcquista) {
            btnAcquista.addEventListener("click", function() {
                // Lasciamo un piccolissimo delay (200ms) per dare il tempo a add-shop.js 
                // di completare la chiamata AJAX (Fetch/Post) prima di cambiare pagina
                setTimeout(function() {
                    window.location.href = "Carrello.jsp";
                }, 200);
            });
        }
    });
    </script>
   	<script src="${pageContext.request.contextPath}/js/menu_responsive.js"></script>
</body>
</html>