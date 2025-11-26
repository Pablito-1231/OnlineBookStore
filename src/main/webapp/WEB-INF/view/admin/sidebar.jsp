<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Sidebar Moderna -->
<aside class="admin-sidebar">
    <div class="admin-sidebar-header">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-brand">
            <div class="admin-brand-icon">
                <i class="fas fa-book"></i>
            </div>
            <div class="admin-brand-text">
                <h2>Admin Panel</h2>
                <p>Librería Online</p>
            </div>
        </a>
    </div>

    <nav class="admin-nav">
        <div class="admin-nav-section">
            <div class="admin-nav-title">Principal</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" 
               class="admin-nav-item ${pageContext.request.requestURI.contains('dashboard') ? 'active' : ''}">
                <i class="fas fa-home admin-nav-icon"></i>
                <span class="admin-nav-text">Dashboard</span>
            </a>
        </div>

        <div class="admin-nav-section">
            <div class="admin-nav-title">Gestión</div>
            <a href="${pageContext.request.contextPath}/admin/libros" 
               class="admin-nav-item ${pageContext.request.requestURI.contains('libros') || pageContext.request.requestURI.contains('libro-form') ? 'active' : ''}">
                <i class="fas fa-book admin-nav-icon"></i>
                <span class="admin-nav-text">Libros</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/usuarios" 
               class="admin-nav-item ${pageContext.request.requestURI.contains('usuarios') || pageContext.request.requestURI.contains('usuario-form') ? 'active' : ''}">
                <i class="fas fa-users admin-nav-icon"></i>
                <span class="admin-nav-text">Usuarios</span>
            </a>
        </div>

        <div class="admin-nav-section">
            <div class="admin-nav-title">Análisis</div>
            <a href="${pageContext.request.contextPath}/admin/estadisticas" 
               class="admin-nav-item ${pageContext.request.requestURI.contains('estadisticas') ? 'active' : ''}">
                <i class="fas fa-chart-bar admin-nav-icon"></i>
                <span class="admin-nav-text">Estadísticas</span>
            </a>
        </div>

        <div class="admin-nav-section">
            <a href="${pageContext.request.contextPath}/logout" class="admin-nav-item logout">
                <i class="fas fa-sign-out-alt admin-nav-icon"></i>
                <span class="admin-nav-text">Cerrar Sesión</span>
            </a>
        </div>
    </nav>
</aside>
