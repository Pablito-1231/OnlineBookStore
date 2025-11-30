<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <c:set var="pageTitle" value="${action eq 'edit' ? 'Editar Libro' : 'Nuevo Libro'}" scope="request" />
            <%@ include file="layouts/head-redesign.jsp" %>

                <body>
                    <div class="app-container">
                        <%@ include file="sidebar.jsp" %>

                            <main class="app-main">
                                <div class="top-bar">
                                    <div class="page-title">
                                        <h1>${action eq 'edit' ? 'Editar Libro' : 'Agregar Nuevo Libro'}</h1>
                                        <p>Completa la información del libro para el catálogo.</p>
                                    </div>
                                </div>

                                <div class="content-card" style="max-width: 800px; margin: 0 auto;">
                                    <form:form modelAttribute="book" method="POST"
                                        action="${pageContext.request.contextPath}${action eq 'edit' ? '/admin/libros/edit/process' : '/admin/libros/add/process'}">

                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <c:if test="${action eq 'edit'}">
                                            <form:hidden path="id" />
                                        </c:if>

                                        <div class="dashboard-grid"
                                            style="grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 0;">
                                            <div class="form-group">
                                                <label class="form-label">Nombre del Libro</label>
                                                <form:input path="name" class="form-control"
                                                    placeholder="Ej. El Principito" required="true" />
                                                <form:errors path="name"
                                                    cssStyle="color: var(--danger); font-size: 0.8rem; margin-top: 0.25rem; display: block;" />
                                            </div>

                                            <div class="form-group">
                                                <label class="form-label">Tipo / Formato</label>
                                                <select name="bookDetail.type" class="form-control" required>
                                                    <option value="">-- Selecciona --</option>
                                                    <option value="EBOOK" ${bookDetail.type eq 'EBOOK' ? 'selected' : ''
                                                        }>E-Book</option>
                                                    <option value="PAPERBACK" ${bookDetail.type eq 'PAPERBACK'
                                                        ? 'selected' : '' }>Tapa Blanda</option>
                                                    <option value="HARDCOVER" ${bookDetail.type eq 'HARDCOVER'
                                                        ? 'selected' : '' }>Tapa Dura</option>
                                                    <option value="AUDIOBOOK" ${bookDetail.type eq 'AUDIOBOOK'
                                                        ? 'selected' : '' }>Audiolibro</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="dashboard-grid"
                                            style="grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 0;">
                                            <div class="form-group">
                                                <label class="form-label">Precio (COP)</label>
                                                <form:input path="price" type="number" class="form-control"
                                                    placeholder="0" required="true" />
                                                <form:errors path="price"
                                                    cssStyle="color: var(--danger); font-size: 0.8rem; margin-top: 0.25rem; display: block;" />
                                            </div>

                                            <div class="form-group">
                                                <label class="form-label">Cantidad en Stock</label>
                                                <form:input path="quantity" type="number" class="form-control"
                                                    placeholder="0" required="true" />
                                                <form:errors path="quantity"
                                                    cssStyle="color: var(--danger); font-size: 0.8rem; margin-top: 0.25rem; display: block;" />
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Descripción / Detalles</label>
                                            <textarea name="bookDetail.detail" class="form-control" rows="4"
                                                placeholder="Sinopsis o detalles del libro...">${bookDetail.detail}</textarea>
                                        </div>

                                        <div
                                            style="display: flex; justify-content: flex-end; gap: 1rem; margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid var(--border-color);">
                                            <a href="${pageContext.request.contextPath}/admin/libros"
                                                class="btn btn-secondary">Cancelar</a>
                                            <button type="submit" class="btn btn-primary">
                                                ${action eq 'edit' ? 'Actualizar Libro' : 'Guardar Libro'}
                                            </button>
                                        </div>
                                    </form:form>
                                </div>
                            </main>
                    </div>
                </body>

                </html>