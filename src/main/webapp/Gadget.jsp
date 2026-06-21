<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.Pokemon" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/Style.css?v=<%= System.currentTimeMillis() %>">
    <meta charset="UTF-8">
    <title>PokéCave - Box</title>
</head>
<body>
    <main>
        <div class="main-container">
            <div style="text-align: right; padding: 20px;">
                <a href="Carrello.jsp"><img src="images/cart.svg" width="30" alt="Vai al carrello"></a>
            </div>

            <h1 style="text-align: center;">Catalogo Box</h1>
            
            <div class="grid">
            <%
                Collection<Pokemon> prodotti = (Collection<Pokemon>) request.getAttribute("listaProdotti");
                boolean trovato = false;
                
                if (prodotti != null) {
                    for (Pokemon p : prodotti) {
                        // FILTRO: Mostra solo se il tipo è 'box'
                        if ("gadget".equalsIgnoreCase(p.getTipo())) {
                            trovato = true;
            %>
                    <div class="grid-elements">
                        <div class="grid-element-img">
                            <img src="<%= p.getUrlImmagine() %>" alt="<%= p.getNome() %>" onerror="this.src='images/poke.png'" width="100%">
                        </div> 
                        <div class="grid-element-footer">
                            <div class="name-product"><%= p.getNome() %> - €<%= String.format("%.2f", p.getPrezzo()) %></div>
                            <a href="javascript:void(0);" class="cart_shop" data-id="<%= p.getId() %>">
                                <img width="24" class="cart" src="images/cart.svg" alt="cart"/>
                            </a>
                        </div>  
                    </div>
            <%
                        }
                    }
                }
                if (!trovato) {
            %>
                <p>Nessun box disponibile al momento.</p>
            <% } %>
            </div> 
        </div> 
    </main>
    <script src="${pageContext.request.contextPath}/js/cart.js"></script>
</body>
</html>