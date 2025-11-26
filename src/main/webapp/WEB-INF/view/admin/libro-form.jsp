<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html style="margin:0;padding:0;overflow-x:hidden;">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${action eq 'edit' ? 'Editar' : 'Agregar'} Libro - Administrador</title>
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
        <a href="${pageContext.request.contextPath}/admin/libros" class="admin-nav-item active">
            <i class="fas fa-book"></i>
            <span>Gestión de Libros</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/usuarios" class="admin-nav-item">
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
    
    <div class="container-fluid p-0">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                
                <div class="card shadow-lg border-0 rounded-lg mt-4">
                    <div class="card-header bg-primary text-white">
                        <h3 class="text-center font-weight-light my-2">
                            ${action eq 'edit' ? 'Editar Libro' : 'Agregar Nuevo Libro'}
                        </h3>
                    </div>
                    <div class="card-body p-5">
                        <form:form modelAttribute="book" method="POST" 
                                   action="${action eq 'edit' ? '/admin/libros/edit/process' : '/admin/libros/add/process'}">
                            
                            <!-- ID (solo para editar) -->
                            <c:if test="${action eq 'edit'}">
                                <form:hidden path="id"/>
                            </c:if>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <form:input path="name" type="text" class="form-control" id="inputName" placeholder="Nombre del libro" required="true"/>
                                        <label for="inputName">Nombre del Libro</label>
                                        <form:errors path="name" class="text-danger small"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <form:select path="bookDetail.type" class="form-select" id="inputType" required="true">
                                            <option value="">-- Selecciona --</option>
                                            <option value="EBOOK">E-Book</option>
                                            <option value="PAPERBACK">Tapa Blanda</option>
                                            <option value="HARDCOVER">Tapa Dura</option>
                                            <option value="AUDIOBOOK">Audiolibro</option>
                                        </form:select>
                                        <label for="inputType">Tipo de Libro</label>
                                        <form:errors path="bookDetail.type" class="text-danger small"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <form:input path="price" type="number" step="0.01" class="form-control" id="inputPrice" placeholder="Precio" required="true"/>
                                        <label for="inputPrice">Precio ($)</label>
                                        <form:errors path="price" class="text-danger small"/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <form:input path="quantity" type="number" class="form-control" id="inputQty" placeholder="Cantidad" required="true"/>
                                        <label for="inputQty">Cantidad en Stock</label>
                                        <form:errors path="quantity" class="text-danger small"/>
                                    </div>
                                </div>
                            </div>

                            <div class="form-floating mb-4">
                                <form:textarea path="bookDetail.detail" class="form-control" id="inputDetail" placeholder="Detalles" style="height: 100px"/>
                                <label for="inputDetail">Descripción / Detalles</label>
                            </div>

                            <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/admin/libros">
                                    <i class="fas fa-arrow-left"></i> Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary px-4">
                                    ${action eq 'edit' ? 'Actualizar Libro' : 'Guardar Libro'} <i class="fas fa-save ms-1"></i>
                                </button>
                            </div>
                        </form:form>
                    </div>
                </div>

            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
