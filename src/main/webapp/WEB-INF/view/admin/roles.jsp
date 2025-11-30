<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:set var="pageTitle" value="Gestión de Roles" scope="request" />
        <%@ include file="layouts/head-redesign.jsp" %>

            <body>
                <div class="app-container">
                    <%@ include file="sidebar.jsp" %>

                        <main class="app-main">
                            <div class="top-bar">
                                <div class="page-title">
                                    <h1>Gestión de Roles</h1>
                                    <p>Administra los roles y permisos del sistema.</p>
                                </div>
                            </div>

                            <div class="dashboard-grid" style="grid-template-columns: 2fr 1fr; align-items: start;">
                                <!-- Roles List -->
                                <div class="content-card">
                                    <div class="card-title">Roles Definidos</div>
                                    <div class="table-container">
                                        <table class="data-table">
                                            <thead>
                                                <tr>
                                                    <th>Nombre del Rol</th>
                                                    <th>Usuarios Asignados</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="role" items="${roles}">
                                                    <tr>
                                                        <td>
                                                            <span
                                                                class="badge ${role.name == 'ROLE_ADMIN' ? 'badge-danger' : 'badge-info'}">
                                                                ${role.name}
                                                            </span>
                                                        </td>
                                                        <td>${role.count}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <!-- Create Role Form -->
                                <div class="content-card">
                                    <div class="card-title">Nuevo Rol</div>
                                    <form method="POST" action="${pageContext.request.contextPath}/admin/roles/add">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                        <div class="form-group">
                                            <label class="form-label">Nombre del Rol</label>
                                            <input type="text" name="roleName" class="form-control" required
                                                placeholder="Ej. ROLE_EDITOR">
                                            <small
                                                style="color: var(--text-muted); display: block; margin-top: 0.5rem;">Debe
                                                comenzar con 'ROLE_'</small>
                                        </div>

                                        <button type="submit" class="btn btn-primary" style="width: 100%;">
                                            <i class="fas fa-plus"></i> Crear Rol
                                        </button>
                                    </form>

                                    <c:if test="${not empty message}">
                                        <div
                                            style="margin-top: 1rem; padding: 0.75rem; background: #eff6ff; color: #1e40af; border-radius: 0.5rem; font-size: 0.9rem;">
                                            ${message}
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </main>
                </div>
            </body>

            </html>