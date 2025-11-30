<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="es">

            <c:set var="pageTitle" value="Actualizar Perfil - BookStore" scope="request" />
            <%@ include file="layouts/client-head.jsp" %>

                <body>

                    <%@ include file="layouts/client-nav.jsp" %>

                        <div class="container" style="max-width: 800px; margin: 3rem auto; padding: 0 1.5rem;">

                            <div class="section-header" style="text-align: left; margin-bottom: 2rem;">
                                <h1 class="section-title">Actualizar Perfil</h1>
                                <p class="section-subtitle">Modifica tu información personal.</p>
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

                                <form:form method="POST" modelAttribute="customerData"
                                    action="${pageContext.request.contextPath}/customers/profile/update/process">

                                    <form:hidden path="role" value="ROLE_CUSTOMER" />
                                    <form:hidden path="username" />
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div
                                        style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem;">
                                        <div class="form-group">
                                            <label class="form-label"
                                                style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Nombre</label>
                                            <form:input path="firstName" class="form-control"
                                                style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: var(--radius-md);"
                                                placeholder="Ingresa tu nombre" />
                                        </div>
                                        <div class="form-group">
                                            <label class="form-label"
                                                style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Apellido</label>
                                            <form:input path="lastName" class="form-control"
                                                style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: var(--radius-md);"
                                                placeholder="Ingresa tu apellido" />
                                        </div>
                                    </div>

                                    <div class="form-group" style="margin-bottom: 1.5rem;">
                                        <label class="form-label"
                                            style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Usuario</label>
                                        <input type="text" class="form-control" value="${customerData.username}"
                                            disabled
                                            style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: var(--radius-md); background: var(--light); color: var(--text-muted);" />
                                    </div>

                                    <div class="form-group" style="margin-bottom: 1.5rem;">
                                        <label class="form-label"
                                            style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Correo
                                            Electrónico</label>
                                        <form:input path="email" class="form-control"
                                            style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: var(--radius-md);"
                                            placeholder="correo@ejemplo.com" />
                                    </div>

                                    <div class="form-group" style="margin-bottom: 1.5rem;">
                                        <label class="form-label"
                                            style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Teléfono</label>
                                        <form:input path="mobile" class="form-control"
                                            style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: var(--radius-md);"
                                            placeholder="3001234567" />
                                    </div>

                                    <div class="form-group" style="margin-bottom: 1.5rem;">
                                        <label class="form-label"
                                            style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Dirección</label>
                                        <form:textarea path="address" class="form-control"
                                            style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: var(--radius-md); min-height: 100px;"
                                            placeholder="Ingresa tu dirección completa" />
                                    </div>

                                    <div
                                        style="background: var(--light); padding: 1.5rem; border-radius: var(--radius-md); margin-bottom: 2rem;">
                                        <div
                                            style="display: flex; gap: 0.5rem; margin-bottom: 1rem; color: var(--text-muted); font-size: 0.9rem;">
                                            <i class="fas fa-info-circle" style="margin-top: 0.2rem;"></i>
                                            <p style="margin: 0;"><strong>Nota de seguridad:</strong> Debes ingresar tu
                                                contraseña actual para
                                                confirmar los cambios.</p>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label"
                                                style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Confirmar
                                                Contraseña</label>
                                            <form:password path="password" class="form-control"
                                                style="width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: var(--radius-md);"
                                                placeholder="Ingresa tu contraseña actual" required="required" />
                                        </div>
                                    </div>

                                    <div style="display: flex; gap: 1rem; justify-content: flex-end;">
                                        <a href="${pageContext.request.contextPath}/customers/profile"
                                            class="btn-secondary"
                                            style="text-decoration: none; padding: 0.75rem 1.5rem; border-radius: var(--radius-md); background: var(--light); color: var(--text-main); font-weight: 600;">
                                            Cancelar
                                        </a>
                                        <button type="submit" class="btn-primary"
                                            style="width: auto; padding: 0.75rem 2rem; border: none; border-radius: var(--radius-md); background: var(--primary); color: white; font-weight: 600; cursor: pointer;"
                                            onclick="return confirm('¿Deseas actualizar tu perfil?');">
                                            Guardar Cambios
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