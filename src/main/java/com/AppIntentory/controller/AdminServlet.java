package com.AppIntentory.controller;

import com.AppIntentory.model.Item;
import com.AppIntentory.model.ItemType;
import com.AppIntentory.model.Role;
import com.AppIntentory.model.User;
import com.AppIntentory.service.ItemService;
import com.AppIntentory.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private UserService userService;
    private ItemService itemService;

    @Override
    public void init() {
        this.userService = new UserService();
        this.itemService = new ItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("users".equals(action)) {
            cargarVistaUsuarios(request, response);
            return;
        }

        if ("items".equals(action)) {
            cargarVistaItems(request, response);
            return;
        }

        if ("editUser".equals(action)) {
            String idParam = request.getParameter("id");

            if (idParam != null && !idParam.trim().isEmpty()) {
                int id = Integer.parseInt(idParam);
                User user = userService.buscarPorID(id);

                if (user != null) {
                    request.setAttribute("editUser", user);
                    request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
                    return;
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin?action=users");
            return;
        }

        cargarDashboard(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User usuarioSesion = (User) request.getSession().getAttribute("usuario");
        String action = request.getParameter("action");

        if ("updateUser".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String roleParam = request.getParameter("role");
            boolean active = Boolean.parseBoolean(request.getParameter("active"));

            Role role = Role.valueOf(roleParam);

            User user = new User(id, name, email, password, role, active);

            boolean actualizado = userService.actualizarUsuario(user, usuarioSesion);

            if (actualizado) {
                response.sendRedirect(request.getContextPath() + "/admin?action=users");
            } else {
                request.setAttribute("error", "No se pudo actualizar el usuario");
                request.setAttribute("editUser", user);
                request.getRequestDispatcher("/WEB-INF/views/admin/user-form.jsp").forward(request, response);
            }
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin");
    }

    private void cargarVistaItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String tipo = request.getParameter("tipo");

        List<Item> items = itemService.buscarItemsConFiltros(search, tipo);

        if (items == null) {
            items = new ArrayList<>();
        }

        int size = obtenerSize(request.getParameter("size"));
        int page = obtenerPage(request.getParameter("page"));

        int totalRegistros = items.size();
        int totalPages = (int) Math.ceil((double) totalRegistros / size);
        if (totalPages <= 0) totalPages = 1;

        if (page > totalPages) {
            page = totalPages;
        }

        int fromIndex = (page - 1) * size;
        int toIndex = Math.min(fromIndex + size, totalRegistros);

        List<Item> itemsPaginados;
        if (totalRegistros == 0 || fromIndex >= totalRegistros) {
            itemsPaginados = Collections.emptyList();
        } else {
            itemsPaginados = items.subList(fromIndex, toIndex);
        }

        request.setAttribute("items", itemsPaginados);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", size);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRegistros", totalRegistros);
        request.setAttribute("search", search);
        request.setAttribute("tipo", tipo);

        request.getRequestDispatcher("/WEB-INF/views/admin/items.jsp").forward(request, response);
    }

    private void cargarVistaUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String estado = request.getParameter("estado");

        List<User> usuarios = userService.buscarUsuariosConFiltros(search, estado);

        if (usuarios == null) {
            usuarios = new ArrayList<>();
        }

        int size = obtenerSize(request.getParameter("size"));
        int page = obtenerPage(request.getParameter("page"));

        int totalRegistros = usuarios.size();
        int totalPages = (int) Math.ceil((double) totalRegistros / size);
        if (totalPages <= 0) totalPages = 1;

        if (page > totalPages) {
            page = totalPages;
        }

        int fromIndex = (page - 1) * size;
        int toIndex = Math.min(fromIndex + size, totalRegistros);

        List<User> usuariosPaginados;
        if (totalRegistros == 0 || fromIndex >= totalRegistros) {
            usuariosPaginados = Collections.emptyList();
        } else {
            usuariosPaginados = usuarios.subList(fromIndex, toIndex);
        }

        request.setAttribute("usuarios", usuariosPaginados);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", size);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRegistros", totalRegistros);
        request.setAttribute("search", search);
        request.setAttribute("estado", estado);

        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }

    private int obtenerSize(String sizeParam) {
        if (sizeParam == null || sizeParam.trim().isEmpty()) {
            return 10;
        }

        try {
            int size = Integer.parseInt(sizeParam.trim());

            if (size == 5 || size == 10 || size == 20) {
                return size;
            }
        } catch (NumberFormatException e) {
            return 10;
        }

        return 10;
    }

    private int obtenerPage(String pageParam) {
        if (pageParam == null || pageParam.trim().isEmpty()) {
            return 1;
        }

        try {
            int page = Integer.parseInt(pageParam.trim());
            return Math.max(page, 1);
        } catch (NumberFormatException e) {
            return 1;
        }
    }

    private void cargarDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> usuarios = userService.listarUsuarios();
        List<Item> items = itemService.listarTodos();

        int totalUsuarios = usuarios != null ? usuarios.size() : 0;
        int usuariosActivos = 0;
        int usuariosInactivos = 0;

        if (usuarios != null) {
            for (User user : usuarios) {
                if (user.isActive()) {
                    usuariosActivos++;
                } else {
                    usuariosInactivos++;
                }
            }
        }

        int totalItems = items != null ? items.size() : 0;
        int totalLibros = 0;
        int totalComics = 0;
        int totalMangas = 0;

        if (items != null) {
            for (Item item : items) {
                if (item.getType() == ItemType.Libros) {
                    totalLibros++;
                } else if (item.getType() == ItemType.Comics) {
                    totalComics++;
                } else if (item.getType() == ItemType.Mangas) {
                    totalMangas++;
                }
            }
        }

        request.setAttribute("totalUsuarios", totalUsuarios);
        request.setAttribute("usuariosActivos", usuariosActivos);
        request.setAttribute("usuariosInactivos", usuariosInactivos);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("totalLibros", totalLibros);
        request.setAttribute("totalComics", totalComics);
        request.setAttribute("totalMangas", totalMangas);

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}