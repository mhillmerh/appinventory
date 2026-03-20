<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - AppInventory</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
</head>
<body class="login-page">

<div class="login-container">
    <div class="login-card">

        <div class="login-header">
            <div class="login-icon">📝</div>
            <h1>Crear cuenta</h1>
            <p>Registra tu usuario en AppInventory</p>
        </div>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-error">
                <%= error %>
            </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/register" method="post">
            <div class="form-group">
                <label for="name">Nombre</label>
                <input
                        type="text"
                        id="name"
                        name="name"
                        placeholder="Tu nombre completo"
                        required
                >
            </div>

            <div class="form-group">
                <label for="email">Correo electrónico</label>
                <input
                        type="email"
                        id="email"
                        name="email"
                        placeholder="ejemplo@correo.com"
                        required
                >
            </div>

            <div class="form-group">
                <label for="password">Contraseña</label>
                <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Crea una contraseña"
                        required
                >
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary btn-full">Registrarse</button>
            </div>
        </form>

        <p class="login-hint">
            ¿Ya tienes cuenta?
            <a href="<%= request.getContextPath() %>/login">Inicia sesión aquí</a>
        </p>
    </div>
</div>

</body>
</html>