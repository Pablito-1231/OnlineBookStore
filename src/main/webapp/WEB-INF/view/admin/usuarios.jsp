<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html style="margin:0;padding:0;overflow-x:hidden;">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Usuarios - Administrador</title>
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
        <a href="${pageContext.request.contextPath}/admin/usuarios" class="admin-nav-item active">
            <i class="fas fa-users"></i>
            <span>Usuarios</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/estadisticas" class="admin-nav-item">
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
            <h2 class="mb-1">Gestión de Usuarios</h2>
            <p class="text-muted mb-0">Administra los usuarios registrados</p>
        </div>
    </div>

    <!-- Mensajes de éxito/error -->
    <c:if test="${not empty message}">
        <div class="alert alert-${messageType == 'success' ? 'success' : 'danger'} alert-dismissible fade show" role="alert">
            <i class="fas fa-${messageType == 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Users Table -->
    <div class="card shadow-sm border-0 rounded-lg">
        <div class="card-header bg-white py-3">
            <h6 class="m-0 font-weight-bold text-primary">Lista de Usuarios</h6>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-admin mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="border-0">Username</th>
                            <th class="border-0">Usuario</th>
                            <th class="border-0">Rol</th>
                            <th class="border-0">Estado</th>
                            <th class="border-0 text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>${u.username}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="rounded-circle bg-light d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px;">
                                            <i class="fas fa-user text-secondary"></i>
                                        </div>
                                        <div>
                                            <c:choose>
                                                <c:when test="${not empty u.customer}">
                                                    <div class="fw-bold">${u.customer.firstName} ${u.customer.lastName}</div>
                                                    <small class="text-muted">${u.customer.email}</small>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="fw-bold">${u.username}</div>
                                                    <small class="text-muted">Sin perfil de cliente</small>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <c:forEach var="auth" items="${u.authorities}">
                                        <span class="badge ${auth.role == 'ROLE_ADMIN' ? 'bg-danger' : 'bg-primary'}">
                                            ${auth.role}
                                        </span>
                                    </c:forEach>
                                    <c:if test="${empty u.authorities}">
                                        <span class="badge bg-secondary">Sin Rol</span>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.enabled}">
                                            <span class="badge bg-success">
                                                <i class="fas fa-check-circle"></i> Activo
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">
                                                <i class="fas fa-times-circle"></i> Inactivo
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end">
                                    <c:choose>
                                        <c:when test="${u.enabled}">
                                            <a href="${pageContext.request.contextPath}/admin/usuarios/toggle?username=${u.username}" class="btn btn-sm btn-outline-warning me-1" title="Deshabilitar">
                                                <i class="fas fa-ban"></i>
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/admin/usuarios/toggle?username=${u.username}" class="btn btn-sm btn-outline-success me-1" title="Habilitar">
                                                <i class="fas fa-check"></i>
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <a href="${pageContext.request.contextPath}/admin/usuarios/edit?username=${u.username}" class="btn btn-sm btn-outline-primary me-1" title="Editar">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <c:if test="${u.username != 'admin'}">
                                        <a href="${pageContext.request.contextPath}/admin/usuarios/delete?username=${u.username}" class="btn btn-sm btn-outline-danger" title="Eliminar" onclick="return confirm('¿Estás seguro de eliminar el usuario ${u.username}?')">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${u.username == 'admin'}">
                                        <button class="btn btn-sm btn-outline-secondary" disabled title="No se puede eliminar el admin">
                                            <i class="fas fa-lock"></i>
                                        </button>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
