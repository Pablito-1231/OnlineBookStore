<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <c:set var="pageTitle" value="Gestión de Usuarios" scope="request" />
        <%@ include file="layouts/head-redesign.jsp" %>

            <body>
                <div class="app-container">
                    <%@ include file="sidebar.jsp" %>

                        <main class="app-main">
                            <!-- Top Bar -->
                            <div class="top-bar">
                                <div class="page-title">
                                    <h1>Gestión de Usuarios</h1>
                                    <p>Control de acceso y roles del sistema.</p>
                                </div>
                            </div>

                            <!-- Alerts -->
                            <c:if test="${not empty message}">
                                <div
                                    style="background: ${messageType eq 'success' ? '#dcfce7' : '#fee2e2'}; color: ${messageType eq 'success' ? '#166534' : '#991b1b'}; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem; border: 1px solid ${messageType eq 'success' ? '#bbf7d0' : '#fecaca'};">
                                    <i
                                        class="fas ${messageType eq 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
                                    <div>
                                        <strong style="display: block;">${messageType eq 'success' ? '¡Operación
                                            Exitosa!' : '¡Error!'}</strong>
                                        <span style="font-size: 0.9rem;">${message}</span>
                                    </div>
                                </div>
                            </c:if>

                            <div class="content-card">
                                <div class="card-title">Usuarios Registrados</div>
                                <div class="table-container">
                                    <table class="data-table">
                                        <thead>
                                            <tr>
                                                <th>Usuario</th>
                                                <th>Información Personal</th>
                                                <th>Roles</th>
                                                <th>Estado</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="u" items="${users}">
                                                <tr>
                                                    <td>
                                                        <div style="display: flex; align-items: center; gap: 0.75rem;">
                                                            <div
                                                                style="width: 32px; height: 32px; background: #eef2ff; color: #4f46e5; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 0.8rem;">
                                                                <i class="fas fa-user"></i>
                                                            </div>
                                                            <span style="font-weight: 600;">${u.username}</span>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty u.customer}">
                                                                <div style="font-weight: 500;">${u.customer.firstName}
                                                                    ${u.customer.lastName}</div>
                                                                <div
                                                                    style="font-size: 0.8rem; color: var(--text-muted);">
                                                                    ${u.customer.email}</div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span
                                                                    style="color: var(--text-light); font-style: italic;">Sin
                                                                    perfil</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:forEach var="auth" items="${u.authorities}">
                                                            <span
                                                                class="badge ${auth.role == 'ROLE_ADMIN' ? 'badge-danger' : 'badge-info'}">
                                                                ${auth.role == 'ROLE_ADMIN' ? 'ADMIN' : 'CLIENTE'}
                                                            </span>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge ${u.enabled ? 'badge-success' : 'badge-warning'}">
                                                            ${u.enabled ? 'Activo' : 'Inactivo'}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div style="display: flex; gap: 0.5rem;">
                                                            <!-- Toggle Status -->
                                                            <a href="${pageContext.request.contextPath}/admin/usuarios/toggle?username=${u.username}"
                                                                class="btn btn-sm ${u.enabled ? 'btn-secondary' : 'btn-primary'}"
                                                                title="${u.enabled ? 'Deshabilitar' : 'Habilitar'}">
                                                                <i class="fas ${u.enabled ? 'fa-ban' : 'fa-check'}"></i>
                                                            </a>

                                                            <!-- Edit -->
                                                            <a href="${pageContext.request.contextPath}/admin/usuarios/edit?username=${u.username}"
                                                                class="btn btn-sm btn-secondary" title="Editar">
                                                                <i class="fas fa-edit"></i>
                                                            </a>

                                                            <!-- Delete -->
                                                            <c:if test="${u.username != 'admin'}">
                                                                <a href="${pageContext.request.contextPath}/admin/usuarios/delete?username=${u.username}"
                                                                    class="btn btn-sm btn-danger" title="Eliminar"
                                                                    onclick="return confirm('¿Estás seguro de eliminar el usuario ${u.username}?')">
                                                                    <i class="fas fa-trash"></i>
                                                                </a>
                                                            </c:if>
                                                            <c:if test="${u.username == 'admin'}">
                                                                <button class="btn btn-sm btn-secondary" disabled
                                                                    style="opacity: 0.5; cursor: not-allowed;">
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
                            </div>
                        </main>
                </div>
            </body>

            </html>