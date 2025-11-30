<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="es">

            <c:set var="pageTitle" value="Catálogo de Libros - BookStore" scope="request" />
            <%@ include file="layouts/client-head.jsp" %>

                <body>

                    <%@ include file="layouts/client-nav.jsp" %>

                        <div class="container" style="max-width: 1200px; margin: 2rem auto; padding: 0 1.5rem;">

                            <div class="section-header"
                                style="text-align: left; display: flex; justify-content: space-between; align-items: end;">
                                <div>
                                    <h2 class="section-title">Catálogo Completo</h2>
                                    <p class="section-subtitle">Explora nuestra colección de libros.</p>
                                </div>

                                <!-- Search Form -->
                                <form action="${pageContext.request.contextPath}/customers/books/search" method="get"
                                    style="display: flex; gap: 0.5rem;">
                                    <input type="text" name="name" class="form-control" placeholder="Buscar libro..."
                                        style="width: 250px;">
                                    <button type="submit" class="btn-primary" style="width: auto; padding: 0 1.5rem;">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </form>
                            </div>

                            <c:if test="${not empty message}">
                                <div class="alert alert-success" style="margin-bottom: 2rem;">
                                    <i class="fas fa-check-circle"></i> ${message}
                                </div>
                            </c:if>

                            <div class="product-grid">
                                <c:forEach var="book" items="${books}">

                                    <c:url var="addToCartLink" value="/customers/cart/add">
                                        <c:param name="bookId" value="${book.id}" />
                                    </c:url>

                                    <c:url var="removeFromCartLink" value="/customers/cart/remove">
                                        <c:param name="bookId" value="${book.id}" />
                                    </c:url>

                                    <!-- Check if in cart -->
                                    <c:set var="contains" value="false" />
                                    <c:forEach var="item" items="${shoppingItems}">
                                        <c:if test="${item.book.id eq book.id}">
                                            <c:set var="contains" value="true" />
                                        </c:if>
                                    </c:forEach>

                                    <div class="product-card" style="${book.quantity <= 0 ? 'opacity: 0.7;' : ''}">
                                        <div class="product-image">
                                            <i class="fas fa-book"></i>
                                            <c:if test="${contains}">
                                                <span class="product-badge"
                                                    style="background: var(--success); color: white;">En Carrito</span>
                                            </c:if>
                                            <c:if test="${book.quantity <= 0}">
                                                <span class="product-badge"
                                                    style="background: var(--secondary); color: white;">Agotado</span>
                                            </c:if>
                                        </div>

                                        <div class="product-info">
                                            <div class="product-category">${book.bookDetail.type}</div>
                                            <div class="product-title">${book.name}</div>
                                            <div class="product-author">ID: ${book.id}</div>
                                            <div
                                                style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 0.5rem;">
                                                ${book.quantity} disponibles
                                            </div>

                                            <div class="product-footer">
                                                <div class="product-price">$
                                                    <fmt:formatNumber value="${book.price}" type="number"
                                                        groupingUsed="true" minFractionDigits="0" />
                                                </div>

                                                <c:choose>
                                                    <c:when test="${book.quantity > 0 && !contains}">
                                                        <a href="${addToCartLink}" style="text-decoration: none;">
                                                            <button class="btn-add-cart" title="Agregar al Carrito">
                                                                <i class="fas fa-plus"></i>
                                                            </button>
                                                        </a>
                                                    </c:when>
                                                    <c:when test="${contains}">
                                                        <a href="${removeFromCartLink}" style="text-decoration: none;">
                                                            <button class="btn-add-cart"
                                                                style="background: var(--danger); color: white;"
                                                                title="Quitar del Carrito">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn-add-cart" disabled
                                                            style="opacity: 0.5; cursor: not-allowed;">
                                                            <i class="fas fa-ban"></i>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <c:if test="${empty books}">
                                <div style="text-align: center; padding: 4rem; color: var(--text-muted);">
                                    <i class="fas fa-search"
                                        style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                                    <h3>No se encontraron libros</h3>
                                    <p>Intenta con otra búsqueda o vuelve más tarde.</p>
                                </div>
                            </c:if>

                        </div>

                        <footer class="client-footer">
                            <a href="#" class="footer-brand">BookStore</a>
                            <p>&copy; 2025 BookStore. Todos los derechos reservados.</p>
                        </footer>

                </body>

            </html>