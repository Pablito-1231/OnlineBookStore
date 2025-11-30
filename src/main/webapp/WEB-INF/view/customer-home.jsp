<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="es">

        <c:set var="pageTitle" value="Inicio - BookStore" scope="request" />
        <%@ include file="layouts/client-head.jsp" %>

            <body>

                <%@ include file="layouts/client-nav.jsp" %>

                    <!-- Hero Section -->
                    <div class="hero-section">
                        <div class="hero-content">
                            <h1 class="hero-title">Bienvenido, ${customers.firstName}</h1>
                            <p class="hero-subtitle">Descubre tu próxima lectura favorita en nuestra colección curada.
                            </p>
                            <a href="${pageContext.request.contextPath}/books" class="hero-btn">
                                Explorar Catálogo
                            </a>
                        </div>
                    </div>

                    <!-- Stats Section (Simplified) -->
                    <div class="container"
                        style="max-width: 1200px; margin: 0 auto; padding: 0 1.5rem; margin-bottom: 4rem;">
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 2rem;">
                            <div
                                style="background: white; padding: 1.5rem; border-radius: var(--radius-lg); box-shadow: var(--shadow-sm); text-align: center;">
                                <div style="font-size: 2rem; color: var(--primary); margin-bottom: 0.5rem;">
                                    <i class="fas fa-shopping-cart"></i>
                                </div>
                                <div style="font-size: 1.5rem; font-weight: 700;">${cartCount != null ? cartCount : 0}
                                </div>
                                <div style="color: var(--text-muted);">Items en Carrito</div>
                            </div>

                            <div
                                style="background: white; padding: 1.5rem; border-radius: var(--radius-lg); box-shadow: var(--shadow-sm); text-align: center;">
                                <div style="font-size: 2rem; color: var(--success); margin-bottom: 0.5rem;">
                                    <i class="fas fa-book-reader"></i>
                                </div>
                                <div style="font-size: 1.5rem; font-weight: 700;">${purchasedCount != null ?
                                    purchasedCount : 0}</div>
                                <div style="color: var(--text-muted);">Libros Comprados</div>
                            </div>

                            <div
                                style="background: white; padding: 1.5rem; border-radius: var(--radius-lg); box-shadow: var(--shadow-sm); text-align: center;">
                                <div style="font-size: 2rem; color: var(--warning); margin-bottom: 0.5rem;">
                                    <i class="fas fa-star"></i>
                                </div>
                                <div style="font-size: 1.5rem; font-weight: 700;">Premium</div>
                                <div style="color: var(--text-muted);">Membresía</div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Activity / Featured -->
                    <div class="section-header">
                        <h2 class="section-title">Novedades</h2>
                        <p class="section-subtitle">Explora las últimas adiciones a nuestra biblioteca.</p>
                    </div>

                    <div class="product-grid">
                        <!-- Placeholder for featured books - In a real app, this would be dynamic -->
                        <div class="product-card">
                            <div class="product-image">
                                <i class="fas fa-book"></i>
                                <span class="product-badge">Nuevo</span>
                            </div>
                            <div class="product-info">
                                <div class="product-category">Ficción</div>
                                <div class="product-title">El Señor de los Anillos</div>
                                <div class="product-author">J.R.R. Tolkien</div>
                                <div class="product-footer">
                                    <div class="product-price">$45.000</div>
                                    <button class="btn-add-cart"><i class="fas fa-plus"></i></button>
                                </div>
                            </div>
                        </div>

                        <div class="product-card">
                            <div class="product-image">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="product-info">
                                <div class="product-category">Ciencia Ficción</div>
                                <div class="product-title">Dune</div>
                                <div class="product-author">Frank Herbert</div>
                                <div class="product-footer">
                                    <div class="product-price">$55.000</div>
                                    <button class="btn-add-cart"><i class="fas fa-plus"></i></button>
                                </div>
                            </div>
                        </div>

                        <div class="product-card">
                            <div class="product-image">
                                <i class="fas fa-book"></i>
                                <span class="product-badge"
                                    style="background: var(--danger); color: white;">Oferta</span>
                            </div>
                            <div class="product-info">
                                <div class="product-category">Clásicos</div>
                                <div class="product-title">1984</div>
                                <div class="product-author">George Orwell</div>
                                <div class="product-footer">
                                    <div class="product-price">$35.000</div>
                                    <button class="btn-add-cart"><i class="fas fa-plus"></i></button>
                                </div>
                            </div>
                        </div>

                        <div class="product-card">
                            <div class="product-image">
                                <i class="fas fa-book"></i>
                            </div>
                            <div class="product-info">
                                <div class="product-category">Fantasía</div>
                                <div class="product-title">Harry Potter</div>
                                <div class="product-author">J.K. Rowling</div>
                                <div class="product-footer">
                                    <div class="product-price">$48.000</div>
                                    <button class="btn-add-cart"><i class="fas fa-plus"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <footer class="client-footer">
                        <a href="#" class="footer-brand">BookStore</a>
                        <div class="footer-links">
                            <a href="#">Sobre Nosotros</a>
                            <a href="#">Contacto</a>
                            <a href="#">Términos y Condiciones</a>
                            <a href="#">Privacidad</a>
                        </div>
                        <p>&copy; 2025 BookStore. Todos los derechos reservados.</p>
                    </footer>

            </body>

        </html>