<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <c:set var="pageTitle" value="Dashboard" scope="request" />
            <%@ include file="layouts/head-redesign.jsp" %>
                <fmt:setLocale value="es_CO" />

                <body>

                    <div class="app-container">
                        <!-- SIDEBAR -->
                        <%@ include file="sidebar.jsp" %>

                            <!-- MAIN CONTENT -->
                            <main class="app-main">
                                <!-- TOP BAR -->
                                <div class="top-bar">
                                    <div class="page-title">
                                        <h1>Panel de Control</h1>
                                        <p>Bienvenido de nuevo, aquí está lo que sucede hoy.</p>
                                    </div>
                                    <button class="action-btn" onclick="location.reload()">
                                        <i class="fas fa-sync-alt"></i> Actualizar Datos
                                    </button>
                                </div>

                                <!-- STATS GRID -->
                                <div class="dashboard-grid">
                                    <!-- Card 1: Usuarios -->
                                    <div class="stat-card">
                                        <div class="stat-header">
                                            <div class="stat-icon users">
                                                <i class="fas fa-users"></i>
                                            </div>
                                            <span class="stat-trend trend-up">
                                                <i class="fas fa-arrow-up"></i> 12%
                                            </span>
                                        </div>
                                        <div class="stat-value">${totalUsuarios}</div>
                                        <div class="stat-label">Usuarios Totales</div>
                                    </div>

                                    <!-- Card 2: Libros -->
                                    <div class="stat-card">
                                        <div class="stat-header">
                                            <div class="stat-icon books">
                                                <i class="fas fa-book"></i>
                                            </div>
                                            <span class="stat-trend trend-up">
                                                <i class="fas fa-arrow-up"></i> 8%
                                            </span>
                                        </div>
                                        <div class="stat-value">${librosDisponibles}</div>
                                        <div class="stat-label">Libros en Catálogo</div>
                                    </div>

                                    <!-- Card 3: Ventas -->
                                    <div class="stat-card">
                                        <div class="stat-header">
                                            <div class="stat-icon sales">
                                                <i class="fas fa-shopping-bag"></i>
                                            </div>
                                            <span class="stat-trend trend-up">
                                                <i class="fas fa-arrow-up"></i> 24%
                                            </span>
                                        </div>
                                        <div class="stat-value">${comprasTotales}</div>
                                        <div class="stat-label">Ventas Realizadas</div>
                                    </div>

                                    <!-- Card 4: Ingresos -->
                                    <div class="stat-card">
                                        <div class="stat-header">
                                            <div class="stat-icon revenue">
                                                <i class="fas fa-dollar-sign"></i>
                                            </div>
                                            <span class="stat-trend trend-up">
                                                <i class="fas fa-arrow-up"></i> 18%
                                            </span>
                                        </div>
                                        <div class="stat-value">$
                                            <fmt:formatNumber value="${ingresosTotales}" type="number"
                                                groupingUsed="true" minFractionDigits="0" />
                                        </div>
                                        <div class="stat-label">Ingresos Totales</div>
                                    </div>
                                </div>

                                <!-- CONTENT GRID -->
                                <div class="content-grid">
                                    <!-- Chart Section -->
                                    <div class="content-card">
                                        <div class="card-title">
                                            <span>Resumen de Ventas</span>
                                            <select
                                                style="padding: 0.25rem; border-radius: 4px; border: 1px solid #ddd;">
                                                <option>Últimos 6 meses</option>
                                                <option>Este año</option>
                                            </select>
                                        </div>
                                        <div style="position: relative; height: 300px; width: 100%;">
                                            <canvas id="salesChart"></canvas>
                                        </div>
                                    </div>

                                    <!-- Quick Actions -->
                                    <div class="content-card">
                                        <div class="card-title">Acciones Rápidas</div>
                                        <div class="actions-grid">
                                            <a href="${pageContext.request.contextPath}/admin/libros/add"
                                                class="quick-action-card">
                                                <div class="quick-action-icon"><i class="fas fa-plus-circle"></i></div>
                                                <div class="quick-action-text">Nuevo Libro</div>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/usuarios"
                                                class="quick-action-card">
                                                <div class="quick-action-icon"><i class="fas fa-user-plus"></i></div>
                                                <div class="quick-action-text">Gestionar Usuarios</div>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/estadisticas"
                                                class="quick-action-card">
                                                <div class="quick-action-icon"><i class="fas fa-file-alt"></i></div>
                                                <div class="quick-action-text">Ver Reportes</div>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/reviews"
                                                class="quick-action-card">
                                                <div class="quick-action-icon"><i class="fas fa-star"></i></div>
                                                <div class="quick-action-text">Moderar Reseñas</div>
                                            </a>
                                        </div>

                                        <div
                                            style="margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid var(--border-color);">
                                            <div class="card-title" style="font-size: 1rem; margin-bottom: 1rem;">
                                                Métricas del
                                                Mes</div>
                                            <div
                                                style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                                <span style="color: var(--text-muted);">Ventas este mes</span>
                                                <span style="font-weight: 600;">${comprasMesActual}</span>
                                            </div>
                                            <div
                                                style="display: flex; justify-content: space-between; margin-bottom: 0.5rem;">
                                                <span style="color: var(--text-muted);">Ingresos este mes</span>
                                                <span style="font-weight: 600; color: var(--success);">$
                                                    <fmt:formatNumber value="${ingresosMesActual}" type="number"
                                                        groupingUsed="true" minFractionDigits="0" />
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </main>
                    </div>

                    <script>
                        // Configuración del Gráfico de Ventas
                        const ctx = document.getElementById('salesChart').getContext('2d');
                        const salesChart = new Chart(ctx, {
                            type: 'line',
                            data: {
                                labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'],
                                datasets: [{
                                    label: 'Ventas ($)',
                                    data: [12000, 19000, 15000, 25000, 22000, 30000], // Datos de ejemplo
                                    borderColor: '#4f46e5',
                                    backgroundColor: 'rgba(79, 70, 229, 0.1)',
                                    borderWidth: 2,
                                    tension: 0.4,
                                    fill: true,
                                    pointBackgroundColor: '#ffffff',
                                    pointBorderColor: '#4f46e5',
                                    pointBorderWidth: 2,
                                    pointRadius: 4
                                }]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    legend: {
                                        display: false
                                    }
                                },
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        grid: {
                                            borderDash: [2, 4],
                                            color: '#f3f4f6'
                                        },
                                        ticks: {
                                            callback: function (value) {
                                                return '$' + value / 1000 + 'k';
                                            }
                                        }
                                    },
                                    x: {
                                        grid: {
                                            display: false
                                        }
                                    }
                                }
                            }
                        });
                    </script>
                </body>

                </html>