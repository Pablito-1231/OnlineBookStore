<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.shashirajraja.onlinebookstore.entity.CurrentSession, com.shashirajraja.onlinebookstore.entity.User" %>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="es">

<head>

  <!-- Configuración de caracteres en UTF-8 para evitar símbolos raros -->
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>Refugio  literario</title>

  <!-- Fuentes y estilos -->
  <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,900" rel="stylesheet">

  <link href="${pageContext.request.contextPath}/css/login-register.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/theme-unified.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/customer-profile.css" rel="stylesheet">

</head>

<body id="page-top">

  <!-- Contenedor general -->
  <div id="wrapper">

    <!-- Barra lateral -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Marca -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/customers">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Tienda de Libros</div>
      </a>

      <hr class="sidebar-divider my-0">

      <!-- O pción Inicio -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Inicio</span></a>
      </li>

      <hr class="sidebar-divider">

      <!-- Título de sección -->
      <div class="sidebar-heading">
        Interfaz
      </div>

      <!-- Menú Perfil -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo">
          <i class="fas fa-fw fa-user"></i>
          <span>Perfil</span>
        </a>
        <div id="collapseTwo" class="collapse">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Opciones del Perfil:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile">Ver Perfil</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile/update">Actualizar Perfil</a>
          </div>
        </div>
      </li>

      <!-- Libros Disponibles -->
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

      <!-- Historial -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/transactions">
          <i class="fas fa-fw fa-shopping-cart"></i>
          <span>Transacciones</span></a>
      </li>

      <hr class="sidebar-divider">

      <!-- Sección Seguridad -->
      <div class="sidebar-heading">
        Seguridad
      </div>

      <!-- Cambiar contraseña -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/password">
          <i class="fas fa-fw fa-key"></i>
          <span>Cambiar Contraseña</span></a>
      </li>

      <!-- Cerrar sesión -->
      <li class="nav-item" onClick="return confirm('¿Realmente deseas cerrar sesión?')">
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-fw fa-sign-out-alt"></i>
          <span>Cerrar Sesión</span></a>
      </li>

      <hr class="sidebar-divider d-none d-md-block">

    </ul>
    <!-- Fin Sidebar -->

    <!-- Contenido principal -->
    <div id="content-wrapper" class="d-flex flex-column">

      <div id="content">

        <!-- Barra superior -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Buscador -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 navbar-search"
            method="get" action="${pageContext.request.contextPath}/customers/books/search">
            <div class="input-group">
              <input type="text" name="name" class="form-control bg-light border-0 small"
                placeholder="Buscar...">
              <div class="input-group-append">
                <button type="submit" class="btn btn-primary">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>

          <ul class="navbar-nav ml-auto">

            <!-- Usuario -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                  <c:out value="${customerData.firstName} ${customerData.lastName}"></c:out>
                </span>
                <img class="img-profile rounded-circle"
                  src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
              </a>

              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in">
                <a class="dropdown-item" href="${pageContext.request.contextPath}/customers/profile">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Perfil
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Cerrar Sesión
                </a>
              </div>
            </li>

          </ul>

        </nav>

        <!-- Contenido de página -->
        <div class="container-fluid">

          <div class="profile-container">
            
            <div class="profile-header">
              <h1>
                <i class="fas fa-user-circle"></i>
                Mi Perfil
              </h1>
              <p>Información personal de tu cuenta</p>
            </div>

            <div class="profile-card">
              <div class="profile-card-header">
                <h2>
                  <i class="fas fa-id-card"></i>
                  Detalles del Perfil
                </h2>
              </div>
              
              <div class="profile-card-body">
                
                <div class="profile-field">
                  <div class="profile-label">
                    <i class="fas fa-user"></i>
                    Nombre:
                  </div>
                  <div class="profile-value">
                    <c:out value="${customerData.firstName}"></c:out>
                  </div>
                </div>

                <div class="profile-field">
                  <div class="profile-label">
                    <i class="fas fa-user"></i>
                    Apellido:
                  </div>
                  <div class="profile-value">
                    <c:out value="${customerData.lastName}"></c:out>
                  </div>
                </div>

                <div class="profile-field">
                  <div class="profile-label">
                    <i class="fas fa-at"></i>
                    Usuario:
                  </div>
                  <div class="profile-value">
                    <c:out value="${customerData.username}"></c:out>
                  </div>
                </div>

                <div class="profile-field">
                  <div class="profile-label">
                    <i class="fas fa-envelope"></i>
                    Correo:
                  </div>
                  <div class="profile-value">
                    <c:out value="${customerData.email}"></c:out>
                  </div>
                </div>

                <div class="profile-field">
                  <div class="profile-label">
                    <i class="fas fa-phone"></i>
                    Teléfono:
                  </div>
                  <div class="profile-value">
                    <c:out value="${customerData.mobile}"></c:out>
                  </div>
                </div>

                <div class="profile-field">
                  <div class="profile-label">
                    <i class="fas fa-map-marker-alt"></i>
                    Dirección:
                  </div>
                  <div class="profile-value">
                    <c:out value="${customerData.address}"></c:out>
                  </div>
                </div>

                <div class="profile-field">
                  <div class="profile-label">
                    <i class="fas fa-lock"></i>
                    Contraseña:
                  </div>
                  <div class="profile-value password">
                    ************************
                  </div>
                </div>

                <div class="profile-actions">
                  <a href="${pageContext.request.contextPath}/customers/profile/update" 
                     class="profile-btn profile-btn-primary">
                    <i class="fas fa-edit"></i>
                    Editar Perfil
                  </a>
                </div>

              </div>
            </div>

          </div>

        </div>

      </div>

      <!-- Pie de página -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center">
            <span>Copyright © </span>
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
          <h5 class="modal-title">¿Listo para salir?</h5>
          <button class="close" type="button" data-dismiss="modal">×</button>
        </div>
        <div class="modal-body">Selecciona "Cerrar Sesión" si deseas finalizar tu sesión actual.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
          <a class="btn btn-primary" href="${pageContext.request.contextPath}/logout">Cerrar Sesión</a>
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
