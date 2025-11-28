<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="layouts/admin-layout-header.jsp" %>
    
    <!-- Header Glassmorphism -->
    <div class="admin-page-header mb-4 glass-header-main">
        <div class="d-flex justify-content-between align-items-start">
            <div>
                <h2 class="mb-1"><i class="fas fa-chart-bar me-2 text-warning"></i>Estadísticas del Sistema</h2>
                <p class="text-muted mb-0">Visión general del rendimiento de la librería</p>
            </div>
        </div>
    </div>

    <!-- Estadísticas principales Glassmorphism -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="glass-card h-100">
                <div class="glass-icon-card">
                    <i class="fas fa-book text-warning"></i>
                </div>
                <div class="admin-stat-value">${totalLibros}</div>
                <div class="admin-stat-label">Total de Libros</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="glass-card h-100">
                <div class="glass-icon-card">
                    <i class="fas fa-check-circle text-warning"></i>
                </div>
                <div class="admin-stat-value">${librosDisponibles}</div>
                <div class="admin-stat-label">Libros Disponibles</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="glass-card h-100">
                <div class="glass-icon-card">
                    <i class="fas fa-exclamation-triangle text-warning"></i>
                </div>
                <div class="admin-stat-value">${librosAgotados}</div>
                <div class="admin-stat-label">Libros Agotados</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="glass-card h-100">
                <div class="glass-icon-card">
                    <i class="fas fa-users text-warning"></i>
                </div>
                <div class="admin-stat-value">${totalUsuarios}</div>
                <div class="admin-stat-label">Usuarios Registrados</div>
            </div>
        </div>
    </div>

    <!-- Charts Section (Placeholder for future) -->
    <div class="row">
        <div class="col-lg-8 mb-4">
            <div class="card shadow-sm border-0 rounded-lg">
                <div class="card-header bg-white py-3 d-flex flex-row align-items-center justify-content-between">
                    <h6 class="m-0 font-weight-bold text-primary">Resumen de Actividad</h6>
                </div>
                <div class="card-body">
                    <div class="text-center py-5 text-muted">
                        <i class="fas fa-chart-area fa-3x mb-3"></i>
                        <p>Gráficos detallados próximamente...</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 mb-4">
            <div class="card shadow-sm border-0 rounded-lg">
                <div class="card-header bg-white py-3">
                    <h6 class="m-0 font-weight-bold text-primary">Distribución por Tipo</h6>
                </div>
                <div class="card-body">
                    <div class="text-center py-5 text-muted">
                        <i class="fas fa-chart-pie fa-3x mb-3"></i>
                        <p>Gráfico circular próximamente...</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Información adicional -->
    <div class="alert alert-info border-0 shadow-sm rounded-lg">
        <i class="fas fa-info-circle me-2"></i>
        <strong>Nota:</strong> Las estadísticas se actualizan en tiempo real según los datos en la base de datos.
    </div>

<%@ include file="layouts/admin-layout-footer.jsp" %>