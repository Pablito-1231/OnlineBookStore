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

                            <!-- Stats Grid -->
                            <div class="dashboard-grid" style="grid-template-columns: repeat(4, 1fr);">
                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div class="stat-icon books"><i class="fas fa-book"></i></div>
                                    </div>
                                    <div class="stat-value">${totalLibros}</div>
                                    <div class="stat-label">Total Libros</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div class="stat-icon sales"><i class="fas fa-check"></i></div>
                                    </div>
                                    <div class="stat-value">${librosDisponibles}</div>
                                    <div class="stat-label">Disponibles</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div class="stat-icon revenue"><i class="fas fa-exclamation-triangle"></i></div>
                                    </div>
                                    <div class="stat-value">${librosAgotados}</div>
                                    <div class="stat-label">Agotados</div>
                                </div>
                                <div class="stat-card">
                                    <div class="stat-header">
                                        <div class="stat-icon users"><i class="fas fa-users"></i></div>
                                    </div>
                                    <div class="stat-value">${totalUsuarios}</div>
                                    <canvas id="pieChart"></canvas>
                                </div>
                            </div>
                </div>
                </main>
                </div>

                <script>
                    // Main Chart
                    const ctxMain = document.getElementById('mainChart').getContext('2d');
                    new Chart(ctxMain, {
                        type: 'bar',
                        data: {
                            labels: ['Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab', 'Dom'],
                            datasets: [{
                                label: 'Ventas',
                                data: [12, 19, 3, 5, 2, 3, 10],
                                backgroundColor: '#4f46e5',
                                borderRadius: 4,
                                barThickness: 20
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: { legend: { display: false } },
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