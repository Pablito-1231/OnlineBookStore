<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="es">

<head>

  <!-- CONFIGURACIÓN UTF-8 PARA EVITAR SÍMBOLOS RAROS -->
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>Refugio literario</title>

  <!-- Fuentes personalizadas -->
  <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Estilos personalizados -->
  <link href="${pageContext.request.contextPath}/css/login-register.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/theme-unified.css" rel="stylesheet">

  <!-- Estilos para tablas -->
  <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">

</head>

<body id="page-top">

  <!-- CONTENEDOR PRINCIPAL -->
  <div id="wrapper">

    <!-- BARRA LATERAL -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/customers">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Tienda de Libros</div>
      </a>

      <hr class="sidebar-divider my-0">

      <!-- MENU INICIO -->
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

      <!-- PERFIL -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-user"></i>
          <span>Perfil</span>
        </a>

        <div id="collapseTwo" class="collapse">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Opciones del perfil:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile">Ver perfil</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile/update">Actualizar perfil</a>
          </div>
        </div>
      </li>

      <!-- LIBROS DISPONIBLES -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/books">
          <i class="fas fa-fw fa-book"></i>
          <span>Libros disponibles</span></a>
      </li>

      <!-- LIBROS COMPRADOS -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/books">
          <i class="fas fa-fw fa-book"></i>
          <span>Libros comprados</span></a>
      </li>

      <!-- CARRITO -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/cart">
          <i class="fas fa-fw fa-shopping-cart"></i>
          <span>Carrito</span>
        </a>
      </li>

      <!-- TRANSACCIONES -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/transactions">
          <i class="fas fa-fw fa-shopping-cart"></i>
          <span>Transacciones</span></a>
      </li>

      <hr class="sidebar-divider">

      <div class="sidebar-heading">
        Seguridad
      </div>

      <!-- CAMBIO DE CONTRASEÑA -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/password">
          <i class="fas fa-fw fa-key"></i>
          <span>Cambiar contraseña</span>
        </a>
      </li>

      <!-- CERRAR SESIÓN -->
      <li class="nav-item" onClick="return confirm('¿Seguro que deseas cerrar sesión?')">
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-fw fa-sign-out-alt"></i>
          <span>Cerrar sesión</span>
        </a>
      </li>

      <hr class="sidebar-divider d-none d-md-block">

    </ul>
    <!-- FIN DE BARRA LATERAL -->

    <!-- CONTENIDO -->
    <div id="content-wrapper" class="d-flex flex-column">
      <div id="content">

        <!-- NAV SUPERIOR -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 shadow">

          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- BUSCADOR -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3" method="get" action="${pageContext.request.contextPath}/customers/books/search">
            <div class="input-group">
              <input type="text" name="name" class="form-control bg-light border-0 small" placeholder="Buscar..." />
              <div class="input-group-append">
                <button type="submit" class="btn btn-primary">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>

          <ul class="navbar-nav ml-auto">

            <!-- CARRITO ICONO -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#">
                <i class="fas fa-shopping-cart fa-fw"></i>
                <span class="badge badge-danger badge-counter">7</span>
              </a>
            </li>

            <div class="topbar-divider d-none d-sm-block"></div>

            <!-- INFORMACIÓN DEL USUARIO -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                  <c:out value="${customerData.firstName} ${customerData.lastName}" />
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
                  Cerrar sesión
                </a>
              </div>
            </li>
          </ul>

        </nav>
        <!-- FIN NAV -->

        <!-- CONTENIDO PRINCIPAL -->
        <div class="container-fluid">

          <h1 class="h3 mb-2 text-gray-800">Perfil del Cliente</h1>

          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Actualizar Perfil</h6>
            </div>

            <div class="card-body">
              <div class="table-responsive">

                <!-- FORMULARIO DE ACTUALIZACIÓN -->
                <form:form method="POST" modelAttribute="customerData" action="/customers/profile/update/process">

                  <table class="table table-bordered" width="100%" cellspacing="0">
                    <form:hidden path="role" value="ROLE_CUSTOMER" />
                    <form:hidden path="username" />

                    <tbody>
                      <tr>
                        <td colspan="2" style="color:red;">
                          <c:if test="${message != null}">
                            <c:out value="${message}" />
                          </c:if>
                        </td>
                      </tr>

                      <tr>
                        <td style="color:green;">Nombre:</td>
                        <td><form:input path="firstName" /></td>
                      </tr>

                      <tr>
                        <td style="color:green;">Apellido:</td>
                        <td><form:input path="lastName" /></td>
                      </tr>

                      <tr>
                        <td style="color:green;">Usuario:</td>
                        <td><c:out value="${customerData.username}" /></td>
                      </tr>

                      <tr>
                        <td style="color:green;">Correo electrónico:</td>
                        <td><form:input path="email" /></td>
                      </tr>

                      <tr>
                        <td style="color:green;">Número de celular:</td>
                        <td><form:input path="mobile" /></td>
                      </tr>

                      <tr>
                        <td style="color:green;">Dirección:</td>
                        <td><form:textarea path="address" /></td>
                      </tr>

                      <tr>
                        <td style="color:green;">Contraseña (encriptada)</td>
                        <td>***************************************</td>
                      </tr>

                      <tr>
                        <td style="color:green;">Ingrese su contraseña para actualizar:</td>
                        <td><form:password path="password" placeholder="Confirmar contraseña..." /></td>
                      </tr>

                      <tr>
                        <td colspan="2">
                          <input type="submit" class="btn btn-success" value="Actualizar perfil"
                            onClick="return confirm('¿Deseas actualizar este perfil?');" />
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

      <!-- FOOTER -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto text-center">
          <span>Copyright © </span>
        </div>
      </footer>

    </div>
  </div>

  <!-- JS -->
  <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>

</body>
</html>
