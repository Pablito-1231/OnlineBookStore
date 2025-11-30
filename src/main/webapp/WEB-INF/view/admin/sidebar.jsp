<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <aside class="app-sidebar">
        <div class="sidebar-header">
            <div class="brand-logo">
                <i class="fas fa-book-open"></i>
            </div>
            <div class="brand-name">BookStore Admin</div>
        </div>

        <nav class="sidebar-nav">
            <div class="nav-section-label">Principal</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
                class="nav-item ${pageContext.request.requestURI.contains('/dashboard') ? 'active' : ''}">
                <i class="fas fa-home nav-icon"></i>
                <span>Dashboard</span>
            </a>

            <div class="nav-section-label">Gestión</div>
            <a href="${pageContext.request.contextPath}/admin/libros"
                class="nav-item ${pageContext.request.requestURI.contains('/libros') ? 'active' : ''}">
                <i class="fas fa-book nav-icon"></i>
                <span>Catálogo de Libros</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/usuarios"
                class="nav-item ${pageContext.request.requestURI.contains('/usuarios') ? 'active' : ''}">
                <i class="fas fa-users nav-icon"></i>
                <span>Usuarios & Clientes</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/roles"
                class="nav-item ${pageContext.request.requestURI.contains('/roles') ? 'active' : ''}">
                <i class="fas fa-user-shield nav-icon"></i>
                <span>Roles y Permisos</span>
            </a>

            <div class="nav-section-label">Reportes</div>
            <a href="${pageContext.request.contextPath}/admin/estadisticas"
                class="nav-item ${pageContext.request.requestURI.contains('/estadisticas') ? 'active' : ''}">
                <i class="fas fa-chart-pie nav-icon"></i>
                <span>Análisis de Ventas</span>
            </a>

            <div class="nav-section-label">Configuración</div>
            <a href="${pageContext.request.contextPath}/admin/change-password"
                class="nav-item ${pageContext.request.requestURI.contains('/change-password') ? 'active' : ''}">
                <i class="fas fa-key nav-icon"></i>
                <span>Cambiar Contraseña</span>
            </a>
        </nav>

        <div class="sidebar-footer">
            <div class="user-profile-mini">
                <div class="user-avatar">AD</div>
                <div style="flex: 1">
                    <div style="font-weight: 600; font-size: 0.9rem; color: white;">Administrador</div>
                    <div style="font-size: 0.75rem; color: var(--text-light);">admin@bookstore.com</div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" style="color: var(--text-light);"><i
                        class="fas fa-sign-out-alt"></i></a>
            </div>
        </div>
    </aside>