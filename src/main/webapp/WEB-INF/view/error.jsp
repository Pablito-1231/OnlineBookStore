<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Error - BookStore</title>
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
                text-align: center;
            }

            .error-card {
                background: white;
                padding: 4rem 2rem;
                border-radius: var(--radius-xl);
                box-shadow: var(--shadow-lg);
                max-width: 500px;
                width: 100%;
            }

            .error-icon {
                font-size: 4rem;
                color: var(--warning);
                margin-bottom: 1.5rem;
            }

            .error-title {
                font-size: 2rem;
                font-weight: 800;
                margin-bottom: 1rem;
                color: var(--text-main);
            }

            .error-message {
                color: var(--text-muted);
                margin-bottom: 2rem;
                font-size: 1.1rem;
            }

            .btn-home {
                display: inline-block;
                background: var(--primary);
                color: white;
                padding: 0.75rem 2rem;
                border-radius: var(--radius-md);
                text-decoration: none;
                font-weight: 600;
                transition: background 0.2s;
            }

            .btn-home:hover {
                background: var(--primary-hover);
            }
        </style>
    </head>

    <body>
        <div class="error-card">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h1 class="error-title">Algo salió mal</h1>
            <p class="error-message">Ha ocurrido un error inesperado. Por favor, inténtalo de nuevo más tarde.</p>
            <a href="${pageContext.request.contextPath}/" class="btn-home">
                <i class="fas fa-home"></i> Volver al Inicio
            </a>
        </div>
    </body>

    </html>