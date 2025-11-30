<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="es">

            <c:set var="pageTitle" value="Mi Carrito - BookStore" scope="request" />
            <%@ include file="layouts/client-head.jsp" %>

                <body>

                    <%@ include file="layouts/client-nav.jsp" %>

                        <div class="cart-container">

                            <div class="cart-header">
                                <h1 class="section-title" style="text-align: left;">Mi Carrito</h1>
                                <p class="section-subtitle" style="text-align: left;">Gestiona los libros que deseas
                                    comprar.</p>
                            </div>

                            <c:if test="${not empty message}">
                                <div class="alert alert-success" style="margin-bottom: 2rem;">
                                    <i class="fas fa-check-circle"></i> ${message}
                                </div>
                            </c:if>

                            <!-- Calculate Totals -->
                            <c:set var="totalPrice" value="0" scope="page" />
                            <c:set var="totalQuantity" value="0" scope="page" />
                            <c:if test="${not empty shoppingItems}">
                                <c:forEach var="shoppingCart" items="${shoppingItems}">
                                    <c:set var="totalPrice"
                                        value="${totalPrice + (shoppingCart.quantity * shoppingCart.book.price)}"
                                        scope="page" />
                                    <c:set var="totalQuantity" value="${totalQuantity + shoppingCart.quantity}"
                                        scope="page" />
                                </c:forEach>
                            </c:if>

                            <c:choose>
                                <c:when test="${empty shoppingItems or totalQuantity eq 0}">
                                    <div
                                        style="text-align: center; padding: 4rem; background: white; border-radius: var(--radius-lg); box-shadow: var(--shadow-sm);">
                                        <div style="font-size: 4rem; color: var(--text-muted); margin-bottom: 1rem;">
                                            <i class="fas fa-shopping-cart"></i>
                                        </div>
                                        <h2 style="margin-bottom: 1rem;">Tu carrito está vacío</h2>
                                        <p style="color: var(--text-muted); margin-bottom: 2rem;">Parece que aún no has
                                            agregado ningún
                                            libro.</p>
                                        <a href="${pageContext.request.contextPath}/books" class="btn-checkout"
                                            style="display: inline-block; width: auto; padding: 1rem 2rem;">
                                            Explorar Catálogo
                                        </a>
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <div style="display: grid; grid-template-columns: 1fr 350px; gap: 2rem;">

                                        <!-- Cart Items -->
                                        <div>
                                            <c:forEach var="shoppingCart" items="${shoppingItems}">
                                                <c:url var="removeFromCartLink" value="/customers/cart/remove">
                                                    <c:param name="bookId" value="${shoppingCart.book.id}" />
                                                </c:url>

                                                <div class="cart-item-card">
                                                    <div class="cart-item-thumbnail">
                                                        <i class="fas fa-book"></i>
                                                    </div>

                                                    <div class="cart-item-info">
                                                        <div class="cart-item-title">${shoppingCart.book.name}</div>
                                                        <div class="cart-item-meta">
                                                            ${shoppingCart.book.bookDetail.type} • $
                                                            <fmt:formatNumber value="${shoppingCart.book.price}"
                                                                type="number" groupingUsed="true"
                                                                minFractionDigits="0" />
                                                        </div>
                                                    </div>

                                                    <div class="cart-item-actions">
                                                        <div class="quantity-controls">
                                                            <form method="post"
                                                                action="${pageContext.request.contextPath}/customers/cart/decrease"
                                                                style="display:inline; margin:0;">
                                                                <input type="hidden" name="bookId"
                                                                    value="${shoppingCart.book.id}" />
                                                                <input type="hidden" name="count" value="1" />
                                                                <input type="hidden" name="${_csrf.parameterName}"
                                                                    value="${_csrf.token}" />
                                                                <button type="submit" class="quantity-btn">
                                                                    <i class="fas fa-minus"></i>
                                                                </button>
                                                            </form>

                                                            <span
                                                                class="quantity-display">${shoppingCart.quantity}</span>

                                                            <form method="post"
                                                                action="${pageContext.request.contextPath}/customers/cart/increase"
                                                                style="display:inline; margin:0;">
                                                                <input type="hidden" name="bookId"
                                                                    value="${shoppingCart.book.id}" />
                                                                <input type="hidden" name="count" value="1" />
                                                                <input type="hidden" name="${_csrf.parameterName}"
                                                                    value="${_csrf.token}" />
                                                                <button type="submit" class="quantity-btn">
                                                                    <i class="fas fa-plus"></i>
                                                                </button>
                                                            </form>
                                                        </div>

                                                        <a href="${removeFromCartLink}">
                                                            <button class="btn-remove-item">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </a>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>

                                        <!-- Summary -->
                                        <div>
                                            <div class="cart-summary" style="margin-top: 0;">
                                                <h3 style="margin-bottom: 1.5rem; font-weight: 700;">Resumen</h3>

                                                <div class="cart-summary-row">
                                                    <span>Subtotal (${totalQuantity} items)</span>
                                                    <span>$
                                                        <fmt:formatNumber value="${totalPrice}" type="number"
                                                            groupingUsed="true" minFractionDigits="0" />
                                                    </span>
                                                </div>

                                                <div class="cart-summary-row total">
                                                    <span>Total</span>
                                                    <span>$
                                                        <fmt:formatNumber value="${totalPrice}" type="number"
                                                            groupingUsed="true" minFractionDigits="0" />
                                                    </span>
                                                </div>

                                                <a href="${pageContext.request.contextPath}/customers/cart/pay"
                                                    class="btn-checkout">
                                                    Proceder al Pago
                                                </a>

                                                <a href="${pageContext.request.contextPath}/books"
                                                    style="display: block; text-align: center; margin-top: 1rem; color: var(--text-muted); text-decoration: none; font-size: 0.9rem;">
                                                    Seguir Comprando
                                                </a>
                                            </div>
                                        </div>

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