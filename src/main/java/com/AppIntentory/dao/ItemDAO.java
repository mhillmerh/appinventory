package com.AppIntentory.dao;

import com.AppIntentory.model.Item;
import com.AppIntentory.model.ItemType;
import com.AppIntentory.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.locks.StampedLock;

public class ItemDAO {

    public void agregarItem(Item item) {
        try{
            Connection conexion = DBConnection.conectar();

            String sql = "INSERT INTO items(title, type, volume, author, editorial, image, user_id) VALUES(?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conexion.prepareStatement(sql);

            stmt.setString(1,item.getTitle());
            stmt.setString(2, item.getType().name());
            stmt.setInt(3, item.getVolume());
            stmt.setString(4, item.getAuthor());
            stmt.setString(5, item.getEditorial());
            stmt.setString(6, item.getImage());
            stmt.setInt(7, item.getUserId());

            stmt.executeUpdate();
            System.out.println("Item agregado correctamente");
        }catch (Exception e) {
            System.out.println("Error al agregar el item: " + e.getMessage());
        }
    }

    public Item buscarPorID (int id) {
        Item item = null;

        try {
            Connection conexion = DBConnection.conectar();

            String sql = "SELECT * FROM items WHERE id = ?";

            PreparedStatement stmt = conexion.prepareStatement(sql);

            stmt.setInt(1, id);

            ResultSet rs = stmt.executeQuery();

            if(rs.next()) {
                int itemId = rs.getInt("id");
                String title = rs.getString("title");
                ItemType type = ItemType.valueOf(rs.getString("type"));
                int volume = rs. getInt("volume");
                String author = rs.getString("author");
                String editorial = rs.getString("editorial");
                String image = rs.getString("image");
                int user_id = rs.getInt("user_id");

                item = new Item(itemId, title, type, volume, author , editorial, image, user_id);
            }
        }catch (Exception e) {
            System.out.println("Error, no se ha podido listar los items: " + e.getMessage());
        }
        return item;
    }

    public List<Item> buscarItemPorNombre(String name){
        List<Item> items = new ArrayList<>();

        try{
            Connection conexion = DBConnection.conectar();

            String sql = "SELECT * FROM items WHERE LOWER(title) LIKE LOWER(?)";

            PreparedStatement stmt = conexion.prepareStatement(sql);

            stmt.setString(1, "%" + name + "%");

            ResultSet rs = stmt.executeQuery();

            if (rs.next()){
                int itemId = rs.getInt("id");
                String title = rs.getString("title");
                ItemType type = ItemType.valueOf(rs.getString("type"));
                int volume = rs. getInt("volume");
                String author = rs.getString("author");
                String editorial = rs.getString("editorial");
                String image = rs.getString("image");
                int user_id = rs.getInt("user_id");

                Item item = new Item(itemId, title, type, volume, author, editorial, image, user_id);

                items.add(item);

            }
        }catch (Exception e){
            System.out.println("Error, no se puede generar lista: " + e.getMessage());
        }
        return items;
    }

    public void actualizarItem(Item item) {
        try {
            Connection conexion = DBConnection.conectar();

            String sql = "UPDATE items SET title = ?, type = ?, volume = ?, author = ?, editorial = ?, image = ? WHERE id = ?";

            PreparedStatement stmt = conexion.prepareStatement(sql);

            stmt.setString(1, item.getTitle());
            stmt.setString(2, item.getType().name());
            stmt.setInt(3, item.getVolume());
            stmt.setString(4, item.getAuthor());
            stmt.setString(5, item.getEditorial());
            stmt.setString(6, item.getImage());
            stmt.setInt(7, item.getId());

            int filas = stmt.executeUpdate();

            if (filas > 0) {
                System.out.println("Item actualizado correctamente");
            } else {
                System.out.println("No se encontró el item para actualizar");
            }

        } catch (Exception e) {
            System.out.println("Error al actualizar item: " + e.getMessage());
        }
    }

    public void eliminarItem(int id) {

        try {
            Connection conexion = DBConnection.conectar();

            String sql = "DELETE FROM items WHERE id = ?";

            PreparedStatement stmt = conexion.prepareStatement(sql);

            stmt.setInt(1, id);

            stmt.executeUpdate();

            System.out.println("Item eliminado con éxito");
        }catch (Exception e){
            System.out.println("Error, No se ha podido eliminar el item indicado: " + e.getMessage());
        }
    }

