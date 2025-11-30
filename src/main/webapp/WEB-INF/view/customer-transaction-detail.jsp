<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="es">

            <c:set var="pageTitle" value="Detalle de Transacción - BookStore" scope="request" />
            <%@ include file="layouts/client-head.jsp" %>

                <body>

                    <%@ include file="layouts/client-nav.jsp" %>

                        <div class="container" style="max-width: 800px; margin: 3rem auto; padding: 0 1.5rem;">

                            <div style="margin-bottom: 2rem;">
                                <a href="${pageContext.request.contextPath}/customers/transactions"
                                    style="color: var(--text-muted); text-decoration: none; display: flex; align-items: center; gap: 0.5rem; font-weight: 500;">
                                    <i class="fas fa-arrow-left"></i> Volver a Transacciones
                                </a>
                            </div>

                            <div
                                style="background: white; border-radius: var(--radius-lg); box-shadow: var(--shadow-md); overflow: hidden;">
                                <div
                                    style="background: var(--light); padding: 1.5rem 2rem; border-bottom: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center;">
                                    <div>
                                        <h1 style="font-size: 1.25rem; margin: 0; font-weight: 700;">Orden
                                            #${transactionId}</h1>
                                        <div style="color: var(--text-muted); font-size: 0.9rem; margin-top: 0.25rem;">
                                            <fmt:formatDate value="${transactionDate}"
                                                pattern="dd 'de' MMMM, yyyy HH:mm" />
                                        </div>
                                    </div>
                                    <span class="badge badge-success"
                                        style="background: #dcfce7; color: #166534; padding: 0.5rem 1rem; border-radius: 2rem; font-weight: 600; font-size: 0.9rem;">
                                        Completada
                                    </span>
                                </div>

                                <div style="padding: 2rem;">
                                    <h3 style="margin-bottom: 1.5rem; font-size: 1.1rem;">Detalles de la Compra</h3>

                                    <div class="table-container">
                                        <table style="width: 100%; border-collapse: collapse;">
                                            <thead>
                                                <tr
                                                    style="border-bottom: 2px solid var(--light); text-align: left; color: var(--text-muted); font-size: 0.9rem;">
                                                    <th style="padding: 1rem 0;">Libro</th>
                                                    <th style="padding: 1rem 0; text-align: right;">Precio</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="book" items="${bookList}">
                                                    <tr style="border-bottom: 1px solid var(--light);">
                                                        <td style="padding: 1rem 0;">
                                                            <div style="font-weight: 600;">${book.name}</div>
                                                            <div style="font-size: 0.85rem; color: var(--text-muted);">
                                                                ${book.bookDetail.type}</div>
                                                        </td>
                                                        <td
                                                            style="padding: 1rem 0; text-align: right; font-weight: 600;">
                                                            $
                                                            <fmt:formatNumber value="${book.price}" type="number"
                                                                groupingUsed="true" minFractionDigits="0" />
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td style="padding: 1.5rem 0; font-weight: 700; font-size: 1.1rem;">
                                                        Total Pagado</td>
                                                    <td
                                                        style="padding: 1.5rem 0; text-align: right; font-weight: 800; font-size: 1.25rem; color: var(--primary);">
                                                        $
                                                        <fmt:formatNumber value="${totalAmount}" type="number"
                                                            groupingUsed="true" minFractionDigits="0" />
                                                    </td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>

                                    <div
                                        style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid var(--border-color); display: flex; justify-content: flex-end;">
                                        <button class="btn-secondary" onclick="window.print()"
                                            style="display: flex; align-items: center; gap: 0.5rem; padding: 0.75rem 1.5rem; border-radius: var(--radius-md); border: 1px solid var(--border-color); background: white; cursor: pointer; font-weight: 600;">
                                            <i class="fas fa-print"></i> Imprimir Recibo
                                        </button>
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