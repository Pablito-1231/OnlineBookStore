<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${action eq 'edit' ? 'Editar Usuario' : 'Nuevo Usuario'} - Administrador</title>
    <link href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme-unified.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-modern.css">
</head>
<body class="admin-wrapper">
<div style="display: flex; margin: 0; padding: 0;">

<%@ include file="sidebar.jsp" %>

<!-- Contenido Principal -->
<main class="admin-main">
    
    <div class="container-fluid p-0">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                
                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mb-3">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/usuarios">Usuarios</a></li>
                        <li class="breadcrumb-item active">${action eq 'edit' ? 'Editar' : 'Nuevo'}</li>
                    </ol>
                </nav>

                <div class="card shadow-lg border-0 rounded-lg">
                    <div class="card-header bg-primary text-white">
                        <h3 class="text-center font-weight-light my-2">
                            <i class="fas fa-user-edit me-2"></i>
                            ${action eq 'edit' ? 'Editar Usuario' : 'Nuevo Usuario'}
                        </h3>
                    </div>
                    <div class="card-body p-5">
                        
                        <!-- Mensajes de éxito/error -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-${messageType == 'success' ? 'success' : 'danger'} alert-dismissible fade show" role="alert">
                                <i class="fas fa-${messageType == 'success' ? 'check-circle' : 'exclamation-triangle'} me-2"></i>
                                ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <form method="POST" action="${pageContext.request.contextPath}/admin/usuarios/edit/process">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            
                            <!-- Username original (hidden) -->
                            <input type="hidden" name="username" value="${user.username}">
                            <!-- Username solo lectura -->
                            <div class="mb-4">
                                <label class="form-label">
                                    <i class="fas fa-user me-2"></i>Username
                                </label>
                                <input type="text" class="form-control" 
                                       value="${user.username}" readonly style="background-color: #f8f9fa;">
                                <small class="text-muted">El username no puede ser modificado</small>
                            </div>

                            <!-- Información del Customer editable -->
                            <c:if test="${not empty user.customer}">
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="fas fa-id-card me-2"></i>Nombre
                                        </label>
                                        <input type="text" name="firstName" class="form-control" 
                                               value="${user.customer.firstName}" required
                                               ${user.username == 'admin' ? 'readonly style="background-color: #f8f9fa;"' : ''}>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">
                                            <i class="fas fa-id-card me-2"></i>Apellido
                                        </label>
                                        <input type="text" name="lastName" class="form-control" 
                                               value="${user.customer.lastName}" required
                                               ${user.username == 'admin' ? 'readonly style="background-color: #f8f9fa;"' : ''}>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">
                                        <i class="fas fa-envelope me-2"></i>Email
                                    </label>
                                    <input type="email" name="email" class="form-control" 
                                           value="${user.customer.email}" required
                                           ${user.username == 'admin' ? 'readonly style="background-color: #f8f9fa;"' : ''}>
                                </div>
                            </c:if>

                            <!-- Roles -->
                            <div class="mb-4">
                                <label class="form-label">
                                    <i class="fas fa-shield-alt me-2"></i>Rol
                                </label>
                                <select name="role" class="form-select" ${user.username == 'admin' ? 'disabled style="background-color: #f8f9fa;"' : ''}>
                                    <option value="ROLE_USER" ${user.authorities[0] != null && user.authorities[0].role == 'ROLE_USER' ? 'selected' : ''}>Usuario</option>
                                    <option value="ROLE_ADMIN" ${user.authorities[0] != null && user.authorities[0].role == 'ROLE_ADMIN' ? 'selected' : ''}>Administrador</option>
                                </select>
                                <c:if test="${user.username == 'admin'}">
                                    <input type="hidden" name="role" value="${user.authorities[0].role}">
                                </c:if>
                            </div>

                            <!-- Estado (Habilitado/Deshabilitado) -->
                            <div class="mb-4">
                                <label class="form-label">
                                    <i class="fas fa-toggle-on me-2"></i>Estado de la Cuenta
                                </label>
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" name="enabled" 
                                           id="enabled" ${user.enabled ? 'checked' : ''}
                                           ${user.username == 'admin' ? 'disabled' : ''}>
                                    <label class="form-check-label" for="enabled">
                                        <span id="statusLabel">${user.enabled ? 'Activo' : 'Inactivo'}</span>
                                    </label>
                                </div>
                                <small class="text-muted">
                                    Los usuarios deshabilitados no pueden iniciar sesión
                                </small>
                            </div>

                            <!-- Advertencia para usuario admin -->
                            <c:if test="${user.username == 'admin'}">
                                <div class="alert alert-warning" role="alert">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    <strong>Advertencia:</strong> Este es el usuario administrador principal del sistema.
                                </div>
                            </c:if>

                            <!-- Botones -->
                            <div class="d-flex justify-content-between mt-5">
                                <a href="${pageContext.request.contextPath}/admin/usuarios" 
                                   class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Volver
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Guardar Cambios
                                </button>
                            </div>
                        </form>

                    </div>
                </div>

            </div>
        </div>
    </div>

</main>

</div>

<script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
    // Actualizar label del estado dinámicamente
    document.getElementById('enabled').addEventListener('change', function() {
        const label = document.getElementById('statusLabel');
        label.textContent = this.checked ? 'Activo' : 'Inactivo';
    });
</script>
</body>
</html>
