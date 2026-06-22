<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Utente" %>
<%@ page import="model.Carrello" %>
<%@ page import="model.ArticoloCarrello" %>
<%
    //solo gli utenti loggati possono fare il checkout
    Utente utente = (Utente) session.getAttribute("utente");
    Carrello cart = (Carrello) session.getAttribute("carrello");
    
    if (utente == null) {
        response.sendRedirect("Login.jsp?errore=nologin");
        return;
    }
    //se il carrello è vuoto o inesistente, rimanda allo shop
    if (cart == null || cart.getArticoli().isEmpty()) {
        response.sendRedirect("CatalogoServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/Style.css?v=<%= System.currentTimeMillis() %>">
    <meta charset="UTF-8">
    <title>Pok&eacute;Cave - Checkout Sicuro</title>
    
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
    	<div class="main-container">
    		<div class="checkout-container">
            
            <div class="checkout-form">
                <h2>Dettagli Spedizione e Pagamento</h2>
                
                <%
                    String errore = request.getParameter("error");
                    if (errore != null) {
                %>
                    <div style="background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 12px; margin-bottom: 20px; border-radius: 5px; font-family: sans-serif; font-weight: bold;">
                        ❌ Errore d'acquisto: 
                        <% if(errore.equals("campivuoti")) { %>
                            Assicurati di aver compilato tutti i campi.
                        <% } else if(errore.equals("transazione_fallita")) { %>
                            Il Database ha rifiutato l'ordine. Controlla la console dell'IDE!
                        <% } else { %>
                            <%= errore %>
                        <% } %>
                    </div>
                <% } %>

                <form action="CheckoutServlet" method="POST">
                    
                    <h3>Indirizzo di Consegna</h3>
                    
                    
                    <div class="form-group">
                        <label>Indirizzo (Via e Civico)</label>
                        <input type="text" name="indirizzo" required placeholder="Es. Via Roma, 10">
                    </div>
                    <div class="form-group" style="display: flex; gap: 10px;">
                        <div style="flex: 2;"><label>Citt&agrave;</label><input type="text" name="citta" required></div>
                        <div style="flex: 1;"><label>CAP</label><input type="text" name="cap" required pattern="[0-9]{5}"></div>
                    </div>

                    <h3 style="margin-top: 30px;">Metodo di Pagamento (Simulazione)</h3>
                    <div class="form-group">
                        <label>Titolare Carta</label>
                        <input type="text" name="titolare" value="<%= utente.getNome() %> <%= utente.getCognome() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Numero Carta</label>
                        <input type="text" name="numero_carta" placeholder="1234 5678 9101 1121" required pattern="[0-9\s]{16,19}">
                    </div>
                    <div class="form-group" style="display: flex; gap: 10px;">
                        <div><label>Scadenza</label><input type="text" name="scadenza" placeholder="MM/AA" required></div>
                        <div><label>CVV</label><input type="text" name="cvv" placeholder="123" required pattern="[0-9]{3}"></div>
                    </div>

                    <button type="submit" class="btn-pay">Paga € <%= String.format("%.2f", cart.getTotale()) %> e Completa Ordine</button>
                </form>
            </div>

            <div class="checkout-summary">
                <h3>Riepilogo Ordine</h3>
                <% for (ArticoloCarrello art : cart.getArticoli()) { %>
                    <div class="summary-item">
                        <span><%= art.getquantitaScelta() %>x <%= art.getPokemon().getNome() %></span>
                        <span>€ <%= String.format("%.2f", art.getPrezzoTotaleArticolo()) %></span>
                    </div>
                <% } %>
                <h2 style="text-align: right; margin-top: 20px;">Totale: € <%= String.format("%.2f", cart.getTotale()) %></h2>
            </div>

        </div>
    	</div>
        
    </main>
    <footer>
    	<span class="rights">PokéCave - All rights reserved</span>
    </footer>
       	<script src="${pageContext.request.contextPath}/js/menu_responsive.js"></script>
</body>
</html>