<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.AppIntentory.model.User" %>

<%
    User usuario = (User) session.getAttribute("usuario");

    Integer totalUsuarios = (Integer) request.getAttribute("totalUsuarios");
    Integer usuariosActivos = (Integer) request.getAttribute("usuariosActivos");
    Integer usuariosInactivos = (Integer) request.getAttribute("usuariosInactivos");

    Integer totalItems = (Integer) request.getAttribute("totalItems");
    Integer totalLibros = (Integer) request.getAttribute("totalLibros");
    Integer totalComics = (Integer) request.getAttribute("totalComics");
    Integer totalMangas = (Integer) request.getAttribute("totalMangas");

    if (totalUsuarios == null) totalUsuarios = 0;
    if (usuariosActivos == null) usuariosActivos = 0;
    if (usuariosInactivos == null) usuariosInactivos = 0;

    if (totalItems == null) totalItems = 0;
    if (totalLibros == null) totalLibros = 0;
    if (totalComics == null) totalComics = 0;
    if (totalMangas == null) totalMangas = 0;
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Admin - AppInventory</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header" onclick="toggleSidebar()">☰</div>

    <ul class="sidebar-menu">
        <li>
            <a href="<%= request.getContextPath() %>/admin" class="active">
                <span class="sidebar-icon">📊</span>
                <span class="sidebar-text">Dashboard</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/admin?action=users">
                <span class="sidebar-icon">👤</span>
                <span class="sidebar-text">Usuarios</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/admin?action=items">
                <span class="sidebar-icon">📚</span>
                <span class="sidebar-text">Items</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/items?action=new">
                <span class="sidebar-icon">➕</span>
                <span class="sidebar-text">Nuevo Item</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/items">
                <span class="sidebar-icon">📁</span>
                <span class="sidebar-text">Mi Inventario</span>
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
                <h2>Dashboard de Administración</h2>
                <p class="subtitle">
                    Bienvenido,
                    <strong><%= (usuario != null) ? usuario.getName() : "Administrador" %></strong>
                </p>
            </div>
        </div>

        <div class="card-grid">
            <div class="card card-blue">
                <div class="card-icon">👤</div>
                <div>
                    <span class="card-number"><%= totalUsuarios %></span>
                    <span class="card-label">Usuarios registrados</span>
                </div>
            </div>

            <div class="card card-green">
                <div class="card-icon">📚</div>
                <div>
                    <span class="card-number"><%= totalItems %></span>
                    <span class="card-label">Items registrados</span>
                </div>
            </div>

            <div class="card card-orange">
                <div class="card-icon">✅</div>
                <div>
                    <span class="card-number"><%= usuariosActivos %></span>
                    <span class="card-label">Usuarios activos</span>
                </div>
            </div>

            <div class="card card-indigo">
                <div class="card-icon">📖</div>
                <div>
                    <span class="card-number"><%= totalLibros + totalComics + totalMangas %></span>
                    <span class="card-label">Distribución inventario</span>
                </div>
            </div>
        </div>

        <div class="page-header">
            <div>
                <h2>Resumen gráfico</h2>
                <p class="subtitle">Haz clic en una sección del gráfico para filtrar automáticamente</p>
            </div>
        </div>

        <div class="card-grid">
            <div class="chart-card">
                <h2>Usuarios</h2>
                <canvas id="usuariosChart"></canvas>
            </div>

            <div class="chart-card">
                <h2>Tipos de ítems</h2>
                <canvas id="itemsChart"></canvas>
            </div>
        </div>

    </div>
</main>

<script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("expanded");
    }

    const usuariosChart = document.getElementById('usuariosChart');
    new Chart(usuariosChart, {
        type: 'pie',
        data: {
            labels: ['Activos', 'Inactivos'],
            datasets: [{
                data: [<%= usuariosActivos %>, <%= usuariosInactivos %>]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            onClick: function(evt, elements) {
                if (elements.length > 0) {
                    const index = elements[0].index;
                    if (index === 0) {
                        window.location.href = '<%= request.getContextPath() %>/admin?action=users&estado=activo';
                    } else if (index === 1) {
                        window.location.href = '<%= request.getContextPath() %>/admin?action=users&estado=inactivo';
                    }
                }
            }
        }
    });

    const itemsChart = document.getElementById('itemsChart');
    new Chart(itemsChart, {
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
            onClick: function(evt, elements) {
                if (elements.length > 0) {
                    const index = elements[0].index;
                    if (index === 0) {
                        window.location.href = '<%= request.getContextPath() %>/admin?action=items&tipo=Libros';
                    } else if (index === 1) {
                        window.location.href = '<%= request.getContextPath() %>/admin?action=items&tipo=Comics';
                    } else if (index === 2) {
                        window.location.href = '<%= request.getContextPath() %>/admin?action=items&tipo=Mangas';
                    }
                }
            }
        }
    });
</script>

</body>
</html>