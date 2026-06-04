<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="proyecto_frontend.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="~/CSS/login.css" />
    <title>Iniciar sesión</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="page-shell">
    <div class="login-card" role="main">

        <!-- ── Panel izquierdo: branding ── -->
        <div class="panel-brand" aria-hidden="true">
            <div class="brand-top">
                <div class="logo-mark">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                        <rect x="2"  y="2"  width="9" height="9" rx="2" fill="white" opacity=".95"/>
                        <rect x="13" y="2"  width="9" height="9" rx="2" fill="white" opacity=".6"/>
                        <rect x="2"  y="13" width="9" height="9" rx="2" fill="white" opacity=".6"/>
                        <rect x="13" y="13" width="9" height="9" rx="2" fill="white" opacity=".3"/>
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

        <!-- ── Panel derecho: formulario ── -->
        <div class="panel-form">
            <h2 class="form-heading">Iniciar sesión</h2>
            <p class="form-subheading">Ingresa tus credenciales para continuar</p>

            <!-- Validation summary (server-side) -->
            <asp:ValidationSummary
                ID="vsSummary"
                runat="server"
                CssClass="validation-summary"
                HeaderText="Por favor corrige los siguientes errores:" />

            <asp:Panel ID="pnlLogin" runat="server" DefaultButton="btnLogin">

                <!-- Campo: correo -->
                <div class="field">
                    <label class="field-label" for="<%= txtEmail.ClientID %>">Correo electrónico</label>
                    <div class="field-wrap">
                        <svg class="field-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"
                             stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <rect x="2" y="4" width="20" height="16" rx="2"/>
                            <path d="M2 8l10 6 10-6"/>
                        </svg>
                        <asp:TextBox
                            ID="txtEmail"
                            runat="server"
                            CssClass="field-input"
                            TextMode="Email"
                            placeholder="usuario@empresa.com"
                            MaxLength="150"
                            autocomplete="email" />
                        <asp:RequiredFieldValidator
                            ID="rfvEmail"
                            runat="server"
                            ControlToValidate="txtEmail"
                            ErrorMessage="El correo electrónico es obligatorio."
                            Display="None"
                            ValidationGroup="vgLogin" />
                        <asp:RegularExpressionValidator
                            ID="revEmail"
                            runat="server"
                            ControlToValidate="txtEmail"
                            ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                            ErrorMessage="Ingresa un correo electrónico válido."
                            Display="None"
                            ValidationGroup="vgLogin" />
                    </div>
                </div>

                <!-- Campo: contraseña -->
                <div class="field">
                    <label class="field-label" for="<%= txtPassword.ClientID %>">Contraseña</label>
                    <div class="field-wrap">
                        <svg class="field-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"
                             stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                            <rect x="3" y="11" width="18" height="11" rx="2"/>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                        </svg>
                        <asp:TextBox
                            ID="txtPassword"
                            runat="server"
                            CssClass="field-input"
                            TextMode="Password"
                            placeholder="••••••••"
                            MaxLength="100"
                            autocomplete="current-password" />
                        <asp:RequiredFieldValidator
                            ID="rfvPassword"
                            runat="server"
                            ControlToValidate="txtPassword"
                            ErrorMessage="La contraseña es obligatoria."
                            Display="None"
                            ValidationGroup="vgLogin" />
                    </div>
                </div>

                <!-- Recordarme + olvidé contraseña -->
                <div class="row-between">
                    <label class="checkbox-label">
                        <asp:CheckBox ID="chkRemember" runat="server" />
                        Recordarme
                    </label>
                    <a href="restablecerContrasena.aspx" class="link-forgot">¿Olvidaste tu contraseña?</a>
                </div>

                <!-- Botón login -->
                <asp:Button
                    ID="btnLogin"
                    runat="server"
                    Text="Ingresar al sistema"
                    CssClass="btn-submit"
                    ValidationGroup="vgLogin"
                    OnClick="btnLogin_Click" />

            </asp:Panel>

        </div>

    </div>
</div>
        </form>
</body>
</html>
