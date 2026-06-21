<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="proyecto_frontend.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="<%= ResolveUrl("~/CSS/login.css") %>" />
    <title>Iniciar sesión</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
</head>

<body>
    <form id="form1">
        <div class="page-shell">
            <div class="login-card" role="main">

                <div class="panel-brand" aria-hidden="true">
                    <div class="brand-top">
                        <div class="logo-mark">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <rect x="2" y="2" width="9" height="9" rx="2" fill="white" opacity=".95" />
                                <rect x="13" y="2" width="9" height="9" rx="2" fill="white" opacity=".6" />
                                <rect x="2" y="13" width="9" height="9" rx="2" fill="white" opacity=".6" />
                                <rect x="13" y="13" width="9" height="9" rx="2" fill="white" opacity=".3" />
                            </svg>
                        </div>

                        <div class="brand-name">InvControl Pro</div>
                        <div class="brand-tagline">Plataforma Web de Inventario</div>
                    </div>

                    <div class="brand-body">
                        <h1 class="hero-title">Controla tu inventario con precisión y velocidad</h1>
                        <p class="hero-desc">
                            Gestión de productos, stock, movimientos y reportes en tiempo real
                            para pequeñas y medianas empresas.
                        </p>

                        <div class="stats-row">
                            <div class="stat-item">
                                <span class="stat-value">99.9%</span>
                                <span class="stat-label">Uptime</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-value">ISO 27001</span>
                                <span class="stat-label">Seguridad</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-value">24 / 7</span>
                                <span class="stat-label">Soporte</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel-form">
                    <h2 class="form-heading">Iniciar sesión</h2>
                    <p class="form-subheading">Ingresa tus credenciales para continuar</p>

                    <div id="loginMessage" class="validation-summary" style="display:none;"></div>

                    <div id="pnlLogin">

                        <div class="field">
                            <label class="field-label" for="txtEmail">Correo electrónico</label>
                            <div class="field-wrap">
                                <svg class="field-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"
                                    stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <rect x="2" y="4" width="20" height="16" rx="2" />
                                    <path d="M2 8l10 6 10-6" />
                                </svg>

                                <input
                                    id="txtEmail"
                                    class="field-input"
                                    type="email"
                                    placeholder="usuario@empresa.com"
                                    maxlength="50"
                                    autocomplete="email" />
                            </div>
                        </div>

                        <div class="field">
                            <label class="field-label" for="txtPassword">Contraseña</label>
                            <div class="field-wrap">
                                <svg class="field-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"
                                    stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <rect x="3" y="11" width="18" height="11" rx="2" />
                                    <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                                </svg>

                                <input
                                    id="txtPassword"
                                    class="field-input field-input-with-toggle"
                                    type="password"
                                    placeholder="••••••••"
                                    maxlength="100"
                                    autocomplete="current-password" />

                                <button
                                    class="btn-pw-toggle"
                                    type="button"
                                    id="toggleLoginPassword"
                                    aria-label="Mostrar contraseña"
                                    aria-pressed="false"
                                    data-target="txtPassword">
                                    <svg class="pw-icon pw-icon-open" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                        stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
                                        <circle cx="12" cy="12" r="3" />
                                    </svg>
                                    <svg class="pw-icon pw-icon-closed" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                        stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" style="display: none">
                                        <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94" />
                                        <path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19" />
                                        <line x1="1" y1="1" x2="23" y2="23" />
                                    </svg>
                                </button>
                            </div>
                        </div>

                        <div class="row-between">
                            <label class="checkbox-label">
                                <input id="chkRemember" type="checkbox" />
                                Recordarme
                            </label>

                            <a href="restablecerContrasena.aspx" class="link-forgot">
                                ¿Olvidaste tu contraseña?
                            </a>
                        </div>

                        <button id="btnLogin" type="submit" class="btn-submit">
                            Ingresar al sistema
                        </button>

                    </div>
                </div>

            </div>
        </div>
    </form>

    <script src="<%= ResolveUrl("~/JS/login.js") %>"></script>
</body>
</html>



