<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("usuario") != null) {
        response.sendRedirect(request.getContextPath() + "/user");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>AppInventory - Organiza tu colección</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
</head>
<body>

<section class="landing-hero">
    <h1>AppInventory</h1>
    <p>
        Organiza, visualiza y administra tu colección de libros, cómics y mangas
        desde una sola plataforma, con panel personal, inventario visual y control seguro de tu información.
    </p>

    <div class="landing-actions">
        <a href="<%= request.getContextPath() %>/login" class="btn btn-primary">Iniciar sesión</a>
        <a href="<%= request.getContextPath() %>/register" class="btn btn-outline" style="background:#fff;">Crear cuenta</a>
    </div>
</section>

<main class="main-content">
    <div class="content-wrapper">

        <section class="landing-section">
            <div class="landing-section-title">
                <h2>¿Qué puedes hacer con AppInventory?</h2>
                <p>Una experiencia pensada para mantener tu colección ordenada y fácil de consultar.</p>
            </div>

            <div class="feature-grid">
                <div class="feature-card">
                    <div class="feature-card-icon">📚</div>
                    <h3>Organiza tu colección</h3>
                    <p>Registra libros, cómics y mangas con título, autor, editorial, volumen e imagen.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-card-icon">📊</div>
                    <h3>Visualiza estadísticas</h3>
                    <p>Consulta la distribución de tu colección con tarjetas resumen y gráficos simples.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-card-icon">🔎</div>
                    <h3>Encuentra todo rápido</h3>
                    <p>Busca y filtra tus items para acceder más rápido a lo que necesitas.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-card-icon">🔐</div>
                    <h3>Acceso seguro</h3>
                    <p>Tu cuenta se protege con autenticación y contraseñas almacenadas de forma segura.</p>
                </div>
            </div>
        </section>

        <section class="landing-section">
            <div class="landing-section-title">
                <h2>¿Cómo funciona?</h2>
                <p>Empieza a usar la aplicación en pocos pasos.</p>
            </div>

            <div class="steps-grid">
                <div class="step-card">
                    <div class="step-number">1️⃣</div>
                    <h3>Crea tu cuenta</h3>
                    <p>Regístrate para acceder a tu panel personal y comenzar a construir tu colección.</p>
                </div>

                <div class="step-card">
                    <div class="step-number">2️⃣</div>
                    <h3>Agrega tus items</h3>
                    <p>Ingresa los datos de cada libro, manga o cómic y añade una imagen si quieres.</p>
                </div>

                <div class="step-card">
                    <div class="step-number">3️⃣</div>
                    <h3>Gestiona y consulta</h3>
                    <p>Edita, revisa y visualiza tu inventario de forma cómoda y ordenada.</p>
                </div>
            </div>
        </section>

        <section class="landing-section">
            <div class="landing-section-title">
                <h2>Vista previa de la aplicación</h2>
                <p>Aquí puedes mostrar capturas reales cuando las tengas listas.</p>
            </div>

            <div class="screenshot-grid">
                <div class="screenshot-placeholder">
                    <div>
                        <strong>Dashboard de usuario</strong>
                        Espacio para una captura del panel principal con tarjetas y gráfico.
                    </div>
                </div>

                <div class="screenshot-placeholder">
                    <div>
                        <strong>Inventario visual</strong>
                        Espacio para una captura del inventario con tarjetas e imágenes.
                    </div>
                </div>

                <div class="screenshot-placeholder">
                    <div>
                        <strong>Panel de administración</strong>
                        Espacio para una captura de usuarios, items y métricas del sistema.
                    </div>
                </div>
            </div>
        </section>

        <section class="landing-section">
            <div class="cta-section">
                <h2>Empieza a organizar tu colección hoy</h2>
                <p>
                    Crea tu cuenta o inicia sesión para acceder a tu inventario personal.
                </p>

                <div class="landing-actions">
                    <a href="<%= request.getContextPath() %>/register" class="btn btn-primary">Crear cuenta</a>
                    <a href="<%= request.getContextPath() %>/login" class="btn btn-outline">Ya tengo cuenta</a>
                </div>
            </div>
        </section>

    </div>
</main>

<footer style="text-align:center; padding:24px; color:#777; font-size:0.9rem;">
    © AppInventory - Desarrollado por Maximiliano Hillmer
</footer>

</body>
</html>
