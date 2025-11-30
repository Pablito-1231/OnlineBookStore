<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="es">

            <c:set var="pageTitle" value="Cambiar Contraseña - BookStore" scope="request" />
            <%@ include file="layouts/client-head.jsp" %>

                <body>

                    <%@ include file="layouts/client-nav.jsp" %>

                        <div class="container" style="max-width: 600px; margin: 3rem auto; padding: 0 1.5rem;">

                            <div class="section-header" style="text-align: left; margin-bottom: 2rem;">
                                <h1 class="section-title">Cambiar Contraseña</h1>
                                <p class="section-subtitle">Actualiza tu contraseña para mantener tu cuenta segura.</p>
                            </div>

                            <div
                                style="background: white; border-radius: var(--radius-lg); box-shadow: var(--shadow-md); padding: 2rem;">

                                <c:if test="${message != null}">
                                    <div class="alert ${message.contains('Error') || message.contains('error') ? 'alert-danger' : 'alert-success'}"
                                        style="margin-bottom: 2rem; padding: 1rem; border-radius: var(--radius-md); background: ${message.contains('Error') ? '#fee2e2' : '#dcfce7'}; color: ${message.contains('Error') ? '#991b1b' : '#166534'};">
                                        <i
                                            class="fas ${message.contains('Error') || message.contains('error') ? 'fa-exclamation-circle' : 'fa-check-circle'}"></i>
                                        <c:out value="${message}" />
                                    </div>
                                </c:if>

                                <form:form method="POST"
                                    action="${pageContext.request.contextPath}/customers/password/change"
                                    modelAttribute="changePassword">

                                    <form:hidden path="username" />
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="form-group" style="margin-bottom: 1.5rem;">
                                        <label class="form-label"
                                            style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Contraseña
                                            Actual</label>
                                        <form:password path="oldPassword" class="form-control"
                                            style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: var(--radius-md);"
                                            placeholder="Ingresa tu contraseña actual" required="required" />
                                    </div>

                                    <div class="form-group" style="margin-bottom: 1.5rem;">
                                        <label class="form-label"
                                            style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Nueva
                                            Contraseña</label>
                                        <form:password path="newPassword" class="form-control"
                                            style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: var(--radius-md);"
                                            placeholder="Ingresa tu nueva contraseña" required="required" />
                                    </div>

                                    <div class="form-group" style="margin-bottom: 2rem;">
                                        <label class="form-label"
                                            style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Confirmar
                                            Nueva Contraseña</label>
                                        <form:password path="confirmPassword" class="form-control"
                                            style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: var(--radius-md);"
                                            placeholder="Repite tu nueva contraseña" required="required" />
                                    </div>

                                    <div style="display: flex; gap: 1rem; justify-content: flex-end;">
                                        <a href="${pageContext.request.contextPath}/customers/profile"
                                            class="btn-secondary"
                                            style="text-decoration: none; padding: 0.75rem 1.5rem; border-radius: var(--radius-md); background: var(--light); color: var(--text-main); font-weight: 600;">
                                            Cancelar
                                        </a>
                                        <button type="submit" class="btn-primary"
                                            style="width: auto; padding: 0.75rem 2rem; border: none; border-radius: var(--radius-md); background: var(--primary); color: white; font-weight: 600; cursor: pointer;">
                                            Cambiar Contraseña
                                        </button>
                                    </div>

                                </form:form>
                            </div>

                        </div>

                        <footer class="client-footer">
                            <a href="#" class="footer-brand">BookStore</a>
                            <p>&copy; 2025 BookStore. Todos los derechos reservados.</p>
                        </footer>

                </body>

            </html>