<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Roles - Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-modern.css">
</head>
<body>
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
        <a href="${pageContext.request.contextPath}/admin/roles" class="admin-nav-item active">
            <i class="fas fa-user-shield"></i>
            <span>Roles</span>
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
<div class="admin-main">
    <div class="container-fluid p-0">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-lg border-0 rounded-lg mt-4">
                    <div class="card-header bg-primary text-white">
                        <h3 class="text-center font-weight-light my-2">
                            <i class="fas fa-user-shield me-2"></i> Gestión de Roles
                        </h3>
                    </div>
                    <div class="card-body p-5">
                        <h5>Roles existentes</h5>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Rol</th>
                                    <th>Usuarios con este rol</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="role" items="${roles}">
                                    <tr>
                                        <td>${role.name}</td>
                                        <td>${role.count}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <hr>
                        <h5>Crear nuevo rol</h5>
                        <form method="POST" action="${pageContext.request.contextPath}/admin/roles/add">
                            <div class="mb-3">
                                <label class="form-label">Nombre del rol</label>
                                <input type="text" name="roleName" class="form-control" required placeholder="Ej: ROLE_MANAGER">
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Crear Rol
                            </button>
                        </form>
                        <c:if test="${not empty message}">
                            <div class="alert alert-info mt-3">${message}</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
