package com.AppIntentory.dao;

import com.AppIntentory.model.Role;
import com.AppIntentory.model.User;
import com.AppIntentory.util.DBConnection;

import javax.xml.transform.Result;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    public User login (String email, String password) {
        User usuario = null;

        try {
            Connection conexion = DBConnection.conectar();

            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

            PreparedStatement ps = conexion.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new User(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("password"),
                    Role.valueOf(rs.getString("role")),
                    rs.getBoolean("active")
                );
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return usuario;
    }

    public User buscarUsuarioPorEmail(String email){
        User usuario = null;

        try {
            Connection conexion = DBConnection.conectar();

            String sql = "SELECT * FROM users WHERE email = ?";

            PreparedStatement ps = conexion.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new User(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("password"),
                            Role.valueOf(rs.getString("role")),
                            rs.getBoolean("active")
                        );
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return usuario;
    }
    public User buscarUsuarioPorID(int id){
        User usuario = null;

        try {
            Connection conexion = DBConnection.conectar();

            String sql = "SELECT * FROM users WHERE email = ?";

            PreparedStatement ps = conexion.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        Role.valueOf(rs.getString("role")),
                        rs.getBoolean("active")
                );
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return usuario;
    }

    public void registrarUsuario(User user) {
        Connection conexion = DBConnection.conectar();

        if (conexion == null) {
            System.out.println("No se ha podido establecer conexión con la base de datos.");
            return;
        }

        try {
            String sql = "INSERT INTO users (name, email, password, role, active) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = conexion.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword()); // aquí ya viene hasheada
            ps.setString(4, user.getRole().name());
            ps.setBoolean(5, user.isActive());

            ps.executeUpdate();

            System.out.println("Usuario registrado con éxito");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<User> listarUsuarios() {
        List<User> lista = new ArrayList<>();

        try {
            Connection conexion = DBConnection.conectar();

            String sql = "SELECT * FROM users";

            Statement st = conexion.createStatement();

            ResultSet rs = st.executeQuery(sql);

            while(rs.next()) {
                User usuario = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        Role.valueOf(rs.getString("role")),
                        rs.getBoolean("active")
                );
                lista.add(usuario);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public void actualizarUsuario(User user) {

        try {
            Connection conexion = DBConnection.conectar();

            String sql = "UPDATE users SET name = ?, email = ?, password = ?, role = ?, active = ? WHERE id = ?";

            PreparedStatement ps = conexion.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole().name());
            ps.setBoolean(5, user.isActive());
            ps.setInt(6, user.getId());

            ps.executeUpdate();

            System.out.println("USuario actualizado con éxito");

        }catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void eliminarUsuarioPorId(int id){
        try{
            Connection conexion = DBConnection.conectar();

            String sql = "DELETE FROM users WHERE id = ?";

            PreparedStatement stmt = conexion.prepareStatement(sql);

            stmt.setInt(1, id);

            stmt.executeUpdate();

            System.out.println("Usuario elminiado correctamente");

        }catch (Exception e){
            System.out.println("Error: No se ha podido eliminar el usuario: " + e.getMessage());
        }
    }

    public List<User> buscarUsuarios(String texto) {
        List<User> lista = new ArrayList<>();

        try {
            Connection conexion = DBConnection.conectar();

            String sql = "SELECT * FROM users WHERE name LIKE ? OR email LIKE ?";

            PreparedStatement ps = conexion.prepareStatement(sql);
            ps.setString(1, "%" + texto + "%");
            ps.setString(2, "%" + texto + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User usuario = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        Role.valueOf(rs.getString("role")),
                        rs.getBoolean("active")
                );

                lista.add(usuario);
            }

        } catch (Exception e) {
            System.out.println("Error al buscar usuarios: " + e.getMessage());
        }

        return lista;
    }

    public List<User> buscarUsuariosConFiltros(String texto, String estado) {
        List<User> lista = new ArrayList<>();

        try {
            Connection conexion = DBConnection.conectar();

            StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1");
            List<Object> parametros = new ArrayList<>();

            if (texto != null && !texto.trim().isEmpty()) {
                sql.append(" AND (name LIKE ? OR email LIKE ?)");
                String valor = "%" + texto.trim() + "%";
                parametros.add(valor);
                parametros.add(valor);
            }

            if ("activo".equalsIgnoreCase(estado)) {
                sql.append(" AND active = ?");
                parametros.add(true);
            } else if ("inactivo".equalsIgnoreCase(estado)) {
                sql.append(" AND active = ?");
                parametros.add(false);
            }

            PreparedStatement ps = conexion.prepareStatement(sql.toString());

            for (int i = 0; i < parametros.size(); i++) {
                Object valor = parametros.get(i);
                if (valor instanceof String) {
                    ps.setString(i + 1, (String) valor);
                } else if (valor instanceof Boolean) {
                    ps.setBoolean(i + 1, (Boolean) valor);
                }
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User usuario = new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password"),
                        Role.valueOf(rs.getString("role")),
                        rs.getBoolean("active")
                );

                lista.add(usuario);
            }

        } catch (Exception e) {
            System.out.println("Error al buscar usuarios con filtros: " + e.getMessage());
        }

        return lista;
    }

}
