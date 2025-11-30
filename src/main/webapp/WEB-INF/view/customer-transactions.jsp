<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="es">

            <c:set var="pageTitle" value="Historial de Transacciones - BookStore" scope="request" />
            <%@ include file="layouts/client-head.jsp" %>

                <body>

                    <%@ include file="layouts/client-nav.jsp" %>

                        <div class="container" style="max-width: 1000px; margin: 3rem auto; padding: 0 1.5rem;">

                            <div class="section-header" style="text-align: left; margin-bottom: 2rem;">
                                <h1 class="section-title">Historial de Transacciones</h1>
                                <p class="section-subtitle">Revisa tus compras anteriores.</p>
                            </div>

                            <c:choose>
                                <c:when test="${empty transactionList}">
                                    <div
                                        style="text-align: center; padding: 4rem; background: white; border-radius: var(--radius-lg); box-shadow: var(--shadow-sm);">
                                        <div style="font-size: 4rem; color: var(--text-muted); margin-bottom: 1rem;">
                                            <i class="fas fa-receipt"></i>
                                        </div>
                                        <h2 style="margin-bottom: 1rem;">No hay transacciones</h2>
                                        <p style="color: var(--text-muted); margin-bottom: 2rem;">Aún no has realizado
                                            ninguna compra.</p>
                                        <a href="${pageContext.request.contextPath}/books" class="btn-primary"
                                            style="display: inline-block; width: auto; padding: 1rem 2rem; text-decoration: none;">
                                            Ir a Comprar
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div
                                        style="background: white; border-radius: var(--radius-lg); box-shadow: var(--shadow-sm); overflow: hidden;">
                                        <div class="table-container">
                                            <table style="width: 100%; border-collapse: collapse;">
                                                <thead>
                                                    <tr
                                                        style="background: var(--light); text-align: left; color: var(--text-muted); font-size: 0.9rem; font-weight: 600;">
                                                        <th style="padding: 1rem 1.5rem;">ID Transacción</th>
                                                        <th style="padding: 1rem 1.5rem;">Fecha</th>
                                                        <th style="padding: 1rem 1.5rem;">Total</th>
                                                        <th style="padding: 1rem 1.5rem;">Estado</th>
                                                        <th style="padding: 1rem 1.5rem;">Acciones</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="transaction" items="${transactionList}">
                                                        <tr style="border-bottom: 1px solid var(--border-color);">
                                                            <td
                                                                style="padding: 1rem 1.5rem; font-family: monospace; font-weight: 600;">
                                                                #${transaction.transactionId}</td>
                                                            <td style="padding: 1rem 1.5rem;">
                                                                <fmt:formatDate value="${transaction.transDate}"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                            </td>
                                                            <td style="padding: 1rem 1.5rem; font-weight: 600;">
                                                                $
                                                                <fmt:formatNumber value="${transaction.totalAmount}"
                                                                    type="number" groupingUsed="true"
                                                                    minFractionDigits="0" />
                                                            </td>
                                                            <td style="padding: 1rem 1.5rem;">
                                                                <span class="badge badge-success"
                                                                    style="background: #dcfce7; color: #166534; padding: 0.25rem 0.75rem; border-radius: 1rem; font-size: 0.8rem; font-weight: 600;">
                                                                    Exitosa
                                                                </span>
                                                            </td>
                                                            <td style="padding: 1rem 1.5rem;">
                                                                <a href="${pageContext.request.contextPath}/customers/transactions/${transaction.transactionId}"
                                                                    class="btn-secondary"
                                                                    style="text-decoration: none; padding: 0.5rem 1rem; border-radius: var(--radius-md); background: var(--light); color: var(--text-main); font-size: 0.9rem; font-weight: 500;">
                                                                    Ver Detalles
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
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