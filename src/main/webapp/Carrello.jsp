<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
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
                <a class="single-link" href="#">Carrello</a>
                <span>|</span>
                <a class="single-link" href="Login.jsp">User</a>
            </div>   
        </nav>
    </header>
    
    <main>
    	<div class="main-container">
    		<div class="container-cart">
    			<div class="carrello">
    				<div class="single-cart-element">
    					<div class="img-single-cart-element"></div>
    					<div class="info-single-cart-element">
	    					<div class="title-single-cart-element">Titolo</div>
	    					<div class="counter-single-cart-element">
	    						<div class="menus">-</div>
	    						<div class="quantity">#</div>
	    						<div class="plus">+</div>
	    					</div>
	    					
    					</div>
    					<div class="container-price">
    						<div class="prezzo-scontrino">Prezzo: _ _ _ _ _ _</div>
    					</div>
    					
    				</div>
    				<div class="single-cart-element">
    					<div class="img-single-cart-element"></div>
    					<div class="info-single-cart-element">
	    					<div class="title-single-cart-element">Titolo</div>
	    					<div class="counter-single-cart-element">
	    						<div class="menus">-</div>
	    						<div class="quantity">#</div>
	    						<div class="plus">+</div>
	    					</div>
	    					
    					</div>
    					<div class="container-price">
    						<div class="prezzo-scontrino">Prezzo: _ _ _ _ _ _</div>
    					</div>
    					
    				</div>
	    		</div>
	    		<div class="scontrino">
	    			<p class="title-scontrino">Totale complessivo</p>
	    			<span class="prezzo-scontrino">_ _ _ _ _</span>
	    			<button class="confirm-scontrino">Conferma</button>
	    		</div>
    		</div>
    		
    	</div>
    </main>
    
    <footer>
    	<span class="rights">PokéCave - All rights reserved</span>
    </footer>
    
    <script src="${pageContext.request.contextPath}/js/carosello.js"></script>
</body>
</html>
