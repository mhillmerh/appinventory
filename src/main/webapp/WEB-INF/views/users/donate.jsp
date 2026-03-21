<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.AppIntentory.model.User" %>

<%
    User usuario = (User) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Donar - AppInventory</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
</head>
<body>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header" onclick="toggleSidebar()">☰</div>

    <ul class="sidebar-menu">
        <li>
            <a href="<%= request.getContextPath() %>/user">
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
            <a href="<%= request.getContextPath() %>/user?action=donate" class="active">
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
                <h2>Apoya el proyecto</h2>
                <p class="subtitle">Gracias por considerar una donación</p>
            </div>

            <a href="<%= request.getContextPath() %>/user" class="btn btn-outline">← Volver</a>
        </div>

        <div class="info-section">
            <div class="info-card">
                <h3>Donaciones vía PayPal</h3>
                <p>
                    Si esta aplicación te ha resultado útil y quieres apoyar su desarrollo,
                    puedes hacer una donación voluntaria en USD.
                </p>

                <div class="donation-buttons">
                    <a href="https://paypal.me/mhillmerh" target="_blank" class="btn btn-primary btn-sm">$1 USD</a>
                    <a href="https://paypal.me/mhillmerh" target="_blank" class="btn btn-primary btn-sm">$5 USD</a>
                    <a href="https://paypal.me/mhillmerh" target="_blank" class="btn btn-primary btn-sm">$10 USD</a>
                    <a href="https://paypal.me/mhillmerh" target="_blank" class="btn btn-outline btn-sm">Otro monto</a>
                </div>
            </div>

            <div class="info-card">
                <h3>Gracias</h3>
                <p>
                    Tu apoyo ayuda a seguir mejorando la aplicación, corregir errores y agregar nuevas funciones.
                </p>
                <p>
                    <strong>PayPal:</strong>
                    <a href="https://paypal.me/mhillmerh" target="_blank">paypal.me/mhillmerh</a>
                </p>
            </div>
        </div>

    </div>
</main>

<script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("expanded");
    }
</script>

</body>
</html>