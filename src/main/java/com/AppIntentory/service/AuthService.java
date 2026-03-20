package com.AppIntentory.service;

import com.AppIntentory.dao.UserDAO;
import com.AppIntentory.model.Role;
import com.AppIntentory.model.User;
import com.AppIntentory.util.PasswordUtil;

public class AuthService {

    private UserDAO userDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
    }

    public User login(String email, String password) {

        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            return null;
        }

        User usuario = userDAO.buscarUsuarioPorEmail(email);

        if (usuario == null) {
            return null;
        }

        if (!usuario.isActive()) {
            return null;
        }

        boolean passwordCorrecta = PasswordUtil.checkPassword(password, usuario.getPassword());

        if (!passwordCorrecta) {
            return null;
        }

        return usuario;
    }

    public boolean registrarUsuario(User user) {

        if (user == null) {
            return false;
        }

        if (user.getName() == null || user.getName().trim().isEmpty()) {
            return false;
        }

        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return false;
        }

        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            return false;
        }

        User existente = userDAO.buscarUsuarioPorEmail(user.getEmail());

        if (existente != null) {
            return false;
        }

        String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
        user.setPassword(hashedPassword);

        user.setRole(Role.Usuario);
        user.setActive(true);

        userDAO.registrarUsuario(user);
        return true;
    }

    public User buscarUsuarioPorEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return null;
        }

        return userDAO.buscarUsuarioPorEmail(email);
    }

    public boolean existeEmail(String email) {
        return buscarUsuarioPorEmail(email) != null;
    }
}