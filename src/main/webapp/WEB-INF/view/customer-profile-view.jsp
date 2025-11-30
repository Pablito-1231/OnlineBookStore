<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="es">

        <c:set var="pageTitle" value="Mi Perfil - BookStore" scope="request" />
        <%@ include file="layouts/client-head.jsp" %>

            <body>

                <%@ include file="layouts/client-nav.jsp" %>

                    <div class="container" style="max-width: 800px; margin: 3rem auto; padding: 0 1.5rem;">

                        <div class="section-header" style="text-align: left; margin-bottom: 2rem;">
                            <h1 class="section-title">Mi Perfil</h1>
                            <p class="section-subtitle">Gestiona tu información personal.</p>
                        </div>

                        <div
                            style="background: white; border-radius: var(--radius-lg); box-shadow: var(--shadow-md); overflow: hidden;">
                            <div
                                style="background: var(--light); padding: 2rem; text-align: center; border-bottom: 1px solid var(--border-color);">
                                <div
                                    style="width: 100px; height: 100px; background: var(--primary); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 3rem; margin: 0 auto 1rem; font-weight: 700;">
                                    ${customerData.firstName.charAt(0)}
                                </div>
                                <h2 style="margin: 0; font-size: 1.5rem;">${customerData.firstName}
                                    ${customerData.lastName}</h2>
                                <p style="color: var(--text-muted); margin: 0.5rem 0 0;">${customerData.email}</p>
                            </div>

                            <div style="padding: 2rem;">
                                <div
                                    style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem;">

                                    <div>
                                        <div
                                            style="font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; font-weight: 700; margin-bottom: 0.5rem;">
                                            Usuario</div>
                                        <div style="font-size: 1.1rem; font-weight: 500;">${customerData.username}</div>
                                    </div>

                                    <div>
                                        <div
                                            style="font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; font-weight: 700; margin-bottom: 0.5rem;">
                                            Teléfono</div>
                                        <div style="font-size: 1.1rem; font-weight: 500;">${customerData.mobile}</div>
                                    </div>

                                    <div style="grid-column: 1 / -1;">
                                        <div
                                            style="font-size: 0.85rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; font-weight: 700; margin-bottom: 0.5rem;">
                                            Dirección</div>
                                        <div style="font-size: 1.1rem; font-weight: 500;">${customerData.address}</div>
                                    </div>

                                </div>

                                <div style="margin-top: 3rem; display: flex; gap: 1rem; flex-wrap: wrap;">
                                    <a href="${pageContext.request.contextPath}/customers/profile/update"
                                        class="btn-primary"
                                        style="text-decoration: none; display: inline-block; width: auto; padding: 0.75rem 1.5rem; text-align: center;">
                                        <i class="fas fa-edit"></i> Editar Perfil
                                    </a>

                                    <a href="${pageContext.request.contextPath}/customers/password" class="btn-primary"
                                        style="text-decoration: none; display: inline-block; width: auto; padding: 0.75rem 1.5rem; background: var(--secondary); text-align: center;">
                                        <i class="fas fa-key"></i> Cambiar Contraseña
                                    </a>
                                </div>
                            </div>
                        </div>

                    </div>

                    <footer class="client-footer">
                        <a href="#" class="footer-brand">BookStore</a>
                        <p>&copy; 2025 BookStore. Todos los derechos reservados.</p>
                    </footer>

            </body>

        </html>