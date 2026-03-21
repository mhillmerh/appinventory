<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.AppIntentory.model.User" %>

<%
    User usuario = (User) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ayuda - AppInventory</title>
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
            <a href="<%= request.getContextPath() %>/user?action=help" class="active">
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
                <h2>Ayuda y soporte</h2>
                <p class="subtitle">Información útil para usar la aplicación</p>
            </div>

            <a href="<%= request.getContextPath() %>/user" class="btn btn-outline">← Volver</a>
        </div>

        <div class="info-section">
            <div class="info-card">
                <h3>Cómo agregar imágenes</h3>
                <p>
                    Para agregar una imagen a tus items, puedes subirla primero a tu Google Drive
                    o a otro servicio similar, copiar la URL pública y luego pegarla en el campo
                    <strong>URL de imagen</strong> al crear o editar el item.
                </p>
            </div>

            <div class="info-card">
                <h3>Contacto</h3>
                <p>
                    Ante cualquier duda, consulta o si detectas alguna falla en la aplicación,
                    puedes comunicarte directamente conmigo.
                </p>
                <p>
                    <strong>Correo:</strong>
                    <a href="mailto:m.hillmerh@gmail.com">m.hillmerh@gmail.com</a>
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