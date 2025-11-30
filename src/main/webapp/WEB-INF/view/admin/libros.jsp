<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <c:set var="pageTitle" value="Catálogo de Libros" scope="request" />
                <%@ include file="layouts/head-redesign.jsp" %>
                    <fmt:setLocale value="es_CO" />

                    <body>
                        <div class="app-container">
                            <%@ include file="sidebar.jsp" %>

                                <main class="app-main">
                                    <!-- Top Bar -->
                                    <div class="top-bar">
                                        <div class="page-title">
                                            <h1>Catálogo de Libros</h1>
                                            <p>Administra el inventario, precios y detalles de los libros.</p>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/admin/libros/add"
                                            class="action-btn">
                                            <i class="fas fa-plus"></i> Nuevo Libro
                                        </a>
                                    </div>

                                    <!-- Alerts -->
                                    <c:if test="${not empty message}">
                                        <div
                                            style="background: ${messageType eq 'success' ? '#dcfce7' : '#fee2e2'}; color: ${messageType eq 'success' ? '#166534' : '#991b1b'}; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.75rem; border: 1px solid ${messageType eq 'success' ? '#bbf7d0' : '#fecaca'};">
                                            <i
                                                class="fas ${messageType eq 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
                                            <div>
                                                <strong style="display: block;">${messageType eq 'success' ? '¡Operación
                                                    Exitosa!' : '¡Error!'}</strong>
                                                <span style="font-size: 0.9rem;">${message}</span>
                                            </div>
                                        </div>
                                    </c:if>

                                    <!-- Stats Row -->
                                    <div class="dashboard-grid" style="grid-template-columns: repeat(3, 1fr);">
                                        <div class="stat-card">
                                            <div class="stat-header">
                                                <div class="stat-icon books">
                                                    <i class="fas fa-book"></i>
                                                </div>
                                            </div>
                                            <div class="stat-value">${totalLibros != null ? totalLibros : '0'}</div>
                                            <div class="stat-label">Libros en Catálogo</div>
                                        </div>
                                        <div class="stat-card">
                                            <div class="stat-header">
                                                <div class="stat-icon sales">
                                                    <i class="fas fa-check"></i>
                                                </div>
                                            </div>
                                            <div class="stat-value">${librosDisponibles != null ? librosDisponibles :
                                                '0'}</div>
                                            <div class="stat-label">Disponibles para venta</div>
                                        </div>
                                        <div class="stat-card">
                                            <div class="stat-header">
                                                <div class="stat-icon revenue">
                                                    <i class="fas fa-exclamation-triangle"></i>
                                                </div>
                                            </div>
                                            <div class="stat-value">${(totalLibros - librosDisponibles) > 0 ?
                                                (totalLibros - librosDisponibles) : 0}</div>
                                            <div class="stat-label">Agotados / Sin Stock</div>
                                        </div>
                                    </div>

                                    <!-- Main Content -->
                                    <div class="content-card">
                                        <div class="card-title">
                                            <span>Inventario</span>
                                            <div style="display: flex; gap: 0.5rem;">
                                                <a href="?stock=all"
                                                    class="btn btn-sm ${stockFilter == 'all' || stockFilter == null ? 'btn-primary' : 'btn-secondary'}">Todos</a>
                                                <a href="?stock=available"
                                                    class="btn btn-sm ${stockFilter == 'available' ? 'btn-primary' : 'btn-secondary'}">Disponibles</a>
                                                <a href="?stock=out"
                                                    class="btn btn-sm ${stockFilter == 'out' ? 'btn-primary' : 'btn-secondary'}">Agotados</a>
                                            </div>
                                        </div>

                                        <c:choose>
                                            <c:when test="${empty books}">
                                                <div style="text-align: center; padding: 3rem;">
                                                    <div
                                                        style="font-size: 3rem; color: var(--text-light); margin-bottom: 1rem;">
                                                        <i class="fas fa-box-open"></i>
                                                    </div>
                                                    <h3
                                                        style="font-size: 1.25rem; font-weight: 600; margin-bottom: 0.5rem;">
                                                        No hay libros encontrados</h3>
                                                    <p style="color: var(--text-muted);">Intenta ajustar los filtros o
                                                        agrega un nuevo libro.</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="table-container">
                                                    <table class="data-table">
                                                        <thead>
                                                            <tr>
                                                                <th>ID</th>
                                                                <th>Libro</th>
                                                                <th>Precio</th>
                                                                <th>Stock</th>
                                                                <th>Categoría</th>
                                                                <th>Acciones</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="book" items="${books}">
                                                                <tr>
                                                                    <td><span
                                                                            style="font-family: monospace; color: var(--text-muted);">#${book.id}</span>
                                                                    </td>
                                                                    <td>
                                                                        <div
                                                                            style="font-weight: 600; color: var(--text-main);">
                                                                            ${book.name}</div>
                                                                        <div
                                                                            style="font-size: 0.8rem; color: var(--text-muted); max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                                            ${book.bookDetail.detail}
                                                                        </div>
                                                                    </td>
                                                                    <td style="font-weight: 600;">
                                                                        <fmt:formatNumber value="${book.price}"
                                                                            type="currency" currencySymbol="$" />
                                                                    </td>
                                                                    <td>
                                                                        <span
                                                                            class="badge ${book.quantity > 5 ? 'badge-success' : (book.quantity > 0 ? 'badge-warning' : 'badge-danger')}">
                                                                            ${book.quantity > 0 ? book.quantity :
                                                                            'Agotado'}
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <span
                                                                            class="badge badge-info">${book.bookDetail.type}</span>
                                                                    </td>
                                                                    <td>
                                                                        <div style="display: flex; gap: 0.5rem;">
                                                                            <a href="libros/edit?id=${book.id}"
                                                                                class="btn btn-sm btn-secondary"
                                                                                title="Editar">
                                                                                <i class="fas fa-edit"></i>
                                                                            </a>
                                                                            <a href="libros/delete?id=${book.id}"
                                                                                class="btn btn-sm btn-danger"
                                                                                title="Eliminar"
                                                                                onclick="return confirm('¿Estás seguro de eliminar este libro? Esta acción no se puede deshacer.')">
                                                                                <i class="fas fa-trash"></i>
                                                                            </a>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <!-- Pagination -->
                                                <c:if test="${pageCount > 1}">
                                                    <div
                                                        style="margin-top: 1.5rem; display: flex; justify-content: center;">
                                                        <ul class="pagination">
                                                            <li class="page-item ${page == 0 ? 'disabled' : ''}">
                                                                <a class="page-link"
                                                                    href="?stock=${stockFilter}&sort=${sort}&order=${order}&page=${page-1}&size=${size}">
                                                                    <i class="fas fa-chevron-left"></i>
                                                                </a>
                                                            </li>
                                                            <c:forEach var="p" begin="0" end="${pageCount-1}">
                                                                <li class="page-item ${p == page ? 'active' : ''}">
                                                                    <a class="page-link"
                                                                        href="?stock=${stockFilter}&sort=${sort}&order=${order}&page=${p}&size=${size}">${p+1}</a>
                                                                </li>
                                                            </c:forEach>
                                                            <li
                                                                class="page-item ${page+1 >= pageCount ? 'disabled' : ''}">
                                                                <a class="page-link"
                                                                    href="?stock=${stockFilter}&sort=${sort}&order=${order}&page=${page+1}&size=${size}">
                                                                    <i class="fas fa-chevron-right"></i>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </main>
                        </div>
                    </body>

                    </html>