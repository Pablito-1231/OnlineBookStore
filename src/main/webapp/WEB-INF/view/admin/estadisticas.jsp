<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html style="margin:0;padding:0;overflow-x:hidden;">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Estadísticas - Administrador</title>
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
        <a href="${pageContext.request.contextPath}/admin/libros" class="admin-nav-item">
            <i class="fas fa-book"></i>
            <span>Gestión de Libros</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/usuarios" class="admin-nav-item">
            <i class="fas fa-users"></i>
            <span>Usuarios</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/estadisticas" class="admin-nav-item active">
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
            <h2 class="mb-1">Estadísticas del Sistema</h2>
            <p class="text-muted mb-0">Visión general del rendimiento de la librería</p>
        </div>
    </div>

    <!-- Estadísticas principales -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="admin-stat-card h-100">
                <div class="stat-icon" style="background: rgba(78, 115, 223, 0.1); color: #4e73df;">
                    <i class="fas fa-book"></i>
                </div>
                <div class="stat-info">
                    <h3>${totalLibros}</h3>
                    <p>Total de Libros</p>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="admin-stat-card h-100">
                <div class="stat-icon" style="background: rgba(28, 200, 138, 0.1); color: #1cc88a;">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-info">
                    <h3>${librosDisponibles}</h3>
                    <p>Libros Disponibles</p>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="admin-stat-card h-100">
                <div class="stat-icon" style="background: rgba(231, 74, 59, 0.1); color: #e74a3b;">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <div class="stat-info">
                    <h3>${librosAgotados}</h3>
                    <p>Libros Agotados</p>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="admin-stat-card h-100">
                <div class="stat-icon" style="background: rgba(54, 185, 204, 0.1); color: #36b9cc;">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-info">
                    <h3>${totalUsuarios}</h3>
                    <p>Usuarios Registrados</p>
                </div>
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

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>