<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-nav-item active">
                    <i class="fas fa-home admin-nav-icon"></i>
                    <span class="admin-nav-text">Dashboard</span>
                </a>
            </div>

            <div class="admin-nav-section">
                <div class="admin-nav-title">Gestión</div>
                <a href="${pageContext.request.contextPath}/admin/libros" class="admin-nav-item">
                    <i class="fas fa-book admin-nav-icon"></i>
                    <span class="admin-nav-text">Libros</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/usuarios" class="admin-nav-item">
                    <i class="fas fa-users admin-nav-icon"></i>
                    <span class="admin-nav-text">Usuarios</span>
                </a>
            </div>

            <div class="admin-nav-section">
                <div class="admin-nav-title">Análisis</div>
                <a href="${pageContext.request.contextPath}/admin/estadisticas" class="admin-nav-item">
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

    <!-- Contenido Principal -->
    <main class="admin-main">
        
        <!-- Header -->
        <div class="admin-header">
            <div class="admin-header-top">
                <h1>Panel de Control</h1>
                <div class="admin-header-actions">
                    <button class="btn-admin primary">
                        <i class="fas fa-sync"></i> Actualizar
                    </button>
                </div>
            </div>
            <div class="admin-breadcrumb">
                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-home"></i> Inicio
                </a>
                <i class="fas fa-chevron-right"></i>
                <span>Dashboard</span>
            </div>
        </div>

        <!-- Estadísticas -->
        <div class="admin-stats-grid">
            
            <div class="admin-stat-card">
                <div class="admin-stat-header">
                    <div class="admin-stat-icon primary">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="admin-stat-trend up">
                        <i class="fas fa-arrow-up"></i> 12%
                    </div>
                </div>
                <div class="admin-stat-value">${totalUsuarios}</div>
                <div class="admin-stat-label">Usuarios Registrados</div>
            </div>

            <div class="admin-stat-card">
                <div class="admin-stat-header">
                    <div class="admin-stat-icon success">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="admin-stat-trend up">
                        <i class="fas fa-arrow-up"></i> 8%
                    </div>
                </div>
                <div class="admin-stat-value">${librosDisponibles}</div>
                <div class="admin-stat-label">Libros Disponibles</div>
            </div>

            <div class="admin-stat-card">
                <div class="admin-stat-header">
                    <div class="admin-stat-icon warning">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="admin-stat-trend up">
                        <i class="fas fa-arrow-up"></i> 24%
                    </div>
                </div>
                <div class="admin-stat-value">${comprasTotales}</div>
                <div class="admin-stat-label">Compras Realizadas</div>
            </div>

            <div class="admin-stat-card">
                <div class="admin-stat-header">
                    <div class="admin-stat-icon danger">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <div class="admin-stat-trend up">
                        <i class="fas fa-arrow-up"></i> 18%
                    </div>
                </div>
                <div class="admin-stat-value">$12,450</div>
                <div class="admin-stat-label">Ingresos Totales</div>
            </div>

        </div>

        <!-- Acciones Rápidas -->
        <div class="admin-card">
            <div class="admin-card-header">
                <h3 class="admin-card-title">
                    <i class="fas fa-bolt"></i> Acciones Rápidas
                </h3>
            </div>
            <div class="admin-card-body">
                <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                    <a href="${pageContext.request.contextPath}/admin/libros/add" class="btn-admin primary lg">
                        <i class="fas fa-plus"></i> Agregar Libro
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/libros" class="btn-admin success lg">
                        <i class="fas fa-book"></i> Ver Todos los Libros
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/usuarios" class="btn-admin warning lg">
                        <i class="fas fa-users"></i> Gestionar Usuarios
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/estadisticas" class="btn-admin secondary lg">
                        <i class="fas fa-chart-line"></i> Ver Estadísticas
                    </a>
                </div>
            </div>
        </div>

    </main>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>