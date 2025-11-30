<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:set var="pageTitle" value="Cambiar Contraseña" scope="request" />
        <%@ include file="layouts/head-redesign.jsp" %>

            <body>
                <div class="app-container">
                    <%@ include file="sidebar.jsp" %>

                        <main class="app-main">
                            <div class="top-bar">
                                <div class="page-title">
                                    <h1>Seguridad</h1>
                                    <p>Actualiza tu contraseña de acceso.</p>
                                </div>
                            </div>

                            <div class="content-card" style="max-width: 500px; margin: 2rem auto;">
                                <div class="card-title" style="text-align: center; margin-bottom: 2rem;">Cambiar
                                    Contraseña</div>

                                <c:if test="${not empty message}">
                                    <div
                                        style="background: ${messageType eq 'success' ? '#dcfce7' : '#fee2e2'}; color: ${messageType eq 'success' ? '#166534' : '#991b1b'}; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem; font-size: 0.9rem; text-align: center;">
                                        ${message}
                                    </div>
                                </c:if>

                                <form method="post"
                                    action="${pageContext.request.contextPath}/admin/change-password/process">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="form-group">
                                        <label class="form-label">Contraseña Actual</label>
                                        <input type="password" name="oldPassword" class="form-control" required
                                            autofocus placeholder="••••••••">
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Nueva Contraseña</label>
                                        <input type="password" name="newPassword" class="form-control" required
                                            placeholder="••••••••">
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Confirmar Nueva Contraseña</label>
                                        <input type="password" name="confirmPassword" class="form-control" required
                                            placeholder="••••••••">
                                    </div>

                                    <button type="submit" class="btn btn-primary"
                                        style="width: 100%; margin-top: 1rem;">
                                        Actualizar Contraseña
                                    </button>
                                </form>
                            </div>
                        </main>
                </div>
            </body>

            </html>