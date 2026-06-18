<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	    	<div class="login hidden">
	    	<p class="user-title">Login</p>
	    		<form action="" method="">
	    			<span class="title-input">Email</span>
	    			<input class="input" type="email" name="email"  placeholder="email" required/>
	    			<span class="title-input">Password</span>
	    			<input class="input" type="password" name="password" placeholder="password" required/>
	    			<button class="btn">Log in</button>
	    		</form>
	    		<a id="link_register" class="redirect-link" href="#">Non hai un'account? Registrati</a>
	    	</div>
	    	
	    	<div class="register">
	    	<p class="user-title">Register</p>
	    		<form action="" method="">
	    			<span class="title-input">Nome</span>
	    			<input class="input" type="text" name="name"  placeholder="nome" required/>
	    			<span class="title-input">Cognome</span>
	    			<input class="input" type="text" name="surname"  placeholder="cognome" required/>
	    			<span class="title-input">Email</span>
	    			<input class="input" type="email" name="email"  placeholder="email" required/>
	    			<span class="title-input">Password</span>
	    			<input class="input" type="password" name="password" placeholder="password" required/>
	    			<button class="btn">Sign in</button>
	    		</form>
	    		<a id="link_login" class="redirect-link" href="#">Hai già un account? Accedi</a>
	    	</div>
    	</div>
    </main>
    
    <footer>
   		<span class="rights">PokéCave - All rights reserved</span>
    </footer>
    
    
	<script src="${pageContext.request.contextPath}/js/user.js"></script>
</body>
</html>