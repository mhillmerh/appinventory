package com.AppIntentory.model;

public class Item {
    private int id;
    private String title;
    private ItemType type;
    private int volume;
    private String author;
    private String editorial;
    private String image;
    private int userId;

    public Item(int id, String title, ItemType type, int volume, String author, String editorial, String image, int userId) {
        this.id = id;
        this.title = title;
        this.type = type;
        this.volume = volume;
        this.author = author;
        this.editorial = editorial;
        this.image = image;
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getVolume() {
        return volume;
    }

    public void setVolume(int volume) {
        this.volume = volume;
    }

    public ItemType getType() {
        return type;
    }

    public void setType(ItemType type) {
        this.type = type;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getEditorial() {
        return editorial;
    }

    public void setEditorial(String editorial) {
        this.editorial = editorial;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
