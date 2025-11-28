<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Roles - Administrador</title>
    <link href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-modern.css">
</head>
<%@ include file="layouts/admin-layout-header.jsp" %>
<!-- Contenido Principal -->
<main class="admin-main">
    <div class="container-fluid p-0">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="glass-card mt-4">
                    <div class="glass-header-main p-4">
                        <h3 class="text-center font-weight-light my-2">
                            <i class="fas fa-user-shield me-2 text-warning"></i> Gestión de Roles
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
                            <button type="submit" class="btn btn-warning">
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
</main>
</div>
<%@ include file="layouts/admin-layout-footer.jsp" %>
