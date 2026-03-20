<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.AppIntentory.model.Item" %>

<%
    List<Item> items = (List<Item>) request.getAttribute("items");

    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer pageSize = (Integer) request.getAttribute("pageSize");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer totalRegistros = (Integer) request.getAttribute("totalRegistros");
    String search = (String) request.getAttribute("search");
    String tipo = (String) request.getAttribute("tipo");

    if (currentPage == null) currentPage = 1;
    if (pageSize == null) pageSize = 10;
    if (totalPages == null) totalPages = 1;
    if (totalRegistros == null) totalRegistros = 0;
    if (search == null) search = "";
    if (tipo == null) tipo = "todos";
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Items - Admin</title>
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
            <a href="<%= request.getContextPath() %>/admin?action=users">
                <span class="sidebar-icon">👤</span>
                <span class="sidebar-text">Usuarios</span>
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/admin?action=items" class="active">
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
                <h2>Gestión de Items</h2>
                <p class="subtitle">Busca, filtra y administra libros, cómics y mangas</p>
            </div>

            <div style="display:flex; gap:10px; flex-wrap:wrap;">
                <a href="<%= request.getContextPath() %>/admin" class="btn btn-outline">
                    ← Dashboard
                </a>

                <a href="<%= request.getContextPath() %>/items?action=new" class="btn btn-primary">
                    + Nuevo Item
                </a>
            </div>
        </div>

        <div class="table-actions">
            <form action="<%= request.getContextPath() %>/admin" method="get">
                <input type="hidden" name="action" value="items">
                <input type="hidden" name="page" value="1">

                <input type="text" name="search" placeholder="Buscar por título, autor o editorial" value="<%= search %>">

                <select name="tipo">
                    <option value="todos" <%= "todos".equalsIgnoreCase(tipo) ? "selected" : "" %>>Todos</option>
                    <option value="Libros" <%= "Libros".equalsIgnoreCase(tipo) ? "selected" : "" %>>Libros</option>
                    <option value="Comics" <%= "Comics".equalsIgnoreCase(tipo) ? "selected" : "" %>>Comics</option>
                    <option value="Mangas" <%= "Mangas".equalsIgnoreCase(tipo) ? "selected" : "" %>>Mangas</option>
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

        <% if (items == null || items.isEmpty()) { %>
            <p class="empty-msg">Sin resultados</p>
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

                                <div class="inventory-meta">
                                    <strong>Usuario ID:</strong> <%= item.getUserId() %>
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

            <div class="table-footer">
                <div class="pagination">
                    <% for (int i = 1; i <= totalPages; i++) { %>
                        <a class="btn-page <%= i == currentPage ? "active" : "" %>"
                           href="<%= request.getContextPath() %>/admin?action=items&page=<%= i %>&size=<%= pageSize %>&search=<%= search %>&tipo=<%= tipo %>">
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