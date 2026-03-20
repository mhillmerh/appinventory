<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.AppIntentory.model.Item" %>
<%@ page import="com.AppIntentory.model.User" %>

<%
    List<Item> items = (List<Item>) request.getAttribute("items");
    User usuario = (User) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Inventario - AppInventory</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
</head>
<body>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header" onclick="toggleSidebar()">☰</div>

    <ul class="sidebar-menu">
        <% if (usuario != null && usuario.getRole().name().equals("Administrador")) { %>
            <li>
                <a href="<%= request.getContextPath() %>/admin">
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
                    <span class="sidebar-text">Items Admin</span>
                </a>
            </li>
        <% } %>

        <li>
            <a href="<%= request.getContextPath() %>/items" class="active">
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
                <h2>Mi Inventario</h2>
                <p class="subtitle">Visualiza y gestiona tu colección personal</p>
            </div>

            <a href="<%= request.getContextPath() %>/items?action=new" class="btn btn-primary">
                + Nuevo Item
            </a>
            <a href="<%= request.getContextPath() %>/user" class="btn btn-outline">← Volver</a>

        </div>

        <%
            String success = (String) request.getAttribute("success");
            String error = (String) request.getAttribute("error");
        %>

        <% if (success != null) { %>
            <div class="alert alert-success"><%= success %></div>
        <% } %>

        <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>

        <% if (items == null || items.isEmpty()) { %>
            <div class="alert alert-info">
                No tienes items registrados aún. Agrega tu primer libro, cómic o manga.
            </div>
            <p class="empty-msg">No hay elementos para mostrar.</p>
        <% } else { %>

            <div class="inventory-grid">
                <% for (Item item : items) { %>
                    <div class="inventory-card">

                        <div class="inventory-image-wrapper">
                            <% if (item.getImage() != null && !item.getImage().trim().isEmpty()) { %>
                                <img src="<%= item.getImage() %>" alt="<%= item.getTitle() %>" class="inventory-image">
                            <% } else { %>
                                <div class="inventory-no-image">Sin imagen</div>
                            <% } %>
                        </div>

                        <div class="inventory-body">

                            <div>
                                <div class="inventory-title"><%= item.getTitle() %></div>

                                <div class="inventory-meta">
                                    <strong>Autor:</strong> <%= item.getAuthor() %>
                                </div>

                                <div class="inventory-meta">
                                    <strong>Tipo:</strong> <%= item.getType() %>
                                </div>

                                <div class="inventory-meta">
                                    <strong>Volumen:</strong> <%= item.getVolume() %>
                                    &nbsp;|&nbsp;
                                    <strong>Editorial:</strong> <%= item.getEditorial() %>
                                </div>
                            </div>

                            <div class="inventory-actions">
                                <a href="<%= request.getContextPath() %>/items?action=edit&id=<%= item.getId() %>"
                                   class="btn btn-secondary btn-sm">
                                    Editar
                                </a>

                                <a href="<%= request.getContextPath() %>/items?action=delete&id=<%= item.getId() %>"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('¿Eliminar este item?');">
                                    Eliminar
                                </a>
                            </div>

                        </div>
                    </div>
                <% } %>
            </div>

        <% } %>

    </div>
</main>

<script>
    function toggleSidebar() {
        document.getElementById("sidebar").classList.toggle("expanded");
    }
</script>

</body>
</html>