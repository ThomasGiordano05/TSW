<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.Utente" %>
<%@ page import="model.Pokemon" %>
<%@ page import="model.Carrello" %>
<%@ page import="model.ArticoloCarrello" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/Style.css?v=<%= System.currentTimeMillis() %>">
    <meta charset="UTF-8">
    <title>PokéCave - Il tuo Carrello</title>
    <script>const contextPath = "${pageContext.request.contextPath}";</script>
</head>
<body>
<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>
    <header class="navbar">
        <a href="Index.jsp"><img class="logo" src="images/poke.png" alt="poke"/></a>
        <nav>
            <div class="link">
                <a class="single-link" href="CatalogoServlet">Shop</a>
                <span>|</span>
                <a class="single-link" href="Wishlist.jsp">Wishlist</a>
                <span>|</span>
                <a class="single-link" href="Carrello.jsp">Carrello</a>
                <span>|</span>
                <% 
                    Utente utenteLoggato = (Utente) session.getAttribute("utente");
                    if (utenteLoggato != null) { 
                %>
                    <a class="single-link" href="Profilo.jsp"><%= utenteLoggato.getNome() %></a>
                    <span>|</span>
                    <a class="single-link" href="LogoutServlet">Logout</a>
                <% } else { %>
                    <a class="single-link" href="Login.jsp">Accedi / Registrati</a>
                <% } %>
            </div>
        </nav>
    </header>

    <main>
        <div class="main-container">
            <div class="container-cart">
                <div class="carrello">
                <% 
                    Carrello cart = (Carrello) session.getAttribute("carrello");
                    if (cart != null && cart.getArticoli() != null && !cart.getArticoli().isEmpty()) {
                        for (ArticoloCarrello art : cart.getArticoli()) {
                            Pokemon p = art.getPokemon();
                %>
                    <div class="single-cart-element">
                        <div class="img-single-cart-element">
                            <img src="images/<%= p.getNome().toLowerCase() %>.png" alt="<%= p.getNome() %>" width="80" onerror="this.src='images/poke.png'">
                        </div>
                        <div class="info-single-cart-element">
                            <div class="title-single-cart-element"><%= p.getNome() %></div>
                            
                            <div class="counter-single-cart-element">
                                <button type="button" class="btn-qty menus" data-id="<%= p.getId() %>" data-action="minus">-</button>
                                <div class="quantity quantity-value"><%= art.getquantitaScelta() %></div>
                                <button type="button" class="btn-qty plus" data-id="<%= p.getId() %>" data-action="plus">+</button>
                            </div>
                            </div>
                        <div class="container-price">
                            <div class="prezzo-scontrino prezzo-unitario-fisso">Prezzo: €<%= art.getPrezzoUnitario() %></div>
                        </div>
                    </div>
                <% 
                        }
                    } else {
                %>
                    <div class="single-cart-element">
                        <p>Il carrello è vuoto.</p>
                    </div>
                <% } %>
                </div>

                <div class="scontrino">
                    <p class="title-scontrino">Totale complessivo</p>
                    <span class="prezzo-scontrino" id="totale-complessivo">€<%= (cart != null) ? cart.getTotale() : 0.0 %></span>
                    <button class="confirm-scontrino" onclick="window.location.href='Checkout.jsp'">Conferma</button>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <span class="rights">PokéCave - All rights reserved</span>
    </footer>
    <script src="js/add-shop.js"></script>
</body>
</html>