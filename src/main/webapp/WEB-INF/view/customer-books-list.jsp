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

  <title>Librería en Línea</title>

  <!-- Fuentes -->
  <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,900" rel="stylesheet">

  <!-- Estilos -->
  <link href="${pageContext.request.contextPath}/css/login-register.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/css/theme-unified.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/books-grid.css" rel="stylesheet">

</head>

<body id="page-top">

  <!-- Contenedor principal -->
  <div id="wrapper">

    <!-- Barra lateral -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Marca -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/customers">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Librería</div>
      </a>

      <hr class="sidebar-divider my-0">

      <!-- Inicio -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>Inicio</span></a>
      </li>

      <hr class="sidebar-divider">

      <!-- Sección -->
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
            <h6 class="collapse-header">Opciones del Perfil:</h6>
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

      <!-- Historial -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/transactions">
          <i class="fas fa-fw fa-clock"></i>
          <span>Transacciones</span></a>
      </li>

      <hr class="sidebar-divider">

      <!-- Seguridad -->
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

      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- Fin barra lateral -->

    <!-- Contenido principal -->
    <div id="content-wrapper" class="d-flex flex-column">

      <div id="content">

        <!-- Barra superior -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 shadow">

          <!-- Botón móvil -->
          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Buscador -->
          <form class="d-none d-sm-inline-block form-inline" method="get" action="${pageContext.request.contextPath}/customers/books/search">
            <div class="input-group">
              <input type="text" name="name" class="form-control bg-light border-0 small" placeholder="Buscar...">
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
                <span class="mr-2 d-none d-lg-inline text-gray-600 small">¡Bienvenido!</span>
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
        <!-- Fin barra superior -->

        <!-- Contenido -->
        <div class="container-fluid">

          <!-- Header mejorado -->
          <div class="books-header">
            <h1 class="books-title">
              <i class="fas fa-book-open"></i> Librería Virtual
            </h1>
            <p class="books-subtitle">Descubre tu próxima lectura favorita</p>
          </div>

          <!-- Mensaje de notificación -->
          <c:if test="${message != null}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
              <i class="fas fa-check-circle"></i> <c:out value="${message}"/>
              <button type="button" class="close" data-dismiss="alert">
                <span>&times;</span>
              </button>
            </div>
          </c:if>

          <!-- Estadísticas rápidas -->
          <div class="books-stats">
            <div class="stat-card">
              <div class="stat-icon primary">
                <i class="fas fa-book"></i>
              </div>
              <div class="stat-content">
                <h3><c:out value="${books.size()}"/></h3>
                <p>Libros Disponibles</p>
              </div>
            </div>
            
            <div class="stat-card">
              <div class="stat-icon success">
                <i class="fas fa-shopping-cart"></i>
              </div>
              <div class="stat-content">
                <h3><c:out value="${shoppingItems.size()}"/></h3>
                <p>En tu Carrito</p>
              </div>
            </div>

            <div class="stat-card">
              <div class="stat-icon info">
                <i class="fas fa-star"></i>
              </div>
              <div class="stat-content">
                <h3>Nuevos</h3>
                <p>Llegadas Recientes</p>
              </div>
            </div>
          </div>

          <!-- Grid de libros moderno -->
          <div class="books-grid">
            <c:forEach var="book" items="${books}">
              
              <c:url var="addToCartLink" value="/customers/cart/add">
                <c:param name="bookId" value="${book.id}"/>
              </c:url>

              <c:url var="removeFromCartLink" value="/customers/cart/remove">
                <c:param name="bookId" value="${book.id}"/>
              </c:url>

              <!-- Verificar si está en el carrito -->
              <c:set var="contains" value="false" />
              <c:forEach var="item" items="${shoppingItems}">
                <c:if test="${item.book.id eq book.id}">
                  <c:set var="contains" value="true" />
                </c:if>
              </c:forEach>

              <!-- Card del libro -->
              <div class="book-card ${book.quantity <= 0 ? 'out-of-stock' : ''}">
                
                <!-- Portada -->
                <div class="book-cover">
                  <i class="fas fa-book-open book-cover-icon"></i>
                  
                  <!-- Badge de estado -->
                  <c:if test="${contains}">
                    <span class="book-badge in-cart">
                      <i class="fas fa-check"></i> En Carrito
                    </span>
                  </c:if>
                  
                  <c:if test="${book.quantity <= 0}">
                    <span class="book-badge out-of-stock-badge">
                      <i class="fas fa-times"></i> Agotado
                    </span>
                  </c:if>
                </div>

                <!-- Contenido -->
                <div class="book-content">
                  <h3 class="book-title">
                    <c:out value="${book.name}"/>
                  </h3>

                  <div class="book-meta">
                    <div class="book-meta-item">
                      <i class="fas fa-tag"></i>
                      <span><c:out value="${book.bookDetail.type}"/></span>
                    </div>
                    <div class="book-meta-item">
                      <i class="fas fa-box"></i>
                      <span><c:out value="${book.quantity}"/> disponibles</span>
                    </div>
                    <div class="book-meta-item">
                      <i class="fas fa-barcode"></i>
                      <span>ID: <c:out value="${book.id}"/></span>
                    </div>
                  </div>

                  <!-- Precio y acciones -->
                  <div class="book-price-section">
                    <div class="book-price-label">Precio</div>
                    <div class="book-price">$<c:out value="${book.price}"/></div>

                    <div class="book-actions">
                      <c:choose>
                        <c:when test="${book.quantity > 0 && contains != true}">
                          <a href="${addToCartLink}" style="text-decoration: none; flex: 1;">
                            <button class="btn-add-cart">
                              <i class="fas fa-shopping-cart"></i>
                              Agregar al Carrito
                            </button>
                          </a>
                        </c:when>
                        
                        <c:when test="${contains}">
                          <a href="${removeFromCartLink}" style="text-decoration: none; flex: 1;">
                            <button class="btn-remove-cart">
                              <i class="fas fa-trash"></i>
                              Quitar del Carrito
                            </button>
                          </a>
                        </c:when>
                        
                        <c:otherwise>
                          <button class="btn-add-cart" disabled style="opacity: 0.5; cursor: not-allowed;">
                            <i class="fas fa-ban"></i>
                            No Disponible
                          </button>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>
                </div>

              </div>
            </c:forEach>
          </div>

          <!-- Estado vacío -->
          <c:if test="${books.size() == 0}">
            <div class="empty-state">
              <div class="empty-state-icon">
                <i class="fas fa-book-open"></i>
              </div>
              <h3>No hay libros disponibles</h3>
              <p>Vuelve pronto para descubrir nuevas lecturas</p>
            </div>
          </c:if>

          <!-- Botón de acción flotante -->
          <c:if test="${message != null && shoppingItems.size() > 0}">
            <a href="${pageContext.request.contextPath}/customers/cart" 
               class="btn btn-success btn-lg" 
               style="position: fixed; bottom: 2rem; right: 2rem; z-index: 1000; border-radius: 50px; padding: 1rem 2rem; box-shadow: 0 8px 16px rgba(0,0,0,0.2);">
              <i class="fas fa-shopping-cart"></i> Ver Carrito (<c:out value="${shoppingItems.size()}"/>)
            </a>
          </c:if>

        </div>

      </div>

      <!-- Pie -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center">
            <span>Copyright © proyecto final 4semestre</span>
          </div>
        </div>
      </footer>

    </div>

  </div>

  <!-- Subir -->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

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
