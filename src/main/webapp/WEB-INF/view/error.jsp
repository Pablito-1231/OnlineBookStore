<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Librería Online</title>
    
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Nunito', sans-serif;
        }
        
        .error-container {
            background: white;
            border-radius: 20px;
            padding: 50px;
            max-width: 600px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            text-align: center;
        }
        
        .error-icon {
            font-size: 80px;
            color: #e74c3c;
            margin-bottom: 20px;
        }
        
        .error-title {
            font-size: 32px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 15px;
        }
        
        .error-message {
            font-size: 18px;
            color: #7f8c8d;
            margin-bottom: 30px;
        }
        
        .error-details {
            background: #f8f9fa;
            border-left: 4px solid #e74c3c;
            padding: 15px;
            text-align: left;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        
        .btn-home {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 12px 40px;
            border-radius: 25px;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.3s;
        }
        
        .btn-home:hover {
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>

    <div class="error-container">
        <i class="fas fa-exclamation-triangle error-icon"></i>
        
        <h1 class="error-title">¡Ups! Algo salió mal</h1>
        
        <p class="error-message">
            <c:out value="${errorMessage}" default="Ha ocurrido un error inesperado" />
        </p>
        
        <c:if test="${not empty errorDetails}">
            <div class="error-details">
                <strong>Detalles:</strong><br>
                <c:out value="${errorDetails}" />
            </div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/" class="btn-home">
            <i class="fas fa-home"></i> Volver al Inicio
        </a>
    </div>

</body>
</html>
