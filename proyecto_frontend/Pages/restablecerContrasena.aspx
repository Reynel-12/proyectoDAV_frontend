<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="restablecerContrasena.aspx.cs" Inherits="proyecto_frontend.Pages.restablecerContrasena" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="~/CSS/restablecerContrasena.css" />
    <title>Restablecer contraseña</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">

            <div class="brand-header">
                <div class="brand-logo" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="2" y="2" width="9" height="9" rx="2" fill="white" opacity=".95" />
                        <rect x="13" y="2" width="9" height="9" rx="2" fill="white" opacity=".6" />
                        <rect x="2" y="13" width="9" height="9" rx="2" fill="white" opacity=".6" />
                        <rect x="13" y="13" width="9" height="9" rx="2" fill="white" opacity=".3" />
                    </svg>
                </div>
                <div class="brand-name">InvControl Pro</div>
                <div class="brand-tagline">Plataforma Web de Inventario</div>
            </div>

            <asp:Panel ID="pnlForm" runat="server" CssClass="reset-card" DefaultButton="btnGuardarContrasena">
                <div class="card-header">
                    <div class="card-header-icon blue" aria-hidden="true">
                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="3" y="11" width="18" height="11" rx="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke="currentColor" stroke-width="1.5" fill="none" />
                        </svg>
                    </div>
                    <h1 class="card-title">Restablecer contraseña</h1>
                    <p class="card-subtitle">
                        Ingresa tu correo electrónico y define una nueva contraseña para actualizar el acceso a tu cuenta.
                    </p>
                </div>

                <div class="card-body">
                    <asp:ValidationSummary
                        ID="vsSummary"
                        runat="server"
                        CssClass="validation-summary"
                        HeaderText="Por favor corrige los siguientes errores:"
                        ValidationGroup="vgReset"
                        DisplayMode="BulletList" />

                    <asp:Panel ID="pnlError" runat="server" Visible="false">
                        <div class="alert error" role="alert">
                            <span class="alert-icon" aria-hidden="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    <path d="M12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </span>
                            <asp:Literal ID="litError" runat="server" />
                        </div>
                    </asp:Panel>

                    <div class="field">
                        <label class="field-label" for="<%= txtCorreo.ClientID %>">
                            Correo electrónico <span class="field-required" aria-label="obligatorio">*</span>
                        </label>
                        <div class="field-wrap">
                            <svg class="field-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="2" y="4" width="20" height="16" rx="2" />
                                <path d="M2 8l10 6 10-6" />
                            </svg>
                            <asp:TextBox
                                ID="txtCorreo"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="field-input no-right-icon"
                                TextMode="Email"
                                placeholder="usuario@empresa.com"
                                MaxLength="150"
                                autocomplete="email" />
                            <asp:RequiredFieldValidator
                                ID="rfvCorreo"
                                runat="server"
                                ControlToValidate="txtCorreo"
                                ErrorMessage="El correo electrónico es obligatorio."
                                Display="None"
                                ValidationGroup="vgReset" />
                            <asp:RegularExpressionValidator
                                ID="revCorreo"
                                runat="server"
                                ControlToValidate="txtCorreo"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                ErrorMessage="Ingresa un correo electrónico válido."
                                Display="None"
                                ValidationGroup="vgReset" />
                        </div>
                    </div>

                    <div class="field">
                        <label class="field-label" for="<%= txtNuevaContrasena.ClientID %>">
                            Nueva contraseña <span class="field-required" aria-label="obligatorio">*</span>
                        </label>
                        <div class="field-wrap">
                            <svg class="field-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="3" y="11" width="18" height="11" rx="2" />
                                <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                            </svg>
                            <asp:TextBox
                                ID="txtNuevaContrasena"
                                runat="server"
                                ClientIDMode="Static"
                                CssClass="field-input"
                                TextMode="Password"
                                placeholder="Mínimo 8 caracteres"
                                MaxLength="100"
                                autocomplete="new-password" />
                            <button class="btn-pw-toggle" type="button"
                                id="togglePw1"
                                aria-label="Mostrar contraseña"
                                aria-pressed="false"
                                data-target="<%= txtNuevaContrasena.ClientID %>">
                                <svg id="eyeOpen1" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" />
                                    <circle cx="12" cy="12" r="3" />
                                </svg>
                                <svg id="eyeClosed1" xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" style="display: none">
                                    <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94" />
                                    <path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19" />
                                    <line x1="1" y1="1" x2="23" y2="23" />
                                </svg>
                            </button>
                            <asp:RequiredFieldValidator
                                ID="rfvNuevaContrasena"
                                runat="server"
                                ControlToValidate="txtNuevaContrasena"
                                ErrorMessage="La nueva contraseña es obligatoria."
                                Display="None"
                                ValidationGroup="vgReset" />
                            <asp:RegularExpressionValidator
                                ID="revNuevaContrasena"
                                runat="server"
                                ControlToValidate="txtNuevaContrasena"
                                ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$"
                                ErrorMessage="La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial."
                                Display="None"
                                ValidationGroup="vgReset" />
                        </div>

                        <div class="strength-wrap" id="strengthWrap" aria-live="polite" aria-atomic="true">
                            <div class="strength-bars" aria-hidden="true">
                                <div class="strength-bar" id="sb1"></div>
                                <div class="strength-bar" id="sb2"></div>
                                <div class="strength-bar" id="sb3"></div>
                                <div class="strength-bar" id="sb4"></div>
                            </div>
                            <div class="strength-label" id="strengthLabel" aria-label="Fortaleza de la contraseña: "></div>
                        </div>

                        <div class="req-list" role="list" aria-label="Requisitos de la contraseña">
                            <div class="req-item" id="req-len" role="listitem">
                                <div class="req-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </div>
                                <span>8 caracteres mínimo</span>
                            </div>
                            <div class="req-item" id="req-upper" role="listitem">
                                <div class="req-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </div>
                                <span>Una mayúscula</span>
                            </div>
                            <div class="req-item" id="req-lower" role="listitem">
                                <div class="req-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </div>
                                <span>Una minúscula</span>
                            </div>
                            <div class="req-item" id="req-num" role="listitem">
                                <div class="req-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </div>
                                <span>Un número</span>
                            </div>
                            <div class="req-item" id="req-special" role="listitem">
                                <div class="req-icon" aria-hidden="true">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </div>
                                <span>Un carácter especial</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card-footer">
                    <asp:Button
                        ID="btnGuardarContrasena"
                        runat="server"
                        ValidationGroup="vgReset"
                        OnClick="btnGuardarContrasena_Click"
                        CssClass="btn-primary"
                        Text="Actualizar contraseña" />

                    <div class="security-badge" role="note">
                        <span class="security-badge-icon" aria-hidden="true">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect x="3" y="11" width="18" height="11" rx="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                <path d="M7 11V7a5 5 0 0 1 10 0v4" stroke="currentColor" stroke-width="1.5" fill="none" />
                            </svg>
                        </span>
                        <span>La contraseña se actualiza directamente desde este formulario y se almacena de forma cifrada.</span>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="reset-card">
                <div class="success-screen">
                    <div class="success-anim" role="img" aria-label="Éxito">
                        <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <path d="M8 12L11 15L16 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                        </svg>
                    </div>
                    <h2 class="success-title">¡Contraseña actualizada!</h2>
                    <p class="success-desc">
                        La contraseña se restableció correctamente. Ya puedes iniciar sesión con tus nuevas credenciales.
                    </p>
                    <asp:Button
                        ID="btnIrAlLogin"
                        runat="server"
                        Text="Ir al inicio de sesión"
                        CssClass="btn-primary"
                        Style="margin-top: 8px; max-width: 300px"
                        CausesValidation="false"
                        OnClick="btnIrAlLogin_Click" />
                </div>
            </asp:Panel>

            <div class="back-to-login">
                <span aria-hidden="true">←</span>
                <a href="login.aspx" aria-label="Volver a la pantalla de inicio de sesión">Volver al inicio de sesión</a>
            </div>

        </div>

        <script src="<%= ResolveUrl("~/JS/restablecerContrasena.js") %>"></script>
    </form>
</body>
</html>
