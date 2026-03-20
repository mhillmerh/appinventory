package com.AppIntentory.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3307/AppInventario?useSSL=false&serverTimezone=UTC";
    private static final String USUARIO = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    private static DBConnection instancia;
    private Connection conexion;

    private DBConnection() {
        try {
            Class.forName(DRIVER);

            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);

            System.out.println("✅ Conexión a la base de datos establecida.");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("❌ Driver no encontrado: " + e.getMessage());
        }catch (SQLException e ) {
            throw new RuntimeException("❌ Error al conectarse a la base de datos: " + e.getMessage());
        }
    }

    public static synchronized DBConnection getInstancia() {
        if (instancia == null || estaConexionCerrada()) {
            instancia = new DBConnection();
        }
        return instancia;
    }

    public Connection getconexion() {
        return conexion;
    }

    private static boolean estaConexionCerrada() {
        try {
            return instancia.conexion == null || instancia.conexion.isClosed();
        } catch (SQLException e) {
            return true;
        }
    }

    public static Connection conectar() {
        return getInstancia().getconexion();
    }
}
