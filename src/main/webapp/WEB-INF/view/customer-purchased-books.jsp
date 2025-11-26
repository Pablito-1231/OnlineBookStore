<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- Importacion de librerias JSP necesarias -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Importacion de clases Java para lista de libros y carrito -->
<%@ page import="java.util.*, com.shashirajraja.onlinebookstore.entity.ShoppingCart" %>

<html lang="es">

<head>

  <!-- Configuracion basica del documento -->
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>Refugio Literario</title>

  <!-- Fuentes y estilos utilizados en la plantilla -->
  <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/login-register.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/theme-unified.css" rel="stylesheet">

  <!-- Estilos del plugin DataTables -->
  <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">

</head>

<body id="page-top">
  <fmt:setLocale value="es_CO"/>

  <!-- Contenedor principal de la pagina -->
  <div id="wrapper">

    <!-- MENU LATERAL -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Logo del sistema -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/customers">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Tienda de Libros </div>
      </a>

      <hr class="sidebar-divider my-0">

      <!-- Boton de inicio -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Inicio</span></a>
      </li>

      <hr class="sidebar-divider">

      <div class="sidebar-heading">
        Interfaz
      </div>

      <!-- Seccion perfil del usuario -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo">
          <i class="fas fa-fw fa-user"></i>
          <span>Perfil</span>
        </a>

        <!-- Opciones de perfil -->
        <div id="collapseTwo" class="collapse">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Perfil:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile">Ver Perfil</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile/update">Actualizar Perfil</a>
          </div>
        </div>
      </li>

      <!-- Lista de libros disponibles -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/books">
          <i class="fas fa-fw fa-book"></i>
          <span>Libros Disponibles</span></a>
      </li>

      <!-- Libros ya comprados -->
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

      <!-- Seccion de seguridad -->
      <div class="sidebar-heading">
        Seguridad
      </div>

      <!-- Cambio de contrasena -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/password">
          <i class="fas fa-fw fa-key"></i>
          <span>Cambiar Contrasena</span></a>
      </li>

      <!-- Cerrar sesion -->
      <li class="nav-item" onClick="return confirm('Realmente deseas cerrar sesion?')">
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-fw fa-sign-out-alt"></i>
          <span>Cerrar Sesion</span></a>
      </li>

      <hr class="sidebar-divider d-none d-md-block">

    </ul>

    <!-- CONTENIDO PRINCIPAL -->
    <div id="content-wrapper" class="d-flex flex-column">

      <div id="content">

        <!-- Barra superior con opciones y buscador -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Boton del menu para version movil -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Buscador de libros -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"
                method="get"
                action="${pageContext.request.contextPath}/customers/books/search">
            <div class="input-group">
              <input type="text" name="name" class="form-control bg-light border-0 small" placeholder="Buscar...">
              <div class="input-group-append">
                <button type="submit" class="btn btn-primary">
                  <i class="fas fa-search fa-sm"></i>
                </button>
              </div>
            </div>
          </form>
           <!-- Navegación superior -->
           <ul class="navbar-nav ml-auto">

            <!-- Usuario -->
            <li class="nav-item dropdown no-arrow">
              <a class="nav-link dropdown-toggle" href="#" id="userDropdown" data-toggle="dropdown">
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">¡Bienvenido!</span>
                <img class="img-profile rounded-circle" src="https://source.unsplash.com/QAB-WJcbgJk/60x60">
              </a>

              <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in">
                <a class="dropdown-item" href="${pageContext.request.contextPath}/customers/profile">
                  <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                  Perfil
                </a>

                <div class="dropdown-divider"></div>

                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout" data-toggle="modal" data-target="#logoutModal">
                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                  Cerrar Sesión
                </a>
              </div>
            </li>

          </ul>

        </nav>
        <!-- Fin de topbar -->

        </nav>

        <!-- CONTENIDO DE LA PAGINA -->
        <div class="container-fluid">

          <h1 class="h3 mb-2 text-gray-800">Libros Comprados</h1>

          <div class="card shadow mb-4">

            <!-- Encabezado de la tabla -->
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Lista de Libros</h6>
            </div>

            <!-- Mensajes de exito o error -->
            <c:if test="${message != null}">
              <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">
                  <c:out value="${message}"/>
                </h6>
              </div>
            </c:if>

            <!-- Tabla de libros -->
            <div class="card-body">
              <div class="table-responsive">

                <!-- Tabla que muestra los libros comprados -->
                <table class="table table-bordered" id="dataTable">

                  <thead>
                    <tr>
                      <th>Id</th>
                      <th>Nombre</th>
                      <th>Tipo</th>
                      <th>Detalle</th>
                      <th>Precio</th>
                      <th>Acciones</th>
                    </tr>
                  </thead>

                  <tbody>

                    <!-- Ciclo que recorre la lista de libros -->
                    <c:forEach var="book" items="${books}">

                      <!-- Link para leer el libro -->
                      <c:url var="readBookLink" value="#">
                        <c:param name="bookId" value="${book.id}"/>
                      </c:url>

                      <tr>
                        <td><c:out value="${book.id}"/></td>
                        <td><c:out value="${book.name}"/></td>
                        <td><c:out value="${book.bookDetail.type}"/></td>
                        <td><c:out value="${book.bookDetail.detail}"/></td>
                        <td>$ <fmt:formatNumber value="${book.price}" type="number" groupingUsed="true" minFractionDigits="0"/> COP</td>

                        <!-- Boton LEER -->
                        <td style="color:green;">
                          <a href="${readBookLink}">
                            <input type="button" class="button btn-success" value="LEER AHORA">
                          </a>
                        </td>

                      </tr>

                    </c:forEach>

                  </tbody>
                </table>

              </div>
            </div>

          </div>
        </div>

      </div>

      <!-- Pie de pagina -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright </span>
          </div>
        </div>
      </footer>

    </div>

  </div>

  <!-- Scripts JS necesarios para el funcionamiento de la plantilla -->
  <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>

  <!-- Scripts para DataTables -->
  <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>

</body>

</html>
