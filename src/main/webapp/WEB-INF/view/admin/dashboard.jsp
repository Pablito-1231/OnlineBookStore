<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Panel de Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-unified.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-modern.css">
</head>
<body class="admin-wrapper">
<div style="display: flex; margin: 0; padding: 0;">
<fmt:setLocale value="es_CO"/>

<%@ include file="sidebar.jsp" %>

    <!-- Contenido Principal -->
    <main class="admin-main">
        
        <!-- Header Mejorado -->
        <div class="admin-page-header mb-4">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <nav aria-label="breadcrumb" class="mb-2">
                        <ol class="breadcrumb mb-0">
                            <li class="breadcrumb-item active"><i class="fas fa-home me-1"></i>Dashboard</li>
                        </ol>
                    </nav>
                    <h2 class="mb-2 fw-bold"><i class="fas fa-tachometer-alt me-2 text-primary"></i>Panel de Control</h2>
                    <p class="text-muted mb-0">Resumen general de la actividad de la librería</p>
                </div>
                <button class="btn btn-outline-primary shadow-sm" onclick="location.reload()">
                    <i class="fas fa-sync-alt me-2"></i>Actualizar
                </button>
            </div>
        </div>

        <!-- Estadísticas -->
        <div class="row g-3 mb-4">
            
            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 stat-card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="stat-icon-modern bg-primary-subtle">
                                <i class="fas fa-users text-primary"></i>
                            </div>
                            <span class="badge bg-success-subtle text-success">
                                <i class="fas fa-arrow-up me-1"></i>12%
                            </span>
                        </div>
                        <h3 class="mb-1 fw-bold display-6">${totalUsuarios}</h3>
                        <p class="text-muted mb-0 small">Usuarios Registrados</p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 stat-card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="stat-icon-modern bg-success-subtle">
                                <i class="fas fa-book text-success"></i>
                            </div>
                            <span class="badge bg-success-subtle text-success">
                                <i class="fas fa-arrow-up me-1"></i>8%
                            </span>
                        </div>
                        <h3 class="mb-1 fw-bold display-6">${librosDisponibles}</h3>
                        <p class="text-muted mb-0 small">Libros Disponibles</p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 stat-card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="stat-icon-modern bg-warning-subtle">
                                <i class="fas fa-shopping-cart text-warning"></i>
                            </div>
                            <span class="badge bg-success-subtle text-success">
                                <i class="fas fa-arrow-up me-1"></i>24%
                            </span>
                        </div>
                        <h3 class="mb-1 fw-bold display-6">${comprasTotales}</h3>
                        <p class="text-muted mb-0 small">Compras Realizadas</p>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card border-0 shadow-sm h-100 stat-card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="stat-icon-modern bg-danger-subtle">
                                <i class="fas fa-money-bill-wave text-danger"></i>
                            </div>
                            <span class="badge bg-success-subtle text-success">
                                <i class="fas fa-arrow-up me-1"></i>18%
                            </span>
                        </div>
                        <h3 class="mb-1 fw-bold display-6">$ <fmt:formatNumber value="${ingresosTotales}" type="number" groupingUsed="true" minFractionDigits="0"/> COP</h3>
                        <p class="text-muted mb-0 small">Ingresos Totales</p>
                    </div>
                </div>
            </div>

        </div>

        <!-- Indicadores adicionales -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 stat-card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="stat-icon-modern bg-info-subtle">
                                <i class="fas fa-calendar-check text-info"></i>
                            </div>
                            <span class="badge bg-info-subtle text-info">Mes actual</span>
                        </div>
                        <h3 class="mb-1 fw-bold display-6">${comprasMesActual}</h3>
                        <p class="text-muted mb-0 small">Compras del Mes</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 stat-card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="stat-icon-modern bg-success-subtle">
                                <i class="fas fa-sack-dollar text-success"></i>
                            </div>
                            <span class="badge bg-success-subtle text-success">Mes actual</span>
                        </div>
                        <h3 class="mb-1 fw-bold display-6">$ <fmt:formatNumber value="${ingresosMesActual}" type="number" groupingUsed="true" minFractionDigits="0"/> COP</h3>
                        <p class="text-muted mb-0 small">Ingresos del Mes</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm h-100 stat-card-hover">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="stat-icon-modern bg-secondary-subtle">
                                <i class="fas fa-receipt text-secondary"></i>
                            </div>
                            <span class="badge bg-secondary-subtle text-secondary">Promedio del mes</span>
                        </div>
                        <h3 class="mb-1 fw-bold display-6">$ <fmt:formatNumber value="${ticketPromedioMes}" type="number" groupingUsed="true" minFractionDigits="0"/> COP</h3>
                        <p class="text-muted mb-0 small">Ticket Promedio</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Acciones Rápidas -->
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white border-bottom py-3">
                <h5 class="mb-0 fw-semibold">
                    <i class="fas fa-bolt me-2 text-warning"></i>Acciones Rápidas
                </h5>
            </div>
            <div class="card-body p-4">
                <div class="d-flex gap-3 flex-wrap">
                    <a href="${pageContext.request.contextPath}/admin/libros/add" class="btn btn-primary btn-lg flex-grow-1">
                        <i class="fas fa-plus-circle me-2"></i>Agregar Libro
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/libros" class="btn btn-outline-success btn-lg flex-grow-1">
                        <i class="fas fa-book me-2"></i>Ver Catálogo
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn btn-outline-warning btn-lg flex-grow-1">
                        <i class="fas fa-users-cog me-2"></i>Gestionar Usuarios
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/estadisticas" class="btn btn-outline-secondary btn-lg flex-grow-1">
                        <i class="fas fa-chart-line me-2"></i>Ver Reportes
                    </a>
                </div>
            </div>
        </div>

    </main>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
