<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Estadísticas - Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-unified.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-modern.css">
</head>
<body class="admin-wrapper">
<div style="display: flex; margin: 0; padding: 0;">

<%@ include file="sidebar.jsp" %>

<!-- Contenido Principal -->
<main class="admin-main">
    
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
                <div class="admin-stat-header">
                    <div class="admin-stat-icon primary">
                        <i class="fas fa-book"></i>
                    </div>
                </div>
                <div class="admin-stat-value">${totalLibros}</div>
                <div class="admin-stat-label">Total de Libros</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="admin-stat-card h-100">
                <div class="admin-stat-header">
                    <div class="admin-stat-icon success">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
                <div class="admin-stat-value">${librosDisponibles}</div>
                <div class="admin-stat-label">Libros Disponibles</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="admin-stat-card h-100">
                <div class="admin-stat-header">
                    <div class="admin-stat-icon danger">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                </div>
                <div class="admin-stat-value">${librosAgotados}</div>
                <div class="admin-stat-label">Libros Agotados</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="admin-stat-card h-100">
                <div class="admin-stat-header">
                    <div class="admin-stat-icon warning">
                        <i class="fas fa-users"></i>
                    </div>
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

</main>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>