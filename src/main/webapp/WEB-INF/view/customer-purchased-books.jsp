<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="es">

            <c:set var="pageTitle" value="Mis Libros - BookStore" scope="request" />
            <%@ include file="layouts/client-head.jsp" %>

                <body>

                    <%@ include file="layouts/client-nav.jsp" %>

                        <div class="container" style="max-width: 1000px; margin: 3rem auto; padding: 0 1.5rem;">

                            <div class="section-header" style="text-align: left; margin-bottom: 2rem;">
                                <h1 class="section-title">Mis Libros</h1>
                                <p class="section-subtitle">Colección de libros que has adquirido.</p>
                            </div>

                            <c:choose>
                                <c:when test="${empty bookList}">
                                    <div
                                        style="text-align: center; padding: 4rem; background: white; border-radius: var(--radius-lg); box-shadow: var(--shadow-sm);">
                                        <div style="font-size: 4rem; color: var(--text-muted); margin-bottom: 1rem;">
                                            <i class="fas fa-book-open"></i>
                                        </div>
                                        <h2 style="margin-bottom: 1rem;">Aún no tienes libros</h2>
                                        <p style="color: var(--text-muted); margin-bottom: 2rem;">Tus libros comprados
                                            aparecerán aquí.</p>
                                        <a href="${pageContext.request.contextPath}/books" class="btn-primary"
                                            style="display: inline-block; width: auto; padding: 1rem 2rem; text-decoration: none;">
                                            Explorar Catálogo
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="product-grid">
                                        <c:forEach var="book" items="${bookList}">
                                            <div class="product-card">
                                                <div class="product-image">
                                                    <i class="fas fa-book"></i>
                                                    <span class="product-badge"
                                                        style="background: var(--success); color: white;">Adquirido</span>
                                                </div>
                                                <div class="product-info">
                                                    <div class="product-category">${book.bookDetail.type}</div>
                                                    <div class="product-title">${book.name}</div>
                                                    <div class="product-author">ID: ${book.id}</div>
                                                    <div class="product-footer">
                                                        <a href="#" class="btn-primary"
                                                            style="width: 100%; text-align: center; text-decoration: none; padding: 0.5rem; font-size: 0.9rem;">
                                                            <i class="fas fa-download"></i> Descargar
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                        </div>

                        <footer class="client-footer">
                            <a href="#" class="footer-brand">BookStore</a>
                            <p>&copy; 2025 BookStore. Todos los derechos reservados.</p>
                        </footer>

                </body>

            </html>