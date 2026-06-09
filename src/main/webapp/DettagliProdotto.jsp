<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    
    <title>
        <%= (request.getAttribute("prodotto") != null) ? ((model.Pokemon)request.getAttribute("prodotto")).getNome() : "Prodotto non trovato" %>
    </title>
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Style.css?v=2">
</head>
<body>
    
</body>
</html>