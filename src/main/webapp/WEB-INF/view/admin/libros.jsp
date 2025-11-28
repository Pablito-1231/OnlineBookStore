<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="layouts/admin-layout-header.jsp" %>
    
    <!-- Header Glassmorphism -->
    <div class="admin-page-header mb-4 glass-header-main">
        <div class="d-flex justify-content-between align-items-start">
            <div>
                <nav aria-label="breadcrumb" class="mb-2">
                    <ol class="breadcrumb mb-0 glass-breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                        <li class="breadcrumb-item active">Libros</li>
                    </ol>
                </nav>
                <h2 class="mb-2 fw-bold"><i class="fas fa-book-open me-2 text-warning"></i>Gestión de Libros</h2>
                <p class="text-muted mb-0">Administra el catálogo completo de libros de la tienda</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/libros/add" class="btn btn-warning btn-lg shadow-sm">
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

    <!-- Stats Row Glassmorphism -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="glass-card stat-card-hover">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <div class="stat-icon-modern glass-icon-card">
                            <i class="fas fa-book-open text-warning"></i>
                        </div>
                        <span class="badge glass-badge text-warning">Total</span>
                    </div>
                    <h3 class="mb-1 fw-bold display-6">${totalLibros != null ? totalLibros : '0'}</h3>
                    <p class="text-muted mb-0 small">Libros en catálogo</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="glass-card stat-card-hover">
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

    <!-- Asegurar que jQuery se carga antes de cualquier script que lo use -->
    <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<style>
/* Estilos personalizados para gestión de libros */
.admin-page-header {
    background: linear-gradient(135deg, #fffaf0 0%, #fff3e6 100%);
    padding: 2rem;
    border-radius: 12px;
    border-left: 4px solid #b57a36;
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
    color: #b57a36;
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
    background: #fffaf5;
    border-bottom: 2px solid #f0e6da;
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
    background: linear-gradient(135deg, #f6c23e 0%, #d79b4a 100%);
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
    background-color: rgba(181,122,60,0.12) !important;
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

.text-primary { color: #b57a36 !important; }
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
    background: linear-gradient(135deg, #b57a36 0%, #8f5f2d 100%);
    border-color: #b57a36;
}

.pagination .page-link:hover {
    background-color: #f8f9fa;
}
</style>

</body>
</html>
