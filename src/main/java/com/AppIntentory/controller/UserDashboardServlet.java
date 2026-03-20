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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/user")
public class UserDashboardServlet extends HttpServlet {

    private ItemService itemService;
    private UserService userService;

    @Override
    public void init() {
        this.itemService = new ItemService();
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User usuarioSesion = (User) request.getSession().getAttribute("usuario");
        String action = request.getParameter("action");

        if (usuarioSesion == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("password".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/views/users/change-password.jsp").forward(request, response);
            return;
        }

        List<Item> items = itemService.listarPorUsuario(usuarioSesion.getId());
        if (items == null) {
            items = new ArrayList<>();
        }

        int totalItems = items.size();
        int totalLibros = 0;
        int totalComics = 0;
        int totalMangas = 0;

        for (Item item : items) {
            if (item.getType() == ItemType.Libros) {
                totalLibros++;
            } else if (item.getType() == ItemType.Comics) {
                totalComics++;
            } else if (item.getType() == ItemType.Mangas) {
                totalMangas++;
            }
        }

        request.setAttribute("totalItems", totalItems);
        request.setAttribute("totalLibros", totalLibros);
        request.setAttribute("totalComics", totalComics);
        request.setAttribute("totalMangas", totalMangas);

        request.getRequestDispatcher("/WEB-INF/views/users/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User usuarioSesion = (User) request.getSession().getAttribute("usuario");

        if (usuarioSesion == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("changePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            boolean cambiado = userService.cambiarPassword(
                    usuarioSesion.getId(),
                    currentPassword,
                    newPassword,
                    confirmPassword
            );

            if (cambiado) {
                request.setAttribute("success", "Contraseña actualizada correctamente");
            } else {
                request.setAttribute("error", "No se pudo actualizar la contraseña");
            }

            request.getRequestDispatcher("/WEB-INF/views/users/change-password.jsp").forward(request, response);
        }
    }
}