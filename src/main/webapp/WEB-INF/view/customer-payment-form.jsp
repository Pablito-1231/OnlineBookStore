<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="es">

            <c:set var="pageTitle" value="Procesar Pago - BookStore" scope="request" />
            <%@ include file="layouts/client-head.jsp" %>

                <body>

                    <%@ include file="layouts/client-nav.jsp" %>

                        <div class="container" style="max-width: 600px; margin: 3rem auto; padding: 0 1.5rem;">

                            <div class="section-header" style="text-align: left; margin-bottom: 2rem;">
                                <h1 class="section-title">Procesar Pago</h1>
                                <p class="section-subtitle">Completa la información para finalizar tu compra.</p>
                            </div>

                            <div
                                style="background: white; border-radius: var(--radius-lg); box-shadow: var(--shadow-md); padding: 2rem;">

                                <div style="text-align: center; margin-bottom: 2rem;">
                                    <div style="font-size: 3rem; color: var(--primary); margin-bottom: 1rem;">
                                        <i class="fas fa-lock"></i>
                                    </div>
                                    <h2 style="font-size: 1.5rem; font-weight: 700;">Pago Seguro</h2>
                                    <p style="color: var(--text-muted);">Tus datos están protegidos.</p>
                                </div>

                                <div class="alert alert-info" style="margin-bottom: 2rem; font-size: 0.9rem;">
                                    <i class="fas fa-info-circle"></i> <strong>Sistema de Pago Simulado:</strong> Este
                                    es un entorno de
                                    prueba. Ingresa cualquier ID y código OTP para simular el proceso de pago.
                                </div>

                                <c:if test="${message != null}">
                                    <div class="alert alert-danger" style="margin-bottom: 2rem;">
                                        <i class="fas fa-exclamation-circle"></i>
                                        <c:out value="${message}" />
                                    </div>
                                </c:if>

                                <form:form action="${pageContext.request.contextPath}/customers/payment/success"
                                    method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="form-group" style="margin-bottom: 1.5rem;">
                                        <label class="form-label"
                                            style="display: block; margin-bottom: 0.5rem; font-weight: 500;">ID de
                                            Pago</label>
                                        <div style="position: relative;">
                                            <i class="fas fa-id-card"
                                                style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                                            <input type="text" name="upi" class="form-control"
                                                style="width: 100%; padding: 0.75rem 1rem 0.75rem 2.5rem; border: 1px solid var(--border-color); border-radius: var(--radius-md);"
                                                placeholder="Ej: usuario123" required maxlength="50" />
                                        </div>
                                    </div>

                                    <div class="form-group" style="margin-bottom: 2rem;">
                                        <label class="form-label"
                                            style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Código
                                            OTP</label>
                                        <div style="position: relative;">
                                            <i class="fas fa-key"
                                                style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                                            <input type="number" name="otp" class="form-control"
                                                style="width: 100%; padding: 0.75rem 1rem 0.75rem 2.5rem; border: 1px solid var(--border-color); border-radius: var(--radius-md);"
                                                placeholder="Código de 6 dígitos" required minlength="6"
                                                maxlength="6" />
                                        </div>
                                    </div>

                                    <button type="submit" class="btn-primary"
                                        style="width: 100%; padding: 1rem; border: none; border-radius: var(--radius-md); background: var(--primary); color: white; font-weight: 700; cursor: pointer; font-size: 1.1rem;">
                                        <i class="fas fa-lock"></i> Pagar Ahora
                                    </button>

                                    <div
                                        style="display: flex; justify-content: center; gap: 1.5rem; margin-top: 2rem; color: var(--text-muted); font-size: 0.85rem;">
                                        <span><i class="fas fa-shield-alt"></i> Pago Seguro</span>
                                        <span><i class="fas fa-lock"></i> SSL Encriptado</span>
                                        <span><i class="fas fa-check-circle"></i> Verificado</span>
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