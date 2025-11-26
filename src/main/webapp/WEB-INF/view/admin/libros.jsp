<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html style="margin:0;padding:0;overflow-x:hidden;">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Libros - Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-modern.css">
</head>
<body style="margin:0;padding:0;">

<!-- Admin Sidebar -->
<div class="admin-sidebar">
    <div class="admin-sidebar-header">
        <i class="fas fa-book-reader"></i>
        <span>Librería Admin</span>
    </div>
    
    <nav class="admin-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-nav-item">
            <i class="fas fa-chart-line"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/libros" class="admin-nav-item active">
            <i class="fas fa-book"></i>
            <span>Gestión de Libros</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/usuarios" class="admin-nav-item">
            <i class="fas fa-users"></i>
            <span>Usuarios</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/estadisticas" class="admin-nav-item">
            <i class="fas fa-chart-bar"></i>
            <span>Estadísticas</span>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="admin-nav-item" style="margin-top: auto;">
            <i class="fas fa-sign-out-alt"></i>
            <span>Cerrar Sesión</span>
        </a>
    </nav>
</div>

<!-- Admin Main Content -->
<div class="admin-main">
    
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="mb-1">Gestión de Libros</h2>
            <p class="text-muted mb-0">Administra el catálogo de libros</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin/libros/add" class="btn btn-admin btn-admin-primary">
            <i class="fas fa-plus"></i> Nuevo Libro
        </a>
    </div>

    <!-- Mensajes de éxito/error -->
    <c:if test="${not empty message}">
        <div class="alert alert-${messageType eq 'success' ? 'success' : 'danger'} alert-dismissible fade show shadow-sm border-0" role="alert">
            <i class="fas ${messageType eq 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'} me-2"></i>
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Stats Row -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="admin-stat-card">
                <div class="stat-icon" style="background: rgba(78, 115, 223, 0.1); color: #4e73df;">
                    <i class="fas fa-book"></i>
                </div>
                <div class="stat-info">
                    <h3>${totalLibros != null ? totalLibros : '0'}</h3>
                    <p>Total Libros</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="admin-stat-card">
                <div class="stat-icon" style="background: rgba(28, 200, 138, 0.1); color: #1cc88a;">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>${librosDisponibles != null ? librosDisponibles : '0'}</h3>
                    <p>Disponibles</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="admin-stat-card">
                <div class="stat-icon" style="background: rgba(231, 74, 59, 0.1); color: #e74a3b;">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>${librosAgotados != null ? librosAgotados : '0'}</h3>
                    <p>Agotados</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Filters & Search -->
    <div class="card shadow-sm mb-4 border-0 rounded-lg">
        <div class="card-body p-3">
            <div class="row align-items-center">
                <div class="col-md-6 mb-3 mb-md-0">
                    <div class="btn-group" role="group">
                        <a href="${pageContext.request.contextPath}/admin/libros" class="btn btn-sm ${stockFilter eq 'all' || stockFilter == null ? 'btn-primary' : 'btn-outline-primary'}">Todos</a>
                        <a href="${pageContext.request.contextPath}/admin/libros?stock=available" class="btn btn-sm ${stockFilter eq 'available' ? 'btn-success' : 'btn-outline-success'}">Disponibles</a>
                        <a href="${pageContext.request.contextPath}/admin/libros?stock=out" class="btn btn-sm ${stockFilter eq 'out' ? 'btn-danger' : 'btn-outline-danger'}">Agotados</a>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/libros.json${stockFilter ne 'all' ? (stockFilter eq 'available' ? '?stock=available' : (stockFilter eq 'out' ? '?stock=out' : '')) : ''}" class="btn btn-sm btn-outline-info ms-2" target="_blank">
                        <i class="fas fa-code"></i> JSON
                    </a>
                </div>
                <div class="col-md-6 text-md-end">
                    <div class="dropdown d-inline-block">
                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-sort"></i> Ordenar por
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="sortDropdown">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=name&order=asc">Nombre (A-Z)</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=name&order=desc">Nombre (Z-A)</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=price&order=asc">Precio (Menor a Mayor)</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=price&order=desc">Precio (Mayor a Menor)</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=stock&order=asc">Stock (Menor a Mayor)</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=stock&order=desc">Stock (Mayor a Menor)</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Books Table -->
    <div class="card shadow-sm border-0 rounded-lg">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-admin mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="border-0">ID</th>
                            <th class="border-0">Libro</th>
                            <th class="border-0">Precio</th>
                            <th class="border-0">Stock</th>
                            <th class="border-0">Tipo</th>
                            <th class="border-0 text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty books}">
                                <c:forEach var="book" items="${books}">
                                    <tr>
                                        <td>#${book.id}</td>
                                        <td>
                                            <div class="fw-bold">${book.name}</div>
                                            <small class="text-muted">${book.bookDetail.detail}</small>
                                        </td>
                                        <td>$${book.price}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${book.quantity > 0}">
                                                    <span class="badge bg-success">${book.quantity} unid.</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Agotado</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><span class="badge bg-info text-dark">${book.bookDetail.type}</span></td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/admin/libros/edit?id=${book.id}" class="btn btn-sm btn-outline-primary me-1" title="Editar">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/libros/delete?id=${book.id}" class="btn btn-sm btn-outline-danger" title="Eliminar" onclick="return confirm('¿Estás seguro de eliminar este libro?');">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center py-5 text-muted">
                                        <i class="fas fa-box-open fa-3x mb-3"></i><br>
                                        No se encontraron libros registrados.<br>
                                        <a href="${pageContext.request.contextPath}/admin/libros/add" class="btn btn-sm btn-primary mt-2">Agregar el primero</a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Pagination -->
        <c:if test="${pageCount > 1}">
            <div class="card-footer bg-white border-0 py-3">
                <nav aria-label="Paginación de libros">
                    <ul class="pagination justify-content-center mb-0">
                        <li class="page-item ${page == 0 ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=${sort}&order=${order}&page=${page-1}&size=${size}">
                                <i class="fas fa-chevron-left"></i>
                            </a>
                        </li>
                        <c:forEach var="p" begin="0" end="${pageCount-1}">
                            <li class="page-item ${p == page ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=${sort}&order=${order}&page=${p}&size=${size}">${p+1}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${page+1 >= pageCount ? 'disabled' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=${sort}&order=${order}&page=${page+1}&size=${size}">
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </c:if>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
