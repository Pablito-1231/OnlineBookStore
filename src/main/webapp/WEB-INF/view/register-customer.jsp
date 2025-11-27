<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="es">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Registro</title>

    <!-- Bootstrap 5 local -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <!-- Estilos modernos -->
  <link type="text/css" href="${pageContext.request.contextPath}/css/forms-modern.css" rel="stylesheet">

</head>

<body class="form-page">

  <div class="form-container">

    <!-- Lado izquierdo - Imagen decorativa -->
    <div class="form-image-side">
      <div class="image-content">
        <div class="form-image-icon">
          <i class="fas fa-book-reader"></i>
        </div>
        <h2 class="form-image-title">Únete a Nuestra Comunidad</h2>
        <p class="form-image-text">
          Descubre miles de libros, accede a ofertas exclusivas y vive nuevas aventuras literarias.
          Regístrate ahora y comienza tu viaje en el mundo de los libros.
        </p>
      </div>
    </div>

    <!-- Lado derecho - Formulario -->
    <div class="form-content-side">
      
      <div class="form-header">
        <h2>Crear Cuenta Nueva</h2>
        <p>Completa tus datos para registrarte</p>
      </div>

      <!-- Mensajes -->
      <c:if test="${message != null}">
        <div class="form-alert success">
          <i class="fas fa-check-circle"></i>
          <span><c:out value="${message}"/></span>
        </div>
      </c:if>

      <!-- Formulario de registro -->
      <form:form action="${pageContext.request.contextPath}/register/customer" method="POST" modelAttribute="customerData">
        <!-- Token CSRF -->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

        <div class="form-row">
          <div class="form-group">
            <label>Nombre</label>
            <div class="input-wrapper">
              <i class="fas fa-user input-icon"></i>
              <form:input type="text" class="form-control-modern" path="firstName" placeholder="Tu nombre" required="required"/>
            </div>
          </div>

          <div class="form-group">
            <label>Apellido</label>
            <div class="input-wrapper">
              <i class="fas fa-user input-icon"></i>
              <form:input type="text" class="form-control-modern" path="lastName" placeholder="Tu apellido" required="required"/>
            </div>
          </div>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label>Correo Electrónico</label>
            <div class="input-wrapper">
              <i class="fas fa-envelope input-icon"></i>
              <form:input type="email" class="form-control-modern" path="email" placeholder="correo@ejemplo.com" required="required"/>
            </div>
          </div>

          <div class="form-group">
            <label>Teléfono Móvil</label>
            <div class="input-wrapper">
              <i class="fas fa-phone input-icon"></i>
              <form:input type="tel" class="form-control-modern" path="mobile" placeholder="Tu número" required="required"/>
            </div>
          </div>
        </div>

        <div class="form-group">
          <label>Dirección</label>
          <div class="input-wrapper">
            <i class="fas fa-map-marker-alt input-icon"></i>
            <form:input type="text" class="form-control-modern" path="address" placeholder="Tu dirección completa" required="required"/>
          </div>
        </div>

        <div class="form-group">
          <label>Nombre de Usuario</label>
          <div class="input-wrapper">
            <i class="fas fa-at input-icon"></i>
            <form:input type="text" class="form-control-modern" path="username" placeholder="Elige un nombre de usuario" required="required"/>
          </div>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label>Contraseña</label>
            <div class="input-wrapper">
              <i class="fas fa-lock input-icon"></i>
              <form:input type="password" class="form-control-modern" path="password" placeholder="••••••••" required="required"/>
            </div>
          </div>

          <div class="form-group">
            <label>Confirmar Contraseña</label>
            <div class="input-wrapper">
              <i class="fas fa-lock input-icon"></i>
              <form:input type="password" class="form-control-modern" path="confirmPassword" placeholder="••••••••" required="required"/>
            </div>
          </div>
        </div>

        <form:input type="hidden" path="role" value="ROLE_CUSTOMER"/>

        <button type="submit" class="btn-modern">
          <i class="fas fa-user-plus"></i> Crear Mi Cuenta
        </button>

      </form:form>

      <div class="form-divider">
        <span>¿Ya tienes cuenta?</span>
      </div>

      <div class="form-link">
        <a href="${pageContext.request.contextPath}/login">
          <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
        </a>
      </div>

    </div>

  </div>

  <!-- Scripts Bootstrap -->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
