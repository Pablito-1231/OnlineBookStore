<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*, com.shashirajraja.onlinebookstore.entity.ShoppingCart" %>
<html lang="es">

<head>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title>Refugio Literario</title>

  <!-- Bootstrap desde CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  
  <!-- Font Awesome desde CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <!-- Fuentes personalizadas -->
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- DataTables desde CDN -->
  <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet">

  <!-- Estilos personalizados -->
  <link href="${pageContext.request.contextPath}/css/login-register.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/theme-unified.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/cart-modern.css" rel="stylesheet">

</head>

<body id="page-top">
  <fmt:setLocale value="es_CO"/>

  <!-- Contenedor principal -->
  <div id="wrapper">

    <!-- Barra lateral -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${pageContext.request.contextPath}/customers">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Tienda de libros</div>
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
            <h6 class="collapse-header">Opciones del perfil:</h6>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile">Ver perfil</a>
            <a class="collapse-item" href="${pageContext.request.contextPath}/customers/profile/update">Actualizar perfil</a>
          </div>
        </div>
      </li>

      <!-- Libros -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/books">
          <i class="fas fa-fw fa-book"></i>
          <span> Libros disponibles</span>
        </a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/books">
          <i class="fas fa-fw fa-book"></i>
          <span> Libros comprados</span>
        </a>
      </li>
      
      <!-- Carrito -->
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/customers/cart">
          <i class="fas fa-fw fa-shopping-cart"></i>
          <span>Carrito de compras</span>
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
          <span>Cambiar contraseña</span>
        </a>
      </li>

      <!-- Cerrar sesión -->
      <li class="nav-item" onClick="return confirm('¿Realmente deseas cerrar sesión?')">
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
          <i class="fas fa-fw fa-sign-out-alt"></i>
          <span>Cerrar sesión</span>
        </a>
      </li>

      <hr class="sidebar-divider d-none d-md-block">

      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- Fin de sidebar -->

    <!-- Contenido -->
    <div id="content-wrapper" class="d-flex flex-column">

      <div id="content">

        <!-- Barra superior -->
        <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

          <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
          </button>

          <!-- Buscador -->
          <form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"
                method="get" action="${pageContext.request.contextPath}/customers/books/search">
            <div class="input-group">
              <input type="text" name="name" class="form-control bg-light border-0 small" placeholder="Buscar..." aria-label="Search">
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

        <!-- Contenido de página -->
        <div class="container-fluid cart-container">

          <!-- Header del carrito -->
          <div class="cart-header">
            <h1><i class="fas fa-shopping-cart"></i> Mi Carrito de Compras</h1>
            <p>Gestiona los artículos que deseas adquirir</p>
          </div>

          <!-- Mensaje de alerta -->
          <c:if test="${message != null}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
              <i class="fas fa-check-circle"></i> <c:out value="${message}"/>
              <button type="button" class="close" data-dismiss="alert">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
          </c:if>

          <!-- Calcular totales -->
          <c:set var="totalPrice" value="0" scope="page" />
          <c:set var="totalQuantity" value="0" scope="page" />
          <c:if test="${not empty shoppingItems}">
            <c:forEach var="shoppingCart" items="${shoppingItems}">
              <c:set var="totalPrice" value="${totalPrice + (shoppingCart.quantity * shoppingCart.book.price)}" scope="page" />
              <c:set var="totalQuantity" value="${totalQuantity + shoppingCart.quantity}" scope="page" />
            </c:forEach>
          </c:if>

          <!-- Carrito vacío -->
          <c:if test="${empty shoppingItems or totalQuantity eq 0}">
            <div class="cart-empty">
              <div class="cart-empty-icon">
                <i class="fas fa-shopping-cart"></i>
              </div>
              <h2>Tu carrito está vacío</h2>
              <p>¡Explora nuestra colección y encuentra tu próximo libro favorito!</p>
              <a href="${pageContext.request.contextPath}/books" class="btn-checkout">
                <i class="fas fa-book"></i> Ver Catálogo de Libros
              </a>
            </div>
          </c:if>

          <!-- Carrito con items -->
          <c:if test="${not empty shoppingItems and totalQuantity ne 0}">
            <div class="cart-grid">
              
              <!-- Items del carrito -->
              <div class="cart-items">
                <c:forEach var="shoppingCart" items="${shoppingItems}">
                  <c:url var="removeFromCartLink" value="/customers/cart/remove">
                    <c:param name="bookId" value="${shoppingCart.book.id}"/>
                  </c:url>

                  <div class="cart-item-card">
                    <div class="cart-item-content">
                      
                      <!-- Miniatura -->
                      <div class="cart-item-thumbnail">
                        <i class="fas fa-book"></i>
                      </div>

                      <!-- Información del libro -->
                      <div class="cart-item-info">
                        <h3><c:out value="${shoppingCart.book.name}"/></h3>
                        <div class="cart-item-meta">
                          <span class="cart-item-meta-item">
                            <i class="fas fa-tag"></i>
                            <c:out value="${shoppingCart.book.bookDetail.type}"/>
                          </span>
                          <span class="cart-item-meta-item">
                            <i class="fas fa-money-bill-wave"></i>
                            $ <fmt:formatNumber value="${shoppingCart.book.price}" type="number" groupingUsed="true" minFractionDigits="0"/> COP
                          </span>
                        </div>
                      </div>

                      <!-- Acciones y controles -->
                      <div class="cart-item-actions">
                        <!-- Controles de cantidad -->
                        <div class="quantity-controls">
                          <form method="post" action="${pageContext.request.contextPath}/customers/cart/decrease" style="display:inline;">
                            <input type="hidden" name="bookId" value="${shoppingCart.book.id}"/>
                            <input type="hidden" name="count" value="1"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit" class="quantity-btn">
                              <i class="fas fa-minus"></i>
                            </button>
                          </form>
                          
                          <span class="quantity-display">
                            <c:out value="${shoppingCart.quantity}"/>
                          </span>
                          
                          <form method="post" action="${pageContext.request.contextPath}/customers/cart/increase" style="display:inline;">
                            <input type="hidden" name="bookId" value="${shoppingCart.book.id}"/>
                            <input type="hidden" name="count" value="1"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit" class="quantity-btn">
                              <i class="fas fa-plus"></i>
                            </button>
                          </form>
                        </div>

                        <!-- Botón eliminar -->
                        <a href="${removeFromCartLink}">
                          <button type="button" class="btn-remove-item">
                            <i class="fas fa-trash"></i> Eliminar
                          </button>
                        </a>
                      </div>

                    </div>
                  </div>
                </c:forEach>
              </div>

              <!-- Resumen del carrito -->
              <div class="cart-summary">
                <div class="cart-summary-card">
                  <h2 class="cart-summary-title">
                    <i class="fas fa-file-invoice-dollar"></i> Resumen de Compra
                  </h2>

                  <div class="cart-summary-row subtotal">
                    <span>Artículos en carrito:</span>
                    <span><c:out value="${totalQuantity}"/> items</span>
                  </div>

                  <div class="cart-summary-row subtotal">
                    <span>Subtotal:</span>
                    <span>$ <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" minFractionDigits="0"/> COP</span>
                  </div>

                  <div class="cart-summary-row total">
                    <span>Total:</span>
                    <span class="cart-summary-total-price">
                      $ <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true" minFractionDigits="0"/> COP
                    </span>
                  </div>

                  <div class="savings-badge">
                    <i class="fas fa-tag"></i> Envío gratis en pedidos mayores a $150.000 COP
                  </div>

                  <div class="cart-summary-actions">
                    <a href="${pageContext.request.contextPath}/customers/cart/pay" class="btn-checkout">
                      <i class="fas fa-credit-card"></i> Proceder al Pago
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/books" class="btn-continue-shopping">
                      <i class="fas fa-arrow-left"></i> Seguir Comprando
                    </a>
                  </div>
                </div>
              </div>

            </div>
          </c:if>

        </div>
      </div>

      <!-- Pie de página -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; g2</span>
          </div>
        </div>
      </footer>

    </div>

  </div>

  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Modal cerrar sesión -->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog">
    <div class="modal-dialog">
      <div class="modal-content">

        <div class="modal-header">
          <h5 class="modal-title">¿Listo para salir?</h5>
          <button class="close" type="button" data-dismiss="modal">
            <span aria-hidden="true">×</span>
          </button>
        </div>

        <div class="modal-body">Seleccione "Cerrar sesión" para finalizar la sesión actual.</div>

        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
          <a class="btn btn-primary" href="${pageContext.request.contextPath}/logout">Cerrar sesión</a>
        </div>

      </div>
    </div>
  </div>

  <!-- Scripts desde CDN -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
  
  <!-- Scripts locales -->
  <script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>

</body>

</html>
