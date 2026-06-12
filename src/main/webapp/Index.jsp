<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/Style.css">
    <meta charset="UTF-8">
    <title>PokéCave</title>
</head>
<body>
    <header class="navbar">
      
        <img class="logo" src="images/poke.png" alt="poke"/>
        
        <nav>
            <div class="link">
                <a class="single-link" href="#" id="shop">Shop</a>
              
                <span>|</span>
                <a class="single-link" href="#">Whishlist</a>
                <span>|</span>
                <a class="single-link" href="#">Carrello</a>
                <span>|</span>
                <a class="single-link" href="#">User</a>
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
    			<img class="slide-img active" src="images/pik.png" alt="pikachu"/>
    			<img class="slide-img" src="images/gliscor.png" alt="gliscor"/>
    		    <img class="slide-img" src="images/Meganium.png" alt="Meganium"/>
    		    <img class="slide-img" src="images/arcanine.png" alt="arcanine"/>
    		
    		</div>
    	</div>
    </main>
    
    <footer>
    	<div class="footer">
	    	<div class="Thomas-contact">
	    		Thomas
	    	</div>
	    	<div class="Alessandro-contact">
	    		Alessandro
	    	</div>
    	</div>
    
    	<span class="right">PokéCave - All rights reserved</span>
    </footer>
    <script src="${pageContext.request.contextPath}/js/carosello.js"></script>
</body>
</html>
