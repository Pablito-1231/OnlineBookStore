<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Inicio</title>
</head>

<body>

<h2>¡Bienvenido a la página principal!</h2>

<form:form method="POST" action="${pageContext.request.contextPath}/logout">
    <input type="submit" value="Cerrar sesión" />
</form:form>

</body>
</html>
