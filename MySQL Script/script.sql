CREATE DATABASE IF NOT EXISTS AppInventario;
USE AppInventario;


CREATE TABLE users (
    id int AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role enum('administrador','Usuario') default 'Usuario',
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE items(
    id int AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    type ENUM('Libros', 'comics', 'Mangas') NOT NULL,
    volume int NOT NULL,
    author VARCHAR(100) NOT NULL,
    editorial VARCHAR(100) NOT NULL,
    image VARCHAR(500) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    user_id int NOT NULL,

    CONSTRAINT fk_items_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX idx_items_user ON items(user_id);

INSERT INTO users (name, email, password, role, active)
VALUES
    ("Maximilinano Hillmer", "m.hillmerh@gmail.com", "$2a$10$D7H5A7edJ4/m98b7IEvF/u0s/Wu20mkhvS4ieLSqmPPYVlm5G6V6y", "Administrador", true),
    ("Usuario Prueba", "mail.prueba@test.com", "$2a$10$D7H5A7edJ4/m98b7IEvF/u0s/Wu20mkhvS4ieLSqmPPYVlm5G6V6y", "Usuario", true);

INSERT INTO items (title, type, volume, author, editorial, image, user_id)
VALUES
    ("GREEN LANTERNS Renace", "Comics",1, "Geoff Johns", "SD", "sdasdasdasfffafaf", 1),
    ("My Sexy cosplay doll", "Mangas",1, "Shinichi Fukuda", "Panini","fadsfasdfasdfasdf", 2),
    ("El señor de los anillos. La comunidad del anillo", "Libros", 1, "J.R.R Tolkien", "Minutauro", "asdafafafafafafa", 2),
    ("Dune", "Libros", 1, "Frank Herbert", "Debolsillo", "asdasfafafafa", 1);

