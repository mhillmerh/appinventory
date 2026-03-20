package com.AppIntentory.controller;

import com.AppIntentory.model.Item;
import com.AppIntentory.model.ItemType;
import com.AppIntentory.model.User;
import com.AppIntentory.service.ItemService;
import com.AppIntentory.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/items")
public class ItemServlet extends HttpServlet {

    private ItemService itemService;
    private UserService userService;

    @Override
    public void init() {
        this.itemService = new ItemService();
        this.userService = new UserService();
    }

    // ==========================
    // GET
    // ==========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User usuarioSesion = (User) request.getSession().getAttribute("usuario");

        if (usuarioSesion == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            // LISTAR ITEMS
            List<Item> items;

            if (usuarioSesion.getRole().name().equals("Administrador")) {
                items = itemService.listarTodos();
            } else {
                items = itemService.listarPorUsuario(usuarioSesion.getId());
            }

            request.setAttribute("items", items);
            request.getRequestDispatcher("/WEB-INF/views/items/list.jsp").forward(request, response);
            return;
        }

        switch (action) {

            case "new":
                request.setAttribute("types", ItemType.values());

                if (usuarioSesion.getRole().name().equals("Administrador")) {
                    request.setAttribute("usuarios", userService.listarUsuarios());
                }

                request.getRequestDispatcher("/WEB-INF/views/items/form.jsp").forward(request, response);
                break;

            case "edit":
                String idParam = request.getParameter("id");

                if (idParam != null) {
                    int id = Integer.parseInt(idParam);
                    Item item = itemService.buscarPorId(id);

                    if (item != null) {
                        request.setAttribute("item", item);
                        request.setAttribute("types", ItemType.values());

                        if (usuarioSesion.getRole().name().equals("Administrador")) {
                            request.setAttribute("usuarios", userService.listarUsuarios());
                        }

                        request.getRequestDispatcher("/WEB-INF/views/items/form.jsp").forward(request, response);
                        return;
                    }
                }

                response.sendRedirect(request.getContextPath() + "/items");
                break;

            case "delete":
                String deleteId = request.getParameter("id");

                if (deleteId != null) {
                    int id = Integer.parseInt(deleteId);
                    itemService.eliminarItem(id, usuarioSesion);
                }

                response.sendRedirect(request.getContextPath() + "/items");
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/items");
        }
    }

    // ==========================
    // POST (CREATE / UPDATE)
    // ==========================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User usuarioSesion = (User) request.getSession().getAttribute("usuario");

        if (usuarioSesion == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {

            String idParam = request.getParameter("id");
            String title = request.getParameter("title");
            String typeParam = request.getParameter("type");
            String volumeParam = request.getParameter("volume");
            String author = request.getParameter("author");
            String editorial = request.getParameter("editorial");
            String image = request.getParameter("image");

            // Validaciones básicas
            if (title == null || title.trim().isEmpty()
                    || typeParam == null
                    || volumeParam == null
                    || author == null || author.trim().isEmpty()
                    || editorial == null || editorial.trim().isEmpty()) {

                request.setAttribute("error", "Todos los campos son obligatorios");
                request.setAttribute("types", ItemType.values());

                if (usuarioSesion.getRole().name().equals("Administrador")) {
                    request.setAttribute("usuarios", userService.listarUsuarios());
                }

                request.getRequestDispatcher("/WEB-INF/views/items/form.jsp").forward(request, response);
                return;
            }

            ItemType type = ItemType.valueOf(typeParam);
            int volume = Integer.parseInt(volumeParam);

            // 🔥 AQUÍ ESTÁ LA CLAVE: asignación de usuario
            int userIdAsignado;

            if (usuarioSesion.getRole().name().equals("Administrador")) {
                String userIdParam = request.getParameter("userId");
                userIdAsignado = Integer.parseInt(userIdParam);
            } else {
                userIdAsignado = usuarioSesion.getId();
            }

            // ==========================
            // CREAR
            // ==========================
            if (idParam == null || idParam.trim().isEmpty()) {

                Item nuevo = new Item(0, title, type, volume, author, editorial, image, userIdAsignado);

                boolean creado = itemService.agregarItem(nuevo);

                if (!creado) {
                    request.setAttribute("error", "No se pudo crear el item");
                    request.setAttribute("types", ItemType.values());

                    if (usuarioSesion.getRole().name().equals("Administrador")) {
                        request.setAttribute("usuarios", userService.listarUsuarios());
                    }

                    request.getRequestDispatcher("/WEB-INF/views/items/form.jsp").forward(request, response);
                    return;
                }

            } else {
                // ==========================
                // EDITAR
                // ==========================
                int id = Integer.parseInt(idParam);

                Item editado = new Item(id, title, type, volume, author, editorial, image, userIdAsignado);

                boolean actualizado = itemService.actualizarItem(editado, usuarioSesion);

                if (!actualizado) {
                    request.setAttribute("error", "No se pudo actualizar el item");
                    request.setAttribute("item", editado);
                    request.setAttribute("types", ItemType.values());

                    if (usuarioSesion.getRole().name().equals("Administrador")) {
                        request.setAttribute("usuarios", userService.listarUsuarios());
                    }

                    request.getRequestDispatcher("/WEB-INF/views/items/form.jsp").forward(request, response);
                    return;
                }
            }

            response.sendRedirect(request.getContextPath() + "/items");

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("error", "Error inesperado: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/items/form.jsp").forward(request, response);
        }
    }
}