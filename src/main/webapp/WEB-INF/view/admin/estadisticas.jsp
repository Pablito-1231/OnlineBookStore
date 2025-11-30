<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:set var="pageTitle" value="Análisis de Ventas" scope="request" />
        <%@ include file="layouts/head-redesign.jsp" %>

            <body>
                <div class="app-container">
                    <%@ include file="sidebar.jsp" %>

                        <main class="app-main">
                            <div class="top-bar">
                                <div class="page-title">
                                    <h1>Análisis y Reportes</h1>
                                    <p>Visión detallada del rendimiento del negocio.</p>
                                </div>
                                <button class="action-btn" onclick="location.reload()">
                                    <i class="fas fa-sync-alt"></i> Actualizar
                                </button>
                            </div>

                            <!-- Stats Grid (Top Row: 4 Cards) -->
                            <div class="dashboard-grid"
                                style="grid-template-columns: repeat(4, 1fr); gap: 1.5rem; margin-bottom: 2rem;">
                                <!-- Card 1: Total Libros -->
                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div class="stat-icon books"><i class="fas fa-book"></i></div>
                                    </div>
                                    <div class="stat-value">${totalLibros}</div>
                                    <div class="stat-label">Total Libros</div>
                                </div>
                                <!-- Card 2: Disponibles -->
                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div class="stat-icon sales"><i class="fas fa-check"></i></div>
                                    </div>
                                    <div class="stat-value">${librosDisponibles}</div>
                                    <div class="stat-label">Disponibles</div>
                                </div>
                                <!-- Card 3: Agotados -->
                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div class="stat-icon revenue"><i class="fas fa-exclamation-triangle"></i></div>
                                    </div>
                                    <div class="stat-value">${librosAgotados}</div>
                                    <div class="stat-label">Agotados</div>
                                </div>
                                <!-- Card 4: Total Usuarios -->
                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div class="stat-icon users"><i class="fas fa-users"></i></div>
                                    </div>
                                    <div class="stat-value">${totalUsuarios}</div>
                                    <div class="stat-label">Total Usuarios</div>
                                </div>
                            </div>

                            <!-- Charts Section (Bottom Row: 2 Columns) -->
                            <div class="dashboard-grid" style="grid-template-columns: 2fr 1fr; gap: 1.5rem;">
                                <!-- Sales Chart (Left, Wider) -->
                                <div class="chart-container"
                                    style="background: white; padding: 1.5rem; border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); height: 400px;">
                                    <h3 style="margin-bottom: 1rem; color: #1f2937; font-size: 1.1rem;">Resumen de
                                        Ventas (Últimos 7 días)</h3>
                                    <div style="height: 320px; position: relative;">
                                        <canvas id="salesChart"></canvas>
                                    </div>
                                </div>

                                <!-- Pie Chart (Right, Narrower) -->
                                <div class="chart-container"
                                    style="background: white; padding: 1.5rem; border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); height: 400px;">
                                    <h3 style="margin-bottom: 1rem; color: #1f2937; font-size: 1.1rem;">Distribución de
                                        Formatos</h3>
                                    <div style="height: 320px; position: relative;">
                                        <canvas id="pieChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </main>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                <script>
                    // Sales Chart
                    const ctx = document.getElementById('salesChart').getContext('2d');
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: [
                                <c:forEach items="${chartLabels}" var="label" varStatus="status">
                                    '${label}'${!status.last ? ',' : ''}
                                </c:forEach>
                            ],
                            datasets: [{
                                label: 'Ventas',
                                data: [
                                    <c:forEach items="${chartData}" var="data" varStatus="status">
                                        ${data}${!status.last ? ',' : ''}
                                    </c:forEach>
                                ],
                                backgroundColor: '#4f46e5',
                                borderRadius: 4,
                                barThickness: 20
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { display: false }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    grid: { color: '#f3f4f6', borderDash: [2, 2] },
                                    border: { display: false }
                                },
                                x: {
                                    grid: { display: false },
                                    border: { display: false }
                                }
                            }
                        }
                    });

                    // Pie Chart
                    const ctxPie = document.getElementById('pieChart').getContext('2d');
                    new Chart(ctxPie, {
                        type: 'doughnut',
                        data: {
                            labels: ['E-Book', 'Tapa Blanda', 'Tapa Dura'],
                            datasets: [{
                                data: [30, 50, 20],
                                backgroundColor: ['#4f46e5', '#10b981', '#f59e0b'],
                                borderWidth: 0
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: { position: 'bottom', labels: { usePointStyle: true, padding: 20 } }
                            },
                            cutout: '75%'
                        }
                    });
                </script>
            </body>

            </html>