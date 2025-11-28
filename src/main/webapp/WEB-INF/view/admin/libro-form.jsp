<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="layouts/admin-layout-header.jsp" %>
    
    <div class="container-fluid p-0">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                
                <div class="glass-card mt-4">
                    <div class="glass-header-main p-4">
                        <h3 class="text-center font-weight-light my-2">
                            <i class="fas fa-book-open me-2 text-warning"></i>
                            ${action eq 'edit' ? 'Editar Libro' : 'Agregar Nuevo Libro'}
                        </h3>
                    </div>
                    <div class="card-body p-5">
                        <form:form modelAttribute="book" method="POST" 
                                   action="${pageContext.request.contextPath}${action eq 'edit' ? '/admin/libros/edit/process' : '/admin/libros/add/process'}">
                            
                            <!-- Token CSRF explícito para compatibilidad con ngrok -->
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            
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
                                        <select name="bookDetail.type" class="form-select" id="inputType" required>
                                            <option value="">-- Selecciona --</option>
                                            <option value="EBOOK" ${bookDetail.type eq 'EBOOK' ? 'selected' : ''}>E-Book</option>
                                            <option value="PAPERBACK" ${bookDetail.type eq 'PAPERBACK' ? 'selected' : ''}>Tapa Blanda</option>
                                            <option value="HARDCOVER" ${bookDetail.type eq 'HARDCOVER' ? 'selected' : ''}>Tapa Dura</option>
                                            <option value="AUDIOBOOK" ${bookDetail.type eq 'AUDIOBOOK' ? 'selected' : ''}>Audiolibro</option>
                                        </select>
                                        <label for="inputType">Tipo de Libro</label>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3 mb-md-0">
                                        <form:input path="price" type="number" step="1" class="form-control" id="inputPrice" placeholder="Precio" required="true"/>
                                        <label for="inputPrice">Precio (COP)</label>
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
                                <textarea name="bookDetail.detail" class="form-control" id="inputDetail" placeholder="Detalles" style="height: 100px">${bookDetail.detail}</textarea>
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

<%@ include file="layouts/admin-layout-footer.jsp" %>
