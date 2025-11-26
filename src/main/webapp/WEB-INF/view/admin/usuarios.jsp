<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Usuarios - Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                        <li class="breadcrumb-item active">Usuarios</li>
                    </ol>
                </nav>
                <h2 class="mb-2 fw-bold"><i class="fas fa-users me-2 text-dark"></i>Gestión de Usuarios</h2>
                <p class="text-muted mb-0">Administra los usuarios y sus roles en el sistema</p>
            </div>
        </div>
    </div>

    <!-- Mensajes de éxito/error -->
    <c:if test="${not empty message}">
        <div class="modern-alert ${messageType == 'success' ? 'success' : 'error'}">
            <div class="alert-icon">
                <i class="fas ${messageType == 'success' ? 'fa-check' : 'fa-times'}"></i>
            </div>
            <div class="alert-content">
                <strong>${messageType == 'success' ? '¡Éxito!' : '¡Error!'}</strong>
                <p>${message}</p>
            </div>
            <button type="button" class="alert-close" onclick="this.parentElement.style.display='none'">
                <i class="fas fa-times"></i>
            </button>
        </div>
    </c:if>

    <!-- Tabla de Usuarios -->
    <div style="overflow-x: hidden;">
        <table class="table table-hover align-middle mb-0 modern-table">
                    <thead>
                        <tr>
                            <th class="ps-4 py-3 fw-semibold">
                                <i class="fas fa-user me-2 text-secondary"></i>
                                Usuario
                            </th>
                            <th class="py-3 fw-semibold">
                                <i class="fas fa-id-card me-2 text-secondary"></i>
                                Información
                            </th>
                            <th class="py-3 fw-semibold">
                                <i class="fas fa-shield-alt me-2 text-secondary"></i>
                                Roles
                            </th>
                            <th class="py-3 fw-semibold">
                                <i class="fas fa-toggle-on me-2 text-secondary"></i>
                                Estado
                            </th>
                            <th class="text-end pe-4 py-3 fw-semibold">
                                <i class="fas fa-cogs me-2 text-secondary"></i>
                                Acciones
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center">
                                        <div class="user-icon-placeholder me-3">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <div>
                                            <div class="fw-bold text-dark">${u.username}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty u.customer}">
                                            <div class="fw-bold">${u.customer.firstName} ${u.customer.lastName}</div>
                                            <small class="text-muted"><i class="fas fa-envelope me-1"></i>${u.customer.email}</small>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted fst-italic">Sin perfil de cliente</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:forEach var="auth" items="${u.authorities}">
                                        <span class="badge ${auth.role == 'ROLE_ADMIN' ? 'bg-danger-subtle text-danger' : 'bg-secondary-subtle text-secondary'} px-3 py-2">
                                            <i class="fas ${auth.role == 'ROLE_ADMIN' ? 'fa-shield-alt' : 'fa-user'} me-1"></i>
                                            ${auth.role}
                                        </span>
                                    </c:forEach>
                                    <c:if test="${empty u.authorities}">
                                        <span class="badge bg-secondary-subtle text-secondary px-3 py-2">Sin Rol</span>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.enabled}">
                                            <span class="badge rounded-pill bg-success-subtle text-success px-3 py-2">
                                                <i class="fas fa-check-circle me-1"></i>Activo
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge rounded-pill bg-secondary-subtle text-secondary px-3 py-2">
                                                <i class="fas fa-times-circle me-1"></i>Inactivo
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-4">
                                    <div class="btn-group" role="group">
                                        <c:choose>
                                            <c:when test="${u.enabled}">
                                                <a href="${pageContext.request.contextPath}/admin/usuarios/toggle?username=${u.username}" 
                                                   class="btn btn-sm btn-outline-warning" 
                                                   title="Deshabilitar usuario">
                                                    <i class="fas fa-ban"></i>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/admin/usuarios/toggle?username=${u.username}" 
                                                   class="btn btn-sm btn-outline-success" 
                                                   title="Habilitar usuario">
                                                    <i class="fas fa-check"></i>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                                     <a href="${pageContext.request.contextPath}/admin/usuarios/edit?username=${u.username}" 
                                                         class="btn btn-sm btn-edit" 
                                           title="Editar usuario">
                                            <i class="fas fa-edit"></i>
                                        </a>

                                        <c:if test="${u.username != 'admin'}">
                                            <a href="${pageContext.request.contextPath}/admin/usuarios/delete?username=${u.username}" 
                                               class="btn btn-sm btn-outline-danger" 
                                               title="Eliminar usuario" 
                                               onclick="return confirm('¿Estás seguro de eliminar el usuario ${u.username}?')">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${u.username == 'admin'}">
                                            <button class="btn btn-sm btn-outline-secondary" disabled title="No se puede eliminar el admin">
                                                <i class="fas fa-lock"></i>
                                            </button>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
    </div>

</main>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
