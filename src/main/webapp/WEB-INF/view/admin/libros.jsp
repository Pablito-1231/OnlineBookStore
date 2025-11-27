<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Libros - Administrador</title>
    <link href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-unified.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-modern.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notifications.css">
</head>
<body class="admin-wrapper">
<div style="display: flex; margin: 0; padding: 0;">

<%@ include file="sidebar.jsp" %>

<!-- Contenido Principal -->
<main class="admin-main">
    
    <!-- Header Mejorado -->
    <div class="admin-page-header mb-4">
        <div class="d-flex justify-content-between align-items-start">
            <div>
                <nav aria-label="breadcrumb" class="mb-2">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item active">Libros</li>
                    </ol>
                </nav>
                <h2 class="mb-2 fw-bold"><i class="fas fa-book-open me-2 text-primary"></i>Gestión de Libros</h2>
                <p class="text-muted mb-0">Administra el catálogo completo de libros de la tienda</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/libros/add" class="btn btn-primary btn-lg shadow-sm">
                <i class="fas fa-plus-circle me-2"></i>Agregar Libro
            </a>
        </div>
    </div>

    <!-- Mensajes de éxito/error -->
    <c:if test="${not empty message}">
        <div class="modern-alert ${messageType eq 'success' ? 'success' : 'error'}">
            <div class="alert-icon">
                <i class="fas ${messageType eq 'success' ? 'fa-check' : 'fa-times'}"></i>
            </div>
            <div class="alert-content">
                <strong>${messageType eq 'success' ? '¡Éxito!' : '¡Error!'}</strong>
                <p>${message}</p>
            </div>
            <button type="button" class="alert-close" onclick="this.parentElement.style.display='none'">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </c:if>

    <!-- Locale para formato de moneda COP -->
    <fmt:setLocale value="es_CO"/>

    <!-- Stats Row Mejorado -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm h-100 stat-card-hover">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="stat-icon-modern bg-primary-subtle">
                            <i class="fas fa-book-open text-primary"></i>
                        </div>
                        <span class="badge bg-primary-subtle text-primary">Total</span>
                    </div>
                    <h3 class="mb-1 fw-bold display-6">${totalLibros != null ? totalLibros : '0'}</h3>
                    <p class="text-muted mb-0 small">Libros en catálogo</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm h-100 stat-card-hover">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="stat-icon-modern bg-success-subtle">
                            <i class="fas fa-check-circle text-success"></i>
                        </div>
                        <span class="badge bg-success-subtle text-success">Stock OK</span>
                    </div>
                    <h3 class="mb-1 fw-bold display-6">${librosDisponibles != null ? librosDisponibles : '0'}</h3>
                    <p class="text-muted mb-0 small">Libros disponibles</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm h-100 stat-card-hover">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="stat-icon-modern bg-danger-subtle">
                            <i class="fas fa-exclamation-triangle text-danger"></i>
                        </div>
                        <span class="badge bg-danger-subtle text-danger">Sin stock</span>
                    </div>
                    <h3 class="mb-1 fw-bold display-6">${librosAgotados != null ? librosAgotados : '0'}</h3>
                    <p class="text-muted mb-0 small">Libros agotados</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Barra de Filtros y Búsqueda Mejorada -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body">
            <div class="row align-items-center g-3">
                <!-- Filtros por Stock -->
                <div class="col-lg-6">
                    <label class="form-label small text-muted fw-semibold mb-2">
                        <i class="fas fa-filter me-1"></i>Filtrar por estado
                    </label>
                    <div class="btn-group w-100" role="group">
                        <a href="${pageContext.request.contextPath}/admin/libros" 
                           class="btn ${stockFilter eq 'all' || stockFilter == null ? 'btn-primary' : 'btn-outline-primary'}">
                            <i class="fas fa-list me-1"></i>Todos
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/libros?stock=available" 
                           class="btn ${stockFilter eq 'available' ? 'btn-success' : 'btn-outline-success'}">
                            <i class="fas fa-check-circle me-1"></i>Disponibles
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/libros?stock=out" 
                           class="btn ${stockFilter eq 'out' ? 'btn-danger' : 'btn-outline-danger'}">
                            <i class="fas fa-times-circle me-1"></i>Agotados
                        </a>
                    </div>
                </div>
                
                <!-- Ordenamiento y Exportar -->
                <div class="col-lg-6">
                    <label class="form-label small text-muted fw-semibold mb-2">
                        <i class="fas fa-cog me-1"></i>Acciones
                    </label>
                    <div class="d-flex gap-2">
                        <div class="dropdown flex-fill">
                            <button class="btn btn-outline-secondary w-100 dropdown-toggle" type="button" id="sortDropdown" data-bs-toggle="dropdown">
                                <i class="fas fa-sort-amount-down me-2"></i>Ordenar
                            </button>
                            <ul class="dropdown-menu w-100" aria-labelledby="sortDropdown">
                                <li><h6 class="dropdown-header"><i class="fas fa-font me-2"></i>Por nombre</h6></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=name&order=asc">
                                    <i class="fas fa-sort-alpha-down me-2"></i>A → Z
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=name&order=desc">
                                    <i class="fas fa-sort-alpha-up me-2"></i>Z → A
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><h6 class="dropdown-header"><i class="fas fa-money-bill-wave me-2"></i>Por precio</h6></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=price&order=asc">
                                    <i class="fas fa-arrow-down me-2"></i>Menor a Mayor
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=price&order=desc">
                                    <i class="fas fa-arrow-up me-2"></i>Mayor a Menor
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><h6 class="dropdown-header"><i class="fas fa-boxes me-2"></i>Por stock</h6></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=stock&order=asc">
                                    <i class="fas fa-arrow-down me-2"></i>Menor a Mayor
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/libros?stock=${stockFilter}&sort=stock&order=desc">
                                    <i class="fas fa-arrow-up me-2"></i>Mayor a Menor
                                </a></li>
                            </ul>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin/libros.json${stockFilter ne 'all' ? (stockFilter eq 'available' ? '?stock=available' : (stockFilter eq 'out' ? '?stock=out' : '')) : ''}" 
                           class="btn btn-outline-info" target="_blank" title="Exportar a JSON">
                            <i class="fas fa-file-export me-1"></i>JSON
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabla de Libros Mejorada -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white border-bottom py-3">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-semibold">
                    <i class="fas fa-table me-2 text-primary"></i>Listado de Libros
                </h5>
                <span class="badge bg-light text-dark border">
                    ${books.size()} registro(s)
                </span>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 modern-table">
                    <thead>
                        <tr>
                            <th class="ps-4 py-3 fw-semibold">
                                <i class="fas fa-hashtag me-2 text-secondary"></i>
                                ID
                            </th>
                            <th class="py-3 fw-semibold">
                                <i class="fas fa-book me-2 text-secondary"></i>
                                Información del Libro
                            </th>
                            <th class="py-3 fw-semibold">
                                <i class="fas fa-money-bill-wave me-2 text-secondary"></i>
                                Precio (COP)
                            </th>
                            <th class="py-3 fw-semibold">
                                <i class="fas fa-boxes me-2 text-secondary"></i>
                                Stock
                            </th>
                            <th class="py-3 fw-semibold">
                                <i class="fas fa-tag me-2 text-secondary"></i>
                                Tipo
                            </th>
                            <th class="text-end pe-4 py-3 fw-semibold">
                                <i class="fas fa-cogs me-2 text-secondary"></i>
                                Acciones
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty books}">
                                <c:forEach var="book" items="${books}">
                                    <tr class="book-row">
                                        <td class="ps-4">
                                            <span class="badge bg-light text-primary border">#${book.id}</span>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-start">
                                                <div class="book-icon-placeholder me-3">
                                                    <i class="fas fa-book-open"></i>
                                                </div>
                                                <div>
                                                    <div class="fw-bold text-dark mb-1">${book.name}</div>
                                                    <small class="text-muted d-block" style="max-width: 400px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                        ${book.bookDetail.detail}
                                                    </small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="fw-bold text-success fs-6">$ <fmt:formatNumber value="${book.price}" type="number" groupingUsed="true" minFractionDigits="0"/> COP</span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${book.quantity > 10}">
                                                    <span class="badge rounded-pill bg-success-subtle text-success px-3 py-2">
                                                        <i class="fas fa-check-circle me-1"></i>${book.quantity} unidades
                                                    </span>
                                                </c:when>
                                                <c:when test="${book.quantity > 0}">
                                                    <span class="badge rounded-pill bg-warning-subtle text-warning px-3 py-2">
                                                        <i class="fas fa-exclamation-circle me-1"></i>${book.quantity} unidades
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge rounded-pill bg-danger-subtle text-danger px-3 py-2">
                                                        <i class="fas fa-times-circle me-1"></i>Agotado
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="badge bg-primary-subtle text-primary px-3 py-2">
                                                <i class="fas fa-tag me-1"></i>${book.bookDetail.type}
                                            </span>
                                        </td>
                                        <td class="text-end pe-4">
                                            <div class="btn-group" role="group">
                                                                <a href="${pageContext.request.contextPath}/admin/libros/edit?id=${book.id}" 
                                                                    class="btn btn-sm btn-edit" 
                                                   title="Editar libro">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/libros/delete?id=${book.id}" 
                                                   class="btn btn-sm btn-outline-danger" 
                                                   title="Eliminar libro" 
                                                   onclick="return confirm('⚠️ ¿Estás seguro de eliminar este libro?\n\nEsta acción no se puede deshacer.');">
                                                    <i class="fas fa-trash-alt"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center py-5">
                                        <div class="empty-state">
                                            <i class="fas fa-book-open fa-4x text-muted mb-3"></i>
                                            <h5 class="text-muted mb-2">No hay libros registrados</h5>
                                            <p class="text-muted mb-3">Comienza agregando el primer libro al catálogo</p>
                                            <a href="${pageContext.request.contextPath}/admin/libros/add" class="btn btn-primary">
                                                <i class="fas fa-plus-circle me-2"></i>Agregar Primer Libro
                                            </a>
                                        </div>
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

