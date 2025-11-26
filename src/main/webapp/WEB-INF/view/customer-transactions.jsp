<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, com.shashirajraja.onlinebookstore.entity.ShoppingCart" %>
<html lang="es">

<head>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>Refugio Literario</title>

  <!-- Fuentes personalizadas -->
  <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Estilos personalizados -->
  <link href="${pageContext.request.contextPath}/css/login-register.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/theme-unified.css" rel="stylesheet">
  
  <!-- Estilos de DataTables -->
  <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">

</head>
<body id="page-top">

  <!-- Contenedor Principal -->
  <div id="wrapper">

    <!-- Barra Lateral -->
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
            <h6 class="collapse-header">Opciones de Perfil:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile">Ver Perfil</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile/update">Actualizar Perfil</a>
          </div>
        </div>
      </li>

      <!-- Libros -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/books">
          <i class="fas fa-fw fa-book"></i>
          <span> Libros Disponibles</span></a>
      </li>

      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/books">
          <i class="fas fa-fw fa-book"></i>
          <span> Libros Comprados</span></a>
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
      <li class="nav-item" onClick="return confirm('¿Realmente quieres cerrar sesión?')">
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-fw fa-sign-out-alt"></i>
          <span>Cerrar Sesión</span></a>
      </li>

      <hr class="sidebar-divider d-none d-md-block">

      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- Fin del sidebar -->

    <!-- Contenido Principal -->
    <div id="content-wrapper" class="d-flex flex-column">

      <div id="content">

        <!-- Barra superior -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <!-- Botón móvil -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Buscador -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 navbar-search" method="get" action="${pageContext.request.contextPath}/customers/books/search">
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

            <!-- Alertas -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" data-toggle="dropdown">
                <i class="fas fa-bell fa-fw"></i>
                <span class="badge badge-danger badge-counter">1+</span>
              </a>

              <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in">
                <h6 class="dropdown-header">Centro de Alertas</h6>

                <a class="dropdown-item d-flex align-items-center" href="#">
                  <div class="mr-3">
                    <div class="icon-circle bg-primary">
                      <i class="fas fa-file-alt text-white"></i>
                    </div>
                  </div>
                  <div>
                    <div class="small text-gray-500">7 diciembre 2025</div>
                    <span class="font-weight-bold">Un nuevo reporte mensual llegará pronto...</span>
                  </div>
                </a>

                <a class="dropdown-item text-center small text-gray-500" href="#">Mostrar todas las alertas</a>
              </div>
            </li>

            <!-- Carrito -->
            <li class="nav-item dropdown no-arrow mx-1">
              <a class="nav-link dropdown-toggle" href="#">
                <i class="fas fa-shopping-cart fa-fw"></i>
                <span class="badge badge-danger badge-counter">1</span>
              </a>
            </li>

            <div class="topbar-divider d-none d-sm-block"></div>

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

        <!-- Contenido -->
        <div class="container-fluid">

          <h1 class="h3 mb-2 text-gray-800">Historial de Transacciones</h1>
        
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">Historial de Compras de Libros</h6>
            </div>

            <c:if test="${message != null}">
              <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary"><c:out value="${message}"></c:out> </h6>
              </div>
            </c:if>

            <div class="card-body">
              <div class="table-responsive">

                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>ID de Transacción</th>
                      <th>Fecha</th>
                      <th>Acción</th>
                    </tr>
                  </thead>

                  <tbody>
                    <c:forEach var="history" items="${purchaseHistories}">
                  
                      <c:url var="purchaseDetailLink" value="/customers/transactions/detail">
                        <c:param name="transId" value="${history.id}"/>
                      </c:url>

                      <tr>
                        <td><c:out value="${history.id}"/></td>
                        <td><c:out value="${history.date}"/></td>

                        <td>
                          <form:form action="${pageContext.request.contextPath}/customers/transactions/detail" method="post">
                            <input type="hidden" name="transId" value="${history.id}"/>
                            <input type="submit" class="button btn-success" value="Ver Detalle" />
                          </form:form>	  
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

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright © Proyecto final de 4 semestre 0</span>
          </div>
        </div>
      </footer>

    </div>
  </div>

  <!-- Botón scroll top -->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Modal de cierre de sesión -->
  <div class="modal fade" id="logoutModal" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">

        <div class="modal-header">
          <h5 class="modal-title">¿Listo para salir?</h5>
          <button class="close" type="button" data-dismiss="modal">
            <span aria-hidden="true">×</span>
          </button>
        </div>

        <div class="modal-body">Selecciona "Cerrar Sesión" abajo si deseas terminar tu sesión actual.</div>

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