    public List<Item> listarItems() {
        List<Item> items = new ArrayList<>();

        try{
            Connection conexion = DBConnection.conectar();

            String sql = "SELECT * FROM items";

            PreparedStatement stmt = conexion.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                int id = rs.getInt("id");
                String title = rs.getString("title");
                ItemType type = ItemType.valueOf(rs.getString("type"));
                int volume = rs.getInt("volume");
                String author = rs.getString("author");
                String editorial = rs.getString("editorial");
                String image = rs.getString("image");
                int user_id = rs.getInt("user_id");

                Item item = new Item(id, title, type, volume, author , editorial, image, user_id);

                items.add(item);
            }
        } catch (Exception e) {
            System.out.println("Error, no se ha podido listar items: " + e.getMessage());
        }
        return items;
    }

    public List<Item> listarItemsPorUsuario(int userId) {
        List<Item> items = new ArrayList<>();

        try{
            Connection conexion = DBConnection.conectar();

            String sql = "SELECT * FROM items WHERE user_id = ?";

            PreparedStatement stmt = conexion.prepareStatement(sql);

            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();

            while(rs.next()){
                int id = rs.getInt("id");
                String title = rs.getString("title");
                ItemType type = ItemType.valueOf(rs.getString("type"));
                int volume = rs.getInt("volume");
                String author = rs.getString("author");
                String editorial = rs.getString("editorial");
                String image = rs.getString("image");
                int user_id = rs.getInt("user_id");

                Item item = new Item(id, title, type, volume, author , editorial, image, user_id);

                items.add(item);
            }
        } catch (Exception e) {
            System.out.println("Error, no se ha podido listar items: " + e.getMessage());
        }
        return items;
    }

    public List<Item> buscarItems(String texto) {
        List<Item> lista = new ArrayList<>();

        try {
            Connection conexion = DBConnection.conectar();

            String sql = "SELECT * FROM items WHERE title LIKE ? OR author LIKE ? OR editorial LIKE ?";

            PreparedStatement stmt = conexion.prepareStatement(sql);
            stmt.setString(1, "%" + texto + "%");
            stmt.setString(2, "%" + texto + "%");
            stmt.setString(3, "%" + texto + "%");

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Item item = new Item(
                        rs.getInt("id"),
                        rs.getString("title"),
                        ItemType.valueOf(rs.getString("type")),
                        rs.getInt("volume"),
                        rs.getString("author"),
                        rs.getString("editorial"),
                        rs.getString("image"),
                        rs.getInt("user_id")
                );

                lista.add(item);
            }

        } catch (Exception e) {
            System.out.println("Error al buscar items: " + e.getMessage());
        }

        return lista;
    }
    public List<Item> buscarItemsConFiltros(String texto, String tipo) {
        List<Item> lista = new ArrayList<>();

        try {
            Connection conexion = DBConnection.conectar();

            StringBuilder sql = new StringBuilder("SELECT * FROM items WHERE 1=1");
            List<String> parametros = new ArrayList<>();

            if (texto != null && !texto.trim().isEmpty()) {
                sql.append(" AND (title LIKE ? OR author LIKE ? OR editorial LIKE ?)");
                String valor = "%" + texto.trim() + "%";
                parametros.add(valor);
                parametros.add(valor);
                parametros.add(valor);
            }

            if (tipo != null && !tipo.trim().isEmpty() && !tipo.equalsIgnoreCase("todos")) {
                sql.append(" AND type = ?");
                parametros.add(tipo);
            }

            PreparedStatement stmt = conexion.prepareStatement(sql.toString());

            for (int i = 0; i < parametros.size(); i++) {
                stmt.setString(i + 1, parametros.get(i));
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Item item = new Item(
                        rs.getInt("id"),
                        rs.getString("title"),
                        ItemType.valueOf(rs.getString("type")),
                        rs.getInt("volume"),
                        rs.getString("author"),
                        rs.getString("editorial"),
                        rs.getString("image"),
                        rs.getInt("user_id")
                );

                lista.add(item);
            }

        } catch (Exception e) {
            System.out.println("Error al buscar items con filtros: " + e.getMessage());
        }

        return lista;
    }
}
