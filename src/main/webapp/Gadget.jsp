<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				    </ul>
				</div>	
                <script src="${pageContext.request.contextPath}/js/menu.js"></script>
                	
                <span>|</span>
                <a class="single-link" href="Wishlist.jsp">Whishlist</a>
                <span>|</span>
                <a class="single-link" href="Carrello.jsp">Carrello</a>
                <span>|</span>
                <a class="single-link" href="Login.jsp">User</a>
            </div>   
        </nav>
    </header>
    
    <main>
    	<div class="main-container">
    		<div class="grid">
    				<div class="grid-elements">
    					<div class="grid-element-img">
    						
    					</div>	
    					<div class="grid-element-footer">
    						
    						<img class="heart-normal" width="24" src="images/heart.svg" alt="heart"/>    
							<img class="heart-positive hidden" width="24" src="images/heart_positive.svg" alt="heart_positive"/>	
    						
    						<div class="name-product">Name product</div>
    						
    						<img width="24" class="cart" src="images/cart.svg" alt="cart"/>
    					</div>	
    				</div>
    				
    				<div class="grid-elements">
    					<div class="grid-element-img">
    						
    					</div>	
    					<div class="grid-element-footer">
    						
    						<img class="heart-normal" width="24" src="images/heart.svg" alt="heart"/>    
							<img class="heart-positive hidden" width="24" src="images/heart_positive.svg" alt="heart_positive"/>	
    						
    						<div class="name-product">Name product</div>
    						
    						<img width="24" class="cart" src="images/cart.svg" alt="cart"/>
    					</div>
    				</div>
    				
    				<div class="grid-elements">
    					<div class="grid-element-img">
    						
    					</div>	
    					<div class="grid-element-footer">
    						
    						<img class="heart-normal" width="24" src="images/heart.svg" alt="heart"/>    
							<img class="heart-positive hidden" width="24" src="images/heart_positive.svg" alt="heart_positive"/>	
    						
    						<div class="name-product">Name product</div>
    						
    						<img width="24" class="cart" src="images/cart.svg" alt="cart"/>
    					</div>
    				</div>
    				
    				<div class="grid-elements">
    					<div class="grid-element-img">
    						
    					</div>	
    					<div class="grid-element-footer">
    						
    						<img class="heart-normal" width="24" src="images/heart.svg" alt="heart"/>    
							<img class="heart-positive hidden" width="24" src="images/heart_positive.svg" alt="heart_positive"/>	
    						
    						<div class="name-product">Name product</div>
    						
    						<img width="24" class="cart" src="images/cart.svg" alt="cart"/>
    					</div>
    				</div>
    				
    				<div class="grid-elements">
    					<div class="grid-element-img">
    						
    					</div>	
    					<div class="grid-element-footer">
    						
    						<img class="heart-normal" width="24" src="images/heart.svg" alt="heart"/>    
							<img class="heart-positive hidden" width="24" src="images/heart_positive.svg" alt="heart_positive"/>	
    						
    						<div class="name-product">Name product</div>
    						
    						<img width="24" class="cart" src="images/cart.svg" alt="cart"/>
    					</div>
    				</div>
    				
    				<div class="grid-elements">
    					<div class="grid-element-img">
    						
    					</div>	
    					<div class="grid-element-footer">
    						
    						<img class="heart-normal" width="24" src="images/heart.svg" alt="heart"/>    
							<img class="heart-positive hidden" width="24" src="images/heart_positive.svg" alt="heart_positive"/>	
    						
    						<div class="name-product">Name product</div>
    						
    						<img width="24" class="cart" src="images/cart.svg" alt="cart"/>
    					</div>
    				</div>
    				
    				
    				
    		</div>
    		
    	</div>
    </main>
    
    <script src="${pageContext.request.contextPath}/js/box.js"></script>
    
    <footer>
    	<span class="rights">PokéCave - All rights reserved</span>
    </footer>
    
</body>
</html>