<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="es">

<head>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>Refugio literario</title>

    <!-- Bootstrap 5 local -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
    <!-- Iconos y fuentes -->
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet">

    <!-- Estilos personalizados -->
    <link href="${pageContext.request.contextPath}/css/login-register.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/theme-unified.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/dashboard-home.css" rel="stylesheet">

</head>

<body id="page-top">

  <!-- Contenedor principal -->
  <div id="wrapper">

    <!-- Barra lateral -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/customers">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Tienda de Libros </div>
      </a>

      <hr class="sidebar-divider my-0">

      <!-- Opción - Inicio -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Inicio</span></a>
      </li>

      <hr class="sidebar-divider">

      <div class="sidebar-heading">Interfaz</div>

      <!-- Perfil -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo">
          <i class="fas fa-fw fa-user"></i>
          <span>Perfil</span>
        </a>
        <div id="collapseTwo" class="collapse">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Opciones de Perfil:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile">Ver Perfil</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile/update">Actualizar Perfil</a>
          </div>
        </div>
      </li>

      <!-- Libros disponibles -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/books">
          <i class="fas fa-fw fa-book"></i>
          <span>Libros Disponibles</span></a>
      </li>

      <!-- Libros comprados -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/books">
          <i class="fas fa-fw fa-book"></i>
          <span>Libros Comprados</span></a>
      </li>

      <!-- Carrito -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/cart">
          <i class="fas fa-fw fa-shopping-cart"></i>
          <span>Carrito de Compras</span></a>
      </li>

      <!-- Historial de transacciones -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/transactions">
          <i class="fas fa-fw fa-shopping-cart"></i>
          <span>Transacciones</span></a>
      </li>

      <hr class="sidebar-divider">

      <div class="sidebar-heading">Seguridad</div>

      <!-- Cambiar contraseña -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/password">
          <i class="fas fa-fw fa-key"></i>
          <span>Cambiar Contraseña</span></a>
      </li>

      <!-- Cerrar sesión -->
      <li class="nav-item" onclick="return confirm('¿Realmente deseas cerrar sesión?')">
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-fw fa-sign-out-alt"></i>
          <span>Cerrar Sesión</span></a>
      </li>

      <hr class="sidebar-divider d-none d-md-block">

      <!-- Botón para ocultar barra -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>

    <!-- Contenido principal -->
    <div id="content-wrapper" class="d-flex flex-column">

      <div id="content">

        <!-- Barra superior -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 shadow">

          <!-- Búsqueda -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0"
            method="get" action="${pageContext.request.contextPath}/customers/books/search">
            <div class="input-group">
              <input type="text" name="name" class="form-control bg-light border-0 small" placeholder="Buscar libro...">
              <div class="input-group-append">
                <button class="btn btn-primary" type="submit">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>

          <!-- Menú superior -->
          <ul class="navbar-nav ml-auto">
          </ul>

        </nav>

        <!-- Contenido -->
        <div class="container-fluid dashboard-container">

          <!-- Hero Section eliminado -->

          <!-- Estadísticas Principales -->
          <div class="stats-grid">
            
            <div class="stat-card">
              <div class="stat-icon books">
                <i class="fas fa-book"></i>
              </div>
              <div class="stat-value">150+</div>
              <div class="stat-label">Libros Disponibles</div>
            </div>

            <div class="stat-card">
              <div class="stat-icon cart">
                <i class="fas fa-shopping-cart"></i>
              </div>
              <div class="stat-value">7</div>
              <div class="stat-label">Items en Carrito</div>
            </div>

            <div class="stat-card">
              <div class="stat-icon transactions">
                <i class="fas fa-receipt"></i>
              </div>
              <div class="stat-value">12</div>
              <div class="stat-label">Compras Realizadas</div>
            </div>

            <div class="stat-card">
              <div class="stat-icon total">
                <i class="fas fa-money-bill-wave"></i>
              </div>
              <div class="stat-value">$420.000 COP</div>
              <div class="stat-label">Total Invertido</div>
            </div>

          </div>

          <!-- Acciones Rápidas -->
          <div class="quick-actions">
            <h2 class="quick-actions-title">
              <i class="fas fa-bolt"></i> Acciones Rápidas
            </h2>
            
            <div class="actions-grid">
              <a href="${pageContext.request.contextPath}/books" class="action-btn primary">
                <i class="fas fa-search"></i>
                Explorar Libros
              </a>

              <a href="${pageContext.request.contextPath}/customers/cart" class="action-btn success">
                <i class="fas fa-shopping-cart"></i>
                Ver Mi Carrito
              </a>

              <a href="${pageContext.request.contextPath}/customers/books" class="action-btn info">
                <i class="fas fa-book-reader"></i>
                Mis Compras
              </a>

              <a href="${pageContext.request.contextPath}/customers/profile" class="action-btn warning">
                <i class="fas fa-user-circle"></i>
                Mi Perfil
              </a>
            </div>
          </div>

          <!-- Actividad Reciente -->
          <div class="recent-activity">
            <h2 class="recent-activity-title">
              <i class="fas fa-clock"></i> Actividad Reciente
            </h2>

            <ul class="activity-list">
              <li class="activity-item">
                <span class="activity-icon">
                  <i class="fas fa-shopping-bag"></i>
                </span>
                <div class="activity-content">
                  <p class="activity-text">Compraste "El Señor de los Anillos"</p>
                  <p class="activity-time">Hace 2 días</p>
                </div>
              </li>

              <li class="activity-item">
                <span class="activity-icon">
                  <i class="fas fa-cart-plus"></i>
                </span>
                <div class="activity-content">
                  <p class="activity-text">Agregaste 3 libros al carrito</p>
                  <p class="activity-time">Hace 5 días</p>
                </div>
              </li>

              <li class="activity-item">
                <span class="activity-icon">
                  <i class="fas fa-user-edit"></i>
                </span>
                <div class="activity-content">
                  <p class="activity-text">Actualizaste tu perfil</p>
                  <p class="activity-time">Hace 1 semana</p>
                </div>
              </li>

              <li class="activity-item">
                <span class="activity-icon">
                  <i class="fas fa-star"></i>
                </span>
                <div class="activity-content">
                  <p class="activity-text">Te uniste a Refugio Literario</p>
                  <p class="activity-time">Hace 2 semanas</p>
                </div>
              </li>
            </ul>
          </div>

        </div>

      </div>

      <!-- Pie de página -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center">
            <span>Copyright © proyecto final12 </span>
          </div>
        </div>
      </footer>

    </div>

  </div>

  <!-- Botón subir -->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Modal cerrar sesión -->
  <div class="modal fade" id="logoutModal" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">¿Estás listo para salir?</h5>
          <button class="close" type="button" data-dismiss="modal">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Selecciona "Cerrar sesión" si deseas terminar tu sesión actual.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
          <a class="btn btn-primary" href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Scripts -->
  <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>

</body>

</html>
