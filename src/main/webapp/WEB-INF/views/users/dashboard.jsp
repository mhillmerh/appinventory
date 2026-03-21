<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.AppIntentory.model.User" %>

<%
    User usuario = (User) session.getAttribute("usuario");

    Integer totalItems = (Integer) request.getAttribute("totalItems");
    Integer totalLibros = (Integer) request.getAttribute("totalLibros");
    Integer totalComics = (Integer) request.getAttribute("totalComics");
    Integer totalMangas = (Integer) request.getAttribute("totalMangas");

    if (totalItems == null) totalItems = 0;
    if (totalLibros == null) totalLibros = 0;
    if (totalComics == null) totalComics = 0;
    if (totalMangas == null) totalMangas = 0;
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Panel - AppInventory</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header" onclick="toggleSidebar()">☰</div>

    <ul class="sidebar-menu">
        <li>
            <a href="<%= request.getContextPath() %>/user" class="active">
                <span class="sidebar-icon">🏠</span>
                <span class="sidebar-text">Mi Panel</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/items">
                <span class="sidebar-icon">📁</span>
                <span class="sidebar-text">Mi Inventario</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/items?action=new">
                <span class="sidebar-icon">➕</span>
                <span class="sidebar-text">Nuevo Item</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/user?action=password">
                <span class="sidebar-icon">🔐</span>
                <span class="sidebar-text">Cambiar contraseña</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/user?action=help">
                <span class="sidebar-icon">❓</span>
                <span class="sidebar-text">Ayuda</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/user?action=donate">
                <span class="sidebar-icon">💖</span>
                <span class="sidebar-text">Donar</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/logout">
                <span class="sidebar-icon">🚪</span>
                <span class="sidebar-text">Cerrar sesión</span>
            </a>
        </li>
    </ul>
</div>

<main class="main-content">
    <div class="content-wrapper">

        <div class="page-header">
            <div>
                <h2>Mi Panel</h2>
                <p class="subtitle">Bienvenido, <strong><%= usuario != null ? usuario.getName() : "Usuario" %></strong></p>
            </div>
        </div>

        <div class="card-grid">
            <div class="card card-blue">
                <div class="card-icon">📚</div>
                <div>
                    <span class="card-number"><%= totalLibros %></span>
                    <span class="card-label">Libros</span>
                </div>
            </div>

            <div class="card card-green">
                <div class="card-icon">🦸</div>
                <div>
                    <span class="card-number"><%= totalComics %></span>
                    <span class="card-label">Comics</span>
                </div>
            </div>

            <div class="card card-orange">
                <div class="card-icon">📖</div>
                <div>
                    <span class="card-number"><%= totalMangas %></span>
                    <span class="card-label">Mangas</span>
                </div>
            </div>

            <div class="card card-indigo">
                <div class="card-icon">📦</div>
                <div>
                    <span class="card-number"><%= totalItems %></span>
                    <span class="card-label">Total de elementos</span>
                </div>
            </div>
        </div>

        <div class="page-header">
            <div>
                <h2>Distribución de tu colección</h2>
                <p class="subtitle">Resumen visual de tus items</p>
            </div>
        </div>

        <div class="card-grid">
            <div class="chart-card" style="text-align:center;">
                <h2>Mi colección</h2>
                <div class="chart-container-small">
                    <canvas id="coleccionChart"></canvas>
                </div>
            </div>
        </div>

    </div>
</main>

<script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("expanded");
    }

    const coleccionChart = document.getElementById('coleccionChart');
    new Chart(coleccionChart, {
        type: 'pie',
        data: {
            labels: ['Libros', 'Comics', 'Mangas'],
            datasets: [{
                data: [<%= totalLibros %>, <%= totalComics %>, <%= totalMangas %>]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });
</script>

</body>
</html>