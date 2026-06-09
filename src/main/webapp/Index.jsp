<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Style.css?v=2">
    <meta charset="UTF-8">
    <title>POKECAVE</title>
</head>
<body>

    <div class="hero-banner">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Pokémon Background" class="hero-image">
        
        <div class="hero-content-container">
            <div class="hero-content">
                <h1 class="welcome">WELCOME IN THE CAVE</h1>
                
            </div>
        </div>
    </div>
    
     <nav class="navbar">
    
        <div class="nav-logo">POKECAVE</div>
        <ul class="nav-links">
            <li><a href="#">HOME</a></li>
            <li><a href="#">CHI SIAMO</a></li>
            <li><a href="#">CATALOGO</a></li>
            <li><a href="#">ASSISTENZA</a></li>
        </ul>
    </nav>
   <div class="cerca-section">
    <form class="cerca-container" action="CercaProdottoServlet" method="GET" >
    <div class="pokeball-icon"></div>
        <input class="cerca-input" type="text" name="testoCercato" placeholder="Cerca Prodotto" required autocomplete="off">
        <button class="cerca-button" type="submit" >Search</button>
    </form>
       </div>
    <footer class="main-footer">
        <p>&copy; 2026 POKECAVE. All rights reserved. Tutti i marchi e i Pokémon appartengono a Nintendo/Game Freak.</p>
    </footer>

</body>
</html>
