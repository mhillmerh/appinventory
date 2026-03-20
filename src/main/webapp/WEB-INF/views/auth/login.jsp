<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - AppInventory</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
</head>
<body class="login-page">

<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <div class="login-icon"> 📚 </div>
            <h1>AppInventory</h1>
            <p>Inicia sesión para continuar</p>
        </div>
        <% String error = (String) request.getAttribute("error");%>
        <% if (error != null) { %>
            <div class="alert alert-error">
                <%= error %>
            </div>
        <% } %>

        <% String success = (String) request.getAttribute("success"); %>
        <% if (success != null) { %>
            <div class="alert alert-success">
                <%= success %>
            </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="post">
            <div class="form-group">
                <label for="email">Correo electrónico</label>
                <input type="email" id="email" name="email" placeholder="ejemplo@correo.com" requiered>
            </div>

            <div class="form-group">
                <label for="password">Contraseña</label>
                <input type="password" id="password" name="password" placeholder="ingresa tu contraseña" requiered>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary btn-full">Ingresar</button>
            </div>

        </form>
        <p class="login-hint"> ¿no tienes cuenta todavía?
            <a href="<%= request.getContextPath() %>/register">Regístrate aquí</a>
        </p>
    </div>
</div>
</body>
</html>