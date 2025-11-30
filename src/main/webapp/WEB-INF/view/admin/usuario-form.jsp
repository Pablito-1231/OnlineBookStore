<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <c:set var="pageTitle" value="${action eq 'edit' ? 'Editar Usuario' : 'Nuevo Usuario'}" scope="request" />
        <%@ include file="layouts/head-redesign.jsp" %>

            <body>
                <div class="app-container">
                    <%@ include file="sidebar.jsp" %>

                        <main class="app-main">
                            <div class="top-bar">
                                <div class="page-title">
                                    <h1>${action eq 'edit' ? 'Editar Usuario' : 'Nuevo Usuario'}</h1>
                                    <p>Gestiona la información y permisos del usuario.</p>
                                </div>
                            </div>

                            <div class="content-card" style="max-width: 800px; margin: 0 auto;">
                                <form method="POST"
                                    action="${pageContext.request.contextPath}/admin/usuarios/edit/process">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <input type="hidden" name="username" value="${user.username}">

                                    <div class="form-group">
                                        <label class="form-label">Username</label>
                                        <input type="text" class="form-control" value="${user.username}" readonly
                                            style="background-color: #f9fafb; color: var(--text-muted);">
                                        <small style="color: var(--text-muted); font-size: 0.8rem;">El nombre de usuario
                                            no se puede modificar.</small>
                                    </div>

                                    <c:if test="${not empty user.customer}">
                                        <div class="dashboard-grid"
                                            style="grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 0;">
                                            <div class="form-group">
                                                <label class="form-label">Nombre</label>
                                                <input type="text" name="firstName" class="form-control"
                                                    value="${user.customer.firstName}" required ${user.username=='admin'
                                                    ? 'readonly' : '' }>
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Apellido</label>
                                                <input type="text" name="lastName" class="form-control"
                                                    value="${user.customer.lastName}" required ${user.username=='admin'
                                                    ? 'readonly' : '' }>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label">Email</label>
                                            <input type="email" name="email" class="form-control"
                                                value="${user.customer.email}" required ${user.username=='admin'
                                                ? 'readonly' : '' }>
                                        </div>
                                    </c:if>

                                    <div class="dashboard-grid"
                                        style="grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 0;">
                                        <div class="form-group">
                                            <label class="form-label">Rol</label>
                                            <select name="role" class="form-control" ${user.username=='admin'
                                                ? 'disabled' : '' }>
                                                <option value="ROLE_USER" ${user.authorities[0] !=null &&
                                                    user.authorities[0].role=='ROLE_USER' ? 'selected' : '' }>Usuario
                                                </option>
                                                <option value="ROLE_ADMIN" ${user.authorities[0] !=null &&
                                                    user.authorities[0].role=='ROLE_ADMIN' ? 'selected' : '' }>
                                                    Administrador</option>
                                            </select>
                                            <c:if test="${user.username == 'admin'}">
                                                <input type="hidden" name="role" value="${user.authorities[0].role}">
                                            </c:if>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Estado</label>
                                            <div
                                                style="display: flex; align-items: center; gap: 0.5rem; margin-top: 0.5rem;">
                                                <input type="checkbox" name="enabled" id="enabled" ${user.enabled
                                                    ? 'checked' : '' } ${user.username=='admin' ? 'disabled' : '' }
                                                    style="width: 20px; height: 20px;">
                                                <label for="enabled" style="margin: 0; font-weight: 500;">Cuenta
                                                    Activa</label>
                                            </div>
                                        </div>
                                    </div>

                                    <c:if test="${user.username == 'admin'}">
                                        <div
                                            style="background: #fef3c7; color: #92400e; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem; font-size: 0.9rem;">
                                            <i class="fas fa-exclamation-triangle"></i> <strong>Advertencia:</strong>
                                            Este es el usuario administrador principal. Algunas opciones están
                                            bloqueadas.
                                        </div>
                                    </c:if>

                                    <div
                                        style="display: flex; justify-content: flex-end; gap: 1rem; margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid var(--border-color);">
                                        <a href="${pageContext.request.contextPath}/admin/usuarios"
                                            class="btn btn-secondary">Cancelar</a>
                                        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                                    </div>
                                </form>
                            </div>
                        </main>
                </div>
            </body>

            </html>