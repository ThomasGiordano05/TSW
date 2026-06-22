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
                <a class="single-link" href="#">User</a>
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
				    </div>
				</div> 
        </nav>
    </header>
    
     <main>
<<<<<<< Updated upstream
<div class="main-container">
	<div class="login hidden">
	    <p class="user-title">Login</p>
	    <form action="LoginServlet" method="post">
	        <span class="title-input">Email</span>
	        <input class="input" type="email" name="email" placeholder="email" required/>
	        <span class="title-input">Password</span>
	        <input class="input" type="password" name="password" placeholder="password" required/>
	        <button class="btn">Log in</button>
	    </form>
	    <a id="link_register" class="redirect-link" href="#">Non hai un'account? Registrati</a>
	</div>

<div class="register">
    <p class="user-title">Register</p>
    <form action="RegistrazioneServlet" method="post">
        <span class="title-input">Nome</span>
        <input class="input" type="text" name="name" placeholder="nome" required/>
        
        <span class="title-input">Cognome</span>
        <input class="input" type="text" name="surname" placeholder="cognome" required/>
        
        <span class="title-input">Email</span>
        <input class="input" type="email" name="email" placeholder="email" required/>
        
        <span class="title-input">Password</span>
        <input class="input" type="password" name="password" placeholder="password" required/>
        
        <button class="btn">Sign in</button>
    </form>
    <a id="link_login" class="redirect-link" href="#">Hai già un account? Accedi</a>
</div>
=======
     	<div class="main-container">
     	 
			
			<div class="login hidden">
			    <p class="user-title">Login</p>
			    <form action="LoginServlet" method="post">
			        <span class="title-input">Email</span>
			        <input class="input" type="email" name="email" placeholder="email" required/>
			        <span class="title-input">Password</span>
			        <input class="input" type="password" name="password" placeholder="password" required/>
			        <button class="btn">Log in</button>
			    </form>
			    <a id="link_register" class="redirect-link" href="#">Non hai un'account? Registrati</a>
			</div>
			
			<div class="register">
			    <p class="user-title">Register</p>
			    <form action="RegistrazioneServlet" method="post">
			        <span class="title-input">Nome</span>
			        <input class="input" type="text" name="name" placeholder="nome" required/>
			        
			        <span class="title-input">Cognome</span>
			        <input class="input" type="text" name="surname" placeholder="cognome" required/>
			        
			        <span class="title-input">Email</span>
			        <input class="input" type="email" name="email" placeholder="email" required/>
			        
			        <span class="title-input">Password</span>
			        <input class="input" type="password" name="password" placeholder="password" required/>
			        
			        <button class="btn">Sign in</button>
			    </form>
			    <a id="link_login" class="redirect-link" href="#">Hai già un account? Accedi</a>
			</div>
>>>>>>> Stashed changes
    	
    	
    </main>
    
    <footer>
   		<span class="rights">PokéCave - All rights reserved</span>
    </footer>
    
    <script src="${pageContext.request.contextPath}/js/menu_responsive.js"></script>
	<script src="${pageContext.request.contextPath}/js/user.js"></script>
</body>
</html>