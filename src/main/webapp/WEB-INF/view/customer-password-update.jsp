<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="es">

<head>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>Refugio Literario</title>

  <!-- Íconos personalizados -->
  <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900" rel="stylesheet">

  <!-- Estilos personalizados -->
  <link href="${pageContext.request.contextPath}/css/login-register.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/theme-unified.css" rel="stylesheet">
  
  <!-- Estilos para tablas -->
  <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">

</head>

<body id="page-top">

  <!-- Contenedor general -->
  <div id="wrapper">

    <!-- Menú lateral -->
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
          <span>Inicio</span>
        </a>
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
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile">Ver Perfil</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile/update">Actualizar Perfil</a>
          </div>
        </div>
      </li>

      <!-- Libros -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/books">
          <i class="fas fa-fw fa-book"></i>
          <span>Libros Disponibles</span>
        </a>
      </li>

      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/books">
          <i class="fas fa-fw fa-book"></i>
          <span>Libros Comprados</span>
        </a>
      </li>

      <!-- Carrito -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/cart">
          <i class="fas fa-fw fa-shopping-cart"></i>
          <span>Carrito de Compras</span>
        </a>
      </li>

      <!-- Transacciones -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/transactions">
          <i class="fas fa-fw fa-shopping-cart"></i>
          <span>Transacciones</span>
        </a>
      </li>

      <hr class="sidebar-divider">

      <div class="sidebar-heading">
        Seguridad
      </div>

      <!-- Cambiar contraseña -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/password">
          <i class="fas fa-fw fa-key"></i>
          <span>Cambiar Contraseña</span>
        </a>
      </li>

      <!-- Cerrar sesión -->
      <li class="nav-item" onclick="return confirm('¿Realmente deseas cerrar sesión?')">
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-fw fa-sign-out-alt"></i>
          <span>Cerrar Sesión</span>
        </a>
      </li>

      <hr class="sidebar-divider d-none d-md-block">

      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- Fin del Sidebar -->

    <!-- Contenido principal -->
    <div id="content-wrapper" class="d-flex flex-column">

      <div id="content">

        <!-- Barra superior -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 shadow">

          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Buscador -->
          <form class="d-none d-sm-inline-block form-inline navbar-search" method="get" action="${pageContext.request.contextPath}/customers/books/search">
            <div class="input-group">
              <input type="text" name="name" class="form-control bg-light border-0 small" placeholder="Buscar...">
              <div class="input-group-append">
                <button type="submit" class="btn btn-primary">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>

          <!-- Parte derecha (usuario) -->
          <ul class="navbar-nav ml-auto">

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- Información del usuario -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                    <c:out value="${customerData.firstName} ${customerData.lastName}"/>
                </span>
                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
              </a>

              <div class="dropdown-menu dropdown-menu-right shadow">
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

        <!-- Contenido -->
        <div class="container-fluid">

          <h1 class="h3 mb-2 text-gray-800">Perfil del Cliente</h1>

          <!-- Actualizar contraseña -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Actualizar Contraseña</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">

                <form:form method="POST" action="/customers/password/change" modelAttribute="changePassword">
                  <form:hidden path="username"/>

                  <table class="table table-bordered">
                    <tbody>

                      <tr>
                        <td colspan="2" style="color:red;">
                          <c:if test="${message != null}">
                            <c:out value="${message}"/>
                          </c:if>
                        </td>
                      </tr>

                      <tr>
                        <td style="color:green;">Ingresa tu contraseña actual:</td>
                        <td><form:password path="oldPassword"/></td>
                      </tr>

                      <tr>
                        <td style="color:green;">Nueva contraseña:</td>
                        <td><form:password path="newPassword"/></td>
                      </tr>

                      <tr>
                        <td style="color:green;">Confirmar nueva contraseña:</td>
                        <td><form:password path="confirmPassword"/></td>
                      </tr>

                      <tr>
                        <td colspan="2">
                          <input type="submit" class="btn btn-danger" value="Cambiar Contraseña"/>
                        </td>
                      </tr>

                    </tbody>
                  </table>

                </form:form>

              </div>
            </div>
          </div>

        </div>

      </div>

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
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

  <!-- Modal logout -->
  <div class="modal fade" id="logoutModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">¿Listo para salir?</h5>
          <button class="close" type="button" data-dismiss="modal">
            <span aria-hidden="true">×</span>
          </button>
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
