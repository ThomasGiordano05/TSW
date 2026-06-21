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
      
      	<a>
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
    		<div class="slide">
    			<button class="left-changer">
    				<img width="24" src="images/arrow-left.svg" alt="arrow-left"/>	
    			</button>
    			<button class="right-changer">
    				<img width="24" src="images/arrow-right.svg" alt="arrow-right"/>	
    			</button>
    			<img class="slide-img active" src="https://federicstore.it/wp-content/uploads/2025/09/Peluches-federicstore-banner-Desktop-Nuovo.webp"/>
    			<img class="slide-img" src="https://federicstore.it/wp-content/uploads/2026/05/Buio-Pesto-banner-Desktop-federicstore.webp"/>
    		    <img class="slide-img" src="https://federicstore.it/wp-content/uploads/2026/03/Banner-Gift-Card-federicstore-Desktop.png"/>
    		    <img class="slide-img" src="https://federicstore.it/wp-content/uploads/2025/09/Merch-federicstore-banner-Desktop-Nuovo.webp"/>
    			
    			
    			
    		
    		</div>
    		<div class="dots-container">
				    <div class="dot active-dot"></div>
				    <div class="dot"></div>
				    <div class="dot"></div>
				    <div class="dot"></div>
			</div>
    	</div>
    </main>
    
    <footer>
    	<span class="rights">PokéCave - All rights reserved</span>
    </footer>
    
    <script src="${pageContext.request.contextPath}/js/carosello.js"></script>
</body>
</html>
