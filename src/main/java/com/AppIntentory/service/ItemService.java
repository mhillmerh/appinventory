package com.AppIntentory.service;

import com.AppIntentory.dao.ItemDAO;
import com.AppIntentory.model.Item;
import com.AppIntentory.model.Role;
import com.AppIntentory.model.User;

import java.util.*;

public class ItemService {
    private ItemDAO itemDAO;

    public ItemService(){
        this.itemDAO = new ItemDAO();
    }

    public boolean agregarItem(Item item){
        if (item == null){
            return false;
        }

        if (item.getTitle() == null || item.getTitle().trim().isEmpty()){
            return false;
        }

        if (item.getType() == null) {
            return false;
        }

        if (item.getAuthor() == null || item.getAuthor().trim().isEmpty()){
            return false;
        }

        if (item.getEditorial() == null || item.getEditorial().trim().isEmpty()){
            return false;
        }

        if (item.getUserId() <= 0){
            return false;
        }

        itemDAO.agregarItem(item);

        return true;
    }

    public boolean actualizarItem (Item item, User usuarioSesion){
        if (item == null || usuarioSesion == null){
            return false;
        }

        Item existente = itemDAO.buscarPorID(item.getId());

        if (existente == null){
            return false;
        }

        boolean esAdmin = usuarioSesion.getRole() == Role.Administrador;
        boolean esDueno = existente.getUserId() == usuarioSesion.getId();

        if (!esAdmin && !esDueno){
            return false;
        }
        itemDAO.actualizarItem(item);
        return true;
    }

    public boolean eliminarItem(int itemId, User usuarioSesion){
        if (usuarioSesion == null || itemId <= 0){
            return false;
        }

        Item existente = itemDAO.buscarPorID(itemId);

        if (existente == null){
            return false;
        }

        boolean esAdmin = usuarioSesion.getRole() == Role.Administrador;
        boolean esDueno = existente.getUserId() == usuarioSesion.getId();

        if (!esAdmin && !esDueno){
            return false;
        }

        itemDAO.eliminarItem(itemId);
        return true;
    }

    public Item buscarPorId (int id){
        if (id <= 0){
            return null;
        }
        return itemDAO.buscarPorID(id);
    }

    public List<Item> listarTodos() {
        return itemDAO.listarItems();
    }

    public List<Item> listarPorUsuario(int userId) {
        if (userId <= 0) {
            return java.util.Collections.emptyList();
        }
        return itemDAO.listarItemsPorUsuario(userId);
    }

    public List<Item> buscarItems(String texto) {
        if (texto == null || texto.trim().isEmpty()) {
            return listarTodos();
        }

        return itemDAO.buscarItems(texto.trim());
    }
    public List<Item> buscarItemsConFiltros(String texto, String tipo) {
        return itemDAO.buscarItemsConFiltros(texto, tipo);
    }
}
