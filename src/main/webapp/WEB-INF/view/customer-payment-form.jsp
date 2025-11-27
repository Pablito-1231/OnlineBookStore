<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="es">

<head>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>Refugio Literario</title>

  <!-- Bootstrap desde CDN -->
  <link href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  
  <!-- Font Awesome desde CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <!-- Fuentes personalizadas -->
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Estilos personalizados -->
  <link href="${pageContext.request.contextPath}/css/login-register.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/theme-unified.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/payment-form.css" rel="stylesheet">

</head>

<body id="page-top">

  <!-- Contenedor Principal -->
  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/customers">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Tienda de Libros</div>
      </a>

      <hr class="sidebar-divider my-0">

      <!-- Inicio -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Inicio</span></a>
      </li>

      <hr class="sidebar-divider">

      <div class="sidebar-heading">
        Interfaz
      </div>

      <!-- Perfil -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo">
          <i class="fas fa-fw fa-user"></i>
          <span>Perfil</span>
        </a>
        <div id="collapseTwo" class="collapse">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Perfil:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile">Ver perfil</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile/update">Actualizar perfil</a>
          </div>
        </div>
      </li>

      <!-- Libros disponibles -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/books">
          <i class="fas fa-fw fa-book"></i>
          <span> Libros disponibles</span></a>
      </li>

      <!-- Libros comprados -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/books">
          <i class="fas fa-fw fa-book"></i>
          <span> Libros comprados</span></a>
      </li>

      <!-- Carrito -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/cart">
          <i class="fas fa-fw fa-shopping-cart"></i>
          <span>Carrito</span></a>
      </li>

      <!-- Transacciones -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/transactions">
          <i class="fas fa-fw fa-shopping-cart"></i>
          <span>Transacciones</span></a>
      </li>

      <hr class="sidebar-divider">

      <div class="sidebar-heading">
        Seguridad
      </div>

      <!-- Cambiar contraseña -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/password">
          <i class="fas fa-fw fa-key"></i>
          <span>Cambiar contraseña</span></a>
      </li>

      <!-- Cerrar sesión -->
      <li class="nav-item" onClick="return confirm('¿Realmente deseas cerrar sesión?')">
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-fw fa-sign-out-alt"></i>
          <span>Cerrar sesión</span></a>
      </li>

      <hr class="sidebar-divider d-none d-md-block">

      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>

    <!-- Contenido -->
    <div id="content-wrapper" class="d-flex flex-column">

      <div id="content">

        <!-- Topbar -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Buscar -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 navbar-search" method="get" action="${pageContext.request.contextPath}/customers/books/search">
            <div class="input-group">
              <input type="text" name="name" class="form-control bg-light border-0 small" placeholder="Buscar..." aria-label="Buscar">
              <div class="input-group-append">
                <button type="submit" class="btn btn-primary">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>

          <!-- Menú derecho -->
          <ul class="navbar-nav ml-auto">

            <!-- Usuario -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" id="userDropdown">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                  <c:out value="${customerData.firstName} ${customerData.lastName}"></c:out>
                </span>
                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
              </a>

              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in">
                <a class="dropdown-item" href="${pageContext.request.contextPath}/customers/profile">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Perfil
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Cerrar sesión
                </a>
              </div>
            </li>

          </ul>

        </nav>

        <!-- Contenido de la página -->
        <div class="container-fluid">

          <div class="payment-container">
            
            <div class="payment-header">
              <h1>
                <i class="fas fa-credit-card"></i>
                Procesar Pago
              </h1>
              <p>Completa la información para finalizar tu compra</p>
            </div>

            <div class="payment-card">
              <div class="payment-card-header">
                <h2>
                  <i class="fas fa-lock"></i>
                  Pago Seguro
                </h2>
              </div>
              
              <div class="payment-card-body">

                <!-- Alerta informativa -->
                <div class="payment-info-alert">
                  <i class="fas fa-info-circle"></i>
                  <div class="alert-content">
                    <h3>Sistema de Pago Simulado</h3>
                    <p>Este es un entorno de prueba. Ingresa cualquier ID y código OTP para simular el proceso de pago.</p>
                  </div>
                </div>

                <!-- Mensaje de error/éxito -->
                <c:if test="${message != null}">
                  <div class="payment-message error">
                    <i class="fas fa-exclamation-circle"></i>
                    <c:out value="${message}"></c:out>
                  </div>
                </c:if>

                <!-- Formulario de pago -->
                <form:form action="/customers/payment/success" method="post">
                  
                  <div class="payment-form-group">
                    <label class="payment-label">
                      <i class="fas fa-id-card"></i>
                      Ingresa tu ID
                      <span class="required">*</span>
                    </label>
                    <div class="payment-input-wrapper">
                      <input type="text" 
                             name="upi" 
                             class="payment-input" 
                             placeholder="Ej: usuario123" 
                             required
                             maxlength="50" />
                    </div>
                    <div class="payment-help-text">
                      <i class="fas fa-info-circle"></i>
                      Ingresa tu identificador único de pago
                    </div>
                  </div>

                  <div class="payment-form-group">
                    <label class="payment-label">
                      <i class="fas fa-key"></i>
                      Ingresa el código OTP
                      <span class="required">*</span>
                    </label>
                    <div class="payment-input-wrapper">
                      <input type="number" 
                             name="otp" 
                             class="payment-input" 
                             placeholder="Código de 6 dígitos" 
                             required
                             minlength="6"
                             maxlength="6" />
                    </div>
                    <div class="payment-help-text">
                      <i class="fas fa-shield-alt"></i>
                      Código de verificación enviado a tu dispositivo
                    </div>
                  </div>

                  <button type="submit" class="payment-submit-btn">
                    <i class="fas fa-lock"></i>
                    Proceder al Pago
                  </button>

                  <!-- Badges de seguridad -->
                  <div class="payment-security">
                    <div class="security-badge">
                      <i class="fas fa-shield-alt"></i>
                      Pago Seguro
                    </div>
                    <div class="security-badge">
                      <i class="fas fa-lock"></i>
                      Encriptación SSL
                    </div>
                    <div class="security-badge">
                      <i class="fas fa-check-circle"></i>
                      Verificado
                    </div>
                  </div>

                </form:form>

              </div>
            </div>

          </div>

        </div>

      </div>

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center">
            <span>Copyright &copy; proyecto</span>
          </div>
        </div>
      </footer>

    </div>

  </div>

  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Scripts desde CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  
  <!-- Scripts locales -->
  <script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>

</body>

</html>
