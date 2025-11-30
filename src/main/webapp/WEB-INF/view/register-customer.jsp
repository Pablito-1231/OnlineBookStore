<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html lang="es">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Registro - BookStore</title>
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/client-theme.css">
                <style>
                    body {
                        background: #f3f4f6;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        min-height: 100vh;
                        padding: 1rem;
                    }

                    .login-card {
                        background: white;
                        border-radius: var(--radius-xl);
                        box-shadow: var(--shadow-lg);
                        overflow: hidden;
                        display: flex;
                        max-width: 1000px;
                        width: 100%;
                        min-height: 700px;
                        /* Taller for registration */
                    }

                    .login-visual {
                        flex: 1;
                        background: linear-gradient(135deg, var(--primary) 0%, #4338ca 100%);
                        padding: 3rem;
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                        color: white;
                        position: relative;
                    }

                    .login-visual::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background: url('https://www.transparenttextures.com/patterns/cubes.png');
                        opacity: 0.1;
                    }

                    .login-form-container {
                        flex: 1;
                        padding: 3rem;
                        display: flex;
                        flex-direction: column;
                        justify-content: center;
                        overflow-y: auto;
                    }

                    .brand-logo {
                        font-size: 2rem;
                        font-weight: 800;
                        margin-bottom: 1rem;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .form-group {
                        margin-bottom: 1rem;
                    }

                    .form-label {
                        display: block;
                        margin-bottom: 0.25rem;
                        font-weight: 500;
                        color: var(--text-main);
                        font-size: 0.9rem;
                    }

                    .form-control {
                        width: 100%;
                        padding: 0.6rem 1rem;
                        border: 1px solid var(--border-color);
                        border-radius: var(--radius-md);
                        font-family: inherit;
                        transition: all 0.2s;
                    }

                    .form-control:focus {
                        outline: none;
                        border-color: var(--primary);
                        box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
                    }

                    .btn-primary {
                        width: 100%;
                        padding: 0.75rem;
                        background: var(--primary);
                        color: white;
                        border: none;
                        border-radius: var(--radius-md);
                        font-weight: 600;
                        cursor: pointer;
                        transition: background 0.2s;
                        margin-top: 1rem;
                    }

                    .btn-primary:hover {
                        background: var(--primary-hover);
                    }

                    .alert {
                        padding: 1rem;
                        border-radius: var(--radius-md);
                        margin-bottom: 1.5rem;
                        font-size: 0.9rem;
                    }

                    .alert-success {
                        background: #dcfce7;
                        color: #166534;
                    }

                    .row {
                        display: flex;
                        gap: 1rem;
                    }

                    .col {
                        flex: 1;
                    }

                    @media (max-width: 768px) {
                        .login-visual {
                            display: none;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="login-card">
                    <div class="login-visual">
                        <div class="brand-logo">
                            <i class="fas fa-book-open"></i> BookStore
                        </div>
                        <h2 style="font-size: 2.5rem; margin-bottom: 1rem; line-height: 1.1;">Únete a nuestra comunidad.
                        </h2>
                        <p style="font-size: 1.1rem; opacity: 0.9;">Descubre miles de libros, accede a ofertas
                            exclusivas y vive
                            nuevas aventuras literarias.</p>
                    </div>

                    <div class="login-form-container">
                        <div style="margin-bottom: 2rem;">
                            <h1
                                style="font-size: 1.75rem; font-weight: 700; color: var(--text-main); margin-bottom: 0.5rem;">
                                Crear
                                Cuenta</h1>
                            <p style="color: var(--text-muted);">Completa tus datos para registrarte</p>
                        </div>

                        <c:if test="${message != null}">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle"></i>
                                <c:out value="${message}" />
                            </div>
                        </c:if>

                        <form:form action="${pageContext.request.contextPath}/register/customer" method="POST"
                            modelAttribute="customerData">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <div class="row">
                                <div class="col form-group">
                                    <label class="form-label">Nombre</label>
                                    <form:input path="firstName" class="form-control" placeholder="Tu nombre"
                                        required="required" />
                                </div>
                                <div class="col form-group">
                                    <label class="form-label">Apellido</label>
                                    <form:input path="lastName" class="form-control" placeholder="Tu apellido"
                                        required="required" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Correo Electrónico</label>
                                <form:input path="email" type="email" class="form-control"
                                    placeholder="correo@ejemplo.com" required="required" />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Teléfono</label>
                                <form:input path="mobile" type="tel" class="form-control" placeholder="Tu número"
                                    required="required" />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Dirección</label>
                                <form:input path="address" class="form-control" placeholder="Tu dirección completa"
                                    required="required" />
                            </div>

                            <div class="form-group">
                                <label class="form-label">Usuario</label>
                                <form:input path="username" class="form-control"
                                    placeholder="Elige un nombre de usuario" required="required" />
                            </div>

                            <div class="row">
                                <div class="col form-group">
                                    <label class="form-label">Contraseña</label>
                                    <form:input path="password" type="password" class="form-control"
                                        placeholder="••••••••" required="required" />
                                </div>
                                <div class="col form-group">
                                    <label class="form-label">Confirmar</label>
                                    <form:input path="confirmPassword" type="password" class="form-control"
                                        placeholder="••••••••" required="required" />
                                </div>
                            </div>

                            <form:hidden path="role" value="ROLE_CUSTOMER" />

                            <button type="submit" class="btn-primary">Registrarse</button>
                        </form:form>

                        <div style="margin-top: 2rem; text-align: center; font-size: 0.9rem; color: var(--text-muted);">
                            ¿Ya tienes una cuenta? <a href="${pageContext.request.contextPath}/login"
                                style="color: var(--primary); font-weight: 600; text-decoration: none;">Iniciar
                                Sesión</a>
                        </div>
                    </div>
                </div>
            </body>

            </html>