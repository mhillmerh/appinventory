<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.AppIntentory.model.Item" %>
<%@ page import="com.AppIntentory.model.ItemType" %>
<%@ page import="com.AppIntentory.model.User" %>

<%
    Item item = (Item) request.getAttribute("item");
    ItemType[] types = (ItemType[]) request.getAttribute("types");
    User usuario = (User) session.getAttribute("usuario");
    List<User> usuarios = (List<User>) request.getAttribute("usuarios");
    String error = (String) request.getAttribute("error");

    boolean editando = (item != null);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= editando ? "Editar Item" : "Nuevo Item" %> - AppInventory</title>
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
                    <span class="sidebar-text">Items</span>
                </a>
            </li>
        <% } %>

        <li>
            <a href="<%= request.getContextPath() %>/user">
                <span class="sidebar-icon">🏠</span>
                <span class="sidebar-text">Mi Panel</span>
            </a>
        </li>

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
                <h2><%= editando ? "Editar Item" : "Nuevo Item" %></h2>
                <p class="subtitle">Completa la información del inventario</p>
            </div>


        </div>

        <% if (error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>

        <div class="form-card">
            <form action="<%= request.getContextPath() %>/items" method="post">

                <% if (editando) { %>
                    <input type="hidden" name="id" value="<%= item.getId() %>">
                <% } %>

                <div class="form-group">
                    <label for="title">Título</label>
                    <input
                            type="text"
                            id="title"
                            name="title"
                            value="<%= editando ? item.getTitle() : "" %>"
                            required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="type">Tipo</label>
                        <select id="type" name="type" required>
                            <% if (types != null) {
                                for (ItemType type : types) { %>
                                    <option value="<%= type.name() %>"
                                        <%= (editando && item.getType() == type) ? "selected" : "" %>>
                                        <%= type.name() %>
                                    </option>
                            <%  }
                            } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="volume">Volumen</label>
                        <input
                                type="number"
                                id="volume"
                                name="volume"
                                min="1"
                                value="<%= editando ? item.getVolume() : "" %>"
                                required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="author">Autor</label>
                    <input
                            type="text"
                            id="author"
                            name="author"
                            value="<%= editando ? item.getAuthor() : "" %>"
                            required>
                </div>

                <div class="form-group">
                    <label for="editorial">Editorial</label>
                    <input
                            type="text"
                            id="editorial"
                            name="editorial"
                            value="<%= editando ? item.getEditorial() : "" %>"
                            required>
                </div>

                <div class="form-group">
                    <label for="image">URL de imagen</label>
                    <input
                            type="text"
                            id="image"
                            name="image"
                            value="<%= editando ? item.getImage() : "" %>">
                </div>

                <% if (usuario != null && usuario.getRole().name().equals("Administrador")) { %>
                    <div class="form-group">
                        <label for="userId">Asignar a usuario</label>
                        <select id="userId" name="userId" required>
                            <% if (usuarios != null) {
                                for (User u : usuarios) { %>
                                    <option value="<%= u.getId() %>"
                                        <%= (editando && item.getUserId() == u.getId()) ? "selected" : "" %>>
                                        <%= u.getName() %> - <%= u.getEmail() %>
                                    </option>
                            <%  }
                            } %>
                        </select>
                    </div>
                <% } %>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">
                        <%= editando ? "Actualizar" : "Guardar" %>
                    </button>

                    <a href="<%= request.getContextPath() %>/items" class="btn btn-secondary">
                        Cancelar
                    </a>

                     <a href="<%= request.getContextPath() %>/items" class="btn btn-outline">← Volver</a>
                </div>
            </form>
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