</main>

</div>

<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<style>
/* Estilos personalizados para gestión de libros */
.admin-page-header {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    padding: 2rem;
    border-radius: 12px;
    border-left: 4px solid #0d6efd;
}

.admin-page-header h2 {
    color: #2c3e50;
}

.breadcrumb {
    background: transparent;
    padding: 0;
}

.breadcrumb-item a {
    color: #6c757d;
    text-decoration: none;
}

.breadcrumb-item a:hover {
    color: #0d6efd;
}

.stat-card-hover {
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.stat-card-hover:hover {
    transform: translateY(-5px);
    box-shadow: 0 0.5rem 1.5rem rgba(0,0,0,0.15) !important;
}

.stat-icon-modern {
    width: 56px;
    height: 56px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
}

.modern-table thead th {
    background: #f8f9fa;
    border-bottom: 2px solid #dee2e6;
    padding: 1rem;
}

.modern-table tbody tr {
    border-bottom: 1px solid #f0f0f0;
    transition: background-color 0.2s ease;
}

.modern-table tbody tr:hover {
    background-color: #f8f9fa;
}

.modern-table tbody td {
    padding: 1.25rem 1rem;
    vertical-align: middle;
}

.book-icon-placeholder {
    width: 48px;
    height: 48px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.25rem;
    flex-shrink: 0;
}

.book-row {
    transition: all 0.2s ease;
}

.book-row:hover .book-icon-placeholder {
    transform: scale(1.1);
}

.empty-state {
    padding: 3rem 2rem;
}

.btn-group .btn {
    transition: all 0.2s ease;
}

.btn-group .btn:hover {
    transform: scale(1.05);
}

.badge {
    font-weight: 500;
    letter-spacing: 0.3px;
}

.card-header h5 i {
    opacity: 0.8;
}

/* Estilos mejorados para badges */
.bg-primary-subtle {
    background-color: rgba(13, 110, 253, 0.1) !important;
}

.bg-success-subtle {
    background-color: rgba(25, 135, 84, 0.1) !important;
}

.bg-danger-subtle {
    background-color: rgba(220, 53, 69, 0.1) !important;
}

.bg-warning-subtle {
    background-color: rgba(255, 193, 7, 0.1) !important;
}

.text-primary { color: #0d6efd !important; }
.text-success { color: #198754 !important; }
.text-danger { color: #dc3545 !important; }
.text-warning { color: #ffc107 !important; }

/* Animación suave para alertas */
.alert {
    animation: slideDown 0.3s ease;
}

@keyframes slideDown {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Mejorar dropdown */
.dropdown-menu {
    border: none;
    box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);
    border-radius: 8px;
}

.dropdown-item {
    padding: 0.625rem 1.25rem;
    transition: background-color 0.2s ease;
}

.dropdown-item:hover {
    background-color: #f8f9fa;
}

.dropdown-header {
    color: #6c757d;
    font-weight: 600;
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

/* Paginación mejorada */
.pagination .page-link {
    border-radius: 8px;
    margin: 0 0.25rem;
    border: 1px solid #dee2e6;
    color: #6c757d;
}

.pagination .page-item.active .page-link {
    background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
    border-color: #0d6efd;
}

.pagination .page-link:hover {
    background-color: #f8f9fa;
}
</style>

</body>
</html>
