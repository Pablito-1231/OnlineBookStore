<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <nav class="client-navbar">
            <div class="navbar-container">
                <a href="${pageContext.request.contextPath}/customers" class="nav-brand">
                    <i class="fas fa-book-open"></i> BookStore
                </a>

                <div class="nav-links">
                    <a href="${pageContext.request.contextPath}/customers" class="nav-link">Inicio</a>
                    <a href="${pageContext.request.contextPath}/books" class="nav-link">Libros</a>
                    <a href="${pageContext.request.contextPath}/customers/books" class="nav-link">Mis Compras</a>

                    <a href="${pageContext.request.contextPath}/customers/cart" class="nav-btn"
                        style="background: var(--light); color: var(--text-main); padding: 0.5rem 1rem;">
                        <i class="fas fa-shopping-cart"></i> Carrito
                    </a>

                    <div style="position: relative; margin-left: 1rem;">
                        <a href="${pageContext.request.contextPath}/customers/profile" class="nav-link"
                            style="display: flex; align-items: center; gap: 0.5rem;">
                            <div
                                style="width: 32px; height: 32px; background: var(--primary); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 0.9rem;">
                                <c:choose>
                                    <c:when test="${not empty customers.firstName}">
                                        ${customers.firstName.charAt(0)}
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </a>
                    </div>

                    <a href="${pageContext.request.contextPath}/logout" class="nav-link" style="color: var(--danger);"
                        title="Cerrar Sesión">
                        <i class="fas fa-sign-out-alt"></i>
                    </a>
                </div>
            </div>
        </nav>