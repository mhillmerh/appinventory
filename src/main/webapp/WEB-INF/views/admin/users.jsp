<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.AppIntentory.model.User" %>

<%
    List<User> usuarios = (List<User>) request.getAttribute("usuarios");

    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer pageSize = (Integer) request.getAttribute("pageSize");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer totalRegistros = (Integer) request.getAttribute("totalRegistros");
    String search = (String) request.getAttribute("search");
    String estado = (String) request.getAttribute("estado");

    if (currentPage == null) currentPage = 1;
    if (pageSize == null) pageSize = 10;
    if (totalPages == null) totalPages = 1;
    if (totalRegistros == null) totalRegistros = 0;
    if (search == null) search = "";
    if (estado == null) estado = "";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Usuarios - Admin</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
</head>
<body>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header" onclick="toggleSidebar()">☰</div>

    <ul class="sidebar-menu">
        <li>
            <a href="<%= request.getContextPath() %>/admin">
                <span class="sidebar-icon">📊</span>
                <span class="sidebar-text">Dashboard</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/admin?action=users" class="active">
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
                <h2>Gestión de Usuarios</h2>
                <p class="subtitle">Busca, filtra y administra los usuarios registrados</p>
            </div>

            <a href="<%= request.getContextPath() %>/admin" class="btn btn-outline">
                ← Volver al dashboard
            </a>
        </div>

        <div class="table-actions">
            <form action="<%= request.getContextPath() %>/admin" method="get">
                <input type="hidden" name="action" value="users">
                <input type="hidden" name="page" value="1">

                <input type="text" name="search" placeholder="Buscar por nombre o email" value="<%= search %>">

                <select name="estado">
                    <option value="" <%= "".equals(estado) ? "selected" : "" %>>Todos</option>
                    <option value="activo" <%= "activo".equalsIgnoreCase(estado) ? "selected" : "" %>>Activos</option>
                    <option value="inactivo" <%= "inactivo".equalsIgnoreCase(estado) ? "selected" : "" %>>Inactivos</option>
                </select>

                <select name="size" onchange="this.form.submit()">
                    <option value="5" <%= pageSize == 5 ? "selected" : "" %>>5</option>
                    <option value="10" <%= pageSize == 10 ? "selected" : "" %>>10</option>
                    <option value="20" <%= pageSize == 20 ? "selected" : "" %>>20</option>
                </select>

                <button type="submit" class="btn btn-primary btn-sm">Buscar</button>
            </form>

            <span><strong>Total:</strong> <%= totalRegistros %></span>
        </div>

        <% if (usuarios == null || usuarios.isEmpty()) { %>
            <p class="empty-msg">Sin resultados</p>
        <% } else { %>

            <div class="table-wrapper">
                <table class="table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Rol</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (User u : usuarios) { %>
                        <tr>
                            <td><%= u.getId() %></td>
                            <td><%= u.getName() %></td>
                            <td><%= u.getEmail() %></td>
                            <td><%= u.getRole() %></td>
                            <td>
                                <span class="badge <%= u.isActive() ? "badge-green" : "badge-red" %>">
                                    <%= u.isActive() ? "Activo" : "Inactivo" %>
                                </span>
                            </td>
                            <td>
                                <a href="<%= request.getContextPath() %>/admin?action=editUser&id=<%= u.getId() %>"
                                   class="btn btn-secondary btn-sm">
                                    Editar
                                </a>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="table-footer">
                <div class="pagination">
                    <% for (int i = 1; i <= totalPages; i++) { %>
                        <a class="btn-page <%= i == currentPage ? "active" : "" %>"
                           href="<%= request.getContextPath() %>/admin?action=users&page=<%= i %>&size=<%= pageSize %>&search=<%= search %>&estado=<%= estado %>">
                            <%= i %>
                        </a>
                    <% } %>
                </div>
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