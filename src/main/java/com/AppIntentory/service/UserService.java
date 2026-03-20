package com.AppIntentory.service;

import com.AppIntentory.dao.UserDAO;
import com.AppIntentory.model.Role;
import com.AppIntentory.model.User;

import java.util.List;

public class UserService {
    private UserDAO userDAO;

    public UserService(){
        this.userDAO = new UserDAO();
    }

    public List<User> listarUsuarios(){
        return userDAO.listarUsuarios();
    }

    public User bucarPorEmail(String email){
        if (email == null || email.trim().isEmpty()){
            return null;
        }
        return userDAO.buscarUsuarioPorEmail(email);
    }

    public User buscarPorID(int id) {
        if (id <= 0){
            return null;
        }
        return userDAO.buscarUsuarioPorID(id);
    }

    public boolean cambiarEstadoUsuario(int id, boolean active, User usuarioSesion){
        if (usuarioSesion == null || id <=0){
            return false;
        }
        boolean esAdministador =  usuarioSesion.getRole() == Role.Administrador;
        if(!esAdministador) {
            return false;
        }

        if (usuarioSesion.getId() == id){
            return false;
        }

        User usuario = userDAO.buscarUsuarioPorID(id);

        if(usuario == null){
            return false;
        }

        usuario.setActive(active);
        userDAO.actualizarUsuario(usuario);

        return true;
    }

    public boolean actualizarUsuario(User user, User usuarioSesion) {
        return true;
    }

    public List<User> buscarUsuarios(String texto) {
        if (texto == null || texto.trim().isEmpty()) {
            return listarUsuarios();
        }

        return userDAO.buscarUsuarios(texto.trim());
    }

    public List<User> buscarUsuariosConFiltros(String texto, String estado) {
        return userDAO.buscarUsuariosConFiltros(texto, estado);
    }

    public boolean cambiarPassword(int userId, String currentPassword, String newPassword, String confirmPassword) {
        if (userId <= 0) return false;
        if (currentPassword == null || currentPassword.trim().isEmpty()) return false;
        if (newPassword == null || newPassword.trim().isEmpty()) return false;
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) return false;
        if (!newPassword.equals(confirmPassword)) return false;

        User user = userDAO.buscarUsuarioPorID(userId);
        if (user == null) return false;

        boolean passwordActualCorrecta = com.AppIntentory.util.PasswordUtil.checkPassword(currentPassword, user.getPassword());
        if (!passwordActualCorrecta) return false;

        String nuevaHash = com.AppIntentory.util.PasswordUtil.hashPassword(newPassword);
        user.setPassword(nuevaHash);

        userDAO.actualizarUsuario(user);
        return true;
    }
}
