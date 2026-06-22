<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nuevoUsuario.aspx.cs" Inherits="proyecto_frontend.Pages.nuevoUsuario" MasterPageFile="~/AppShell.Master" Title="Usuario" %>
<asp:Content ID="PageHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/CSS/nuevoUsuario.css") %>" />
</asp:Content>

<asp:Content ID="PageBody" ContentPlaceHolderID="BodyContent" runat="server">
    <main
        class="main-content"
        id="main-content"
        data-api-base="https://localhost:44316/usuarios.asmx"
        data-mode="<%= string.IsNullOrWhiteSpace(Request.QueryString["id"]) ? "create" : "edit" %>"
        data-user-id="<%= Request.QueryString["id"] ?? string.Empty %>">

        <div class="page-header">
            <div class="page-header-left">
                <a class="btn-back" href="usuarios.aspx" aria-label="Volver a usuarios">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                        <path d="M19 12H5M12 5L5 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                    </svg>
                    Volver
                </a>
                <div>
                    <h1 class="page-title" id="litPageTitle"><%= string.IsNullOrWhiteSpace(Request.QueryString["id"]) ? "Nuevo usuario" : "Editar usuario" %></h1>
                    <p class="page-subtitle" id="litPageSubtitle"><%= string.IsNullOrWhiteSpace(Request.QueryString["id"]) ? "Completa los datos para crear una nueva cuenta de usuario" : "Actualiza la información principal de la cuenta" %></p>
                </div>
            </div>
        </div>

        <div class="validation-summary" id="validationSummary" style="display: none;"></div>

        <div class="form-layout">
            <div class="form-card">
                <div class="form-card-header">
                    <div class="form-card-header-icon" aria-hidden="true">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none">
                            <path d="M20 21V19C20 17.3 18.7 16 17 16H7C5.3 16 4 17.3 4 19V21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="1.5" />
                        </svg>
                    </div>
                    <div>
                        <div class="form-card-title">Información del usuario</div>
                        <div class="form-card-subtitle">Los campos marcados con * son obligatorios</div>
                    </div>
                </div>

                <div class="form-body">
                    <div class="form-grid">
                        <div class="field">
                            <label class="field-label" for="txtNombre">
                                Nombre <span class="field-required" aria-label="obligatorio">*</span>
                            </label>
                            <div class="field-hint">Primer nombre del usuario</div>
                            <div class="field-wrap">
                                <span class="field-icon" aria-hidden="true">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                        <path d="M20 21V19C20 17.3 18.7 16 17 16H7C5.3 16 4 17.3 4 19V21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                        <circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="1.5" />
                                    </svg>
                                </span>
                                <input id="txtNombre" class="field-input" type="text" placeholder="Ej. Carlos" maxlength="100" autocomplete="off" />
                            </div>
                        </div>

                        <div class="field">
                            <label class="field-label" for="txtApellido">
                                Apellido <span class="field-required" aria-label="obligatorio">*</span>
                            </label>
                            <div class="field-hint">Apellido principal del usuario</div>
                            <div class="field-wrap">
                                <span class="field-icon" aria-hidden="true">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                        <path d="M20 21V19C20 17.3 18.7 16 17 16H7C5.3 16 4 17.3 4 19V21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                        <circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="1.5" />
                                    </svg>
                                </span>
                                <input id="txtApellido" class="field-input" type="text" placeholder="Ej. Alvarado" maxlength="100" autocomplete="off" />
                            </div>
                        </div>

                        <div class="field">
                            <label class="field-label" for="txtCorreo">
                                Correo electrónico <span class="field-required" aria-label="obligatorio">*</span>
                            </label>
                            <div class="field-hint">Correo principal que se usará para iniciar sesión</div>
                            <div class="field-wrap">
                                <span class="field-icon" aria-hidden="true">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                        <rect x="4" y="6" width="16" height="12" rx="2" stroke="currentColor" stroke-width="1.5" />
                                        <path d="M5 8L12 13L19 8" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
                                    </svg>
                                </span>
                                <input id="txtCorreo" class="field-input" type="email" placeholder="Ej. carlos.alvarado@empresa.com" maxlength="50" autocomplete="email" />
                            </div>
                        </div>

                        <div class="field">
                            <label class="field-label" for="ddlRol">
                                Rol <span class="field-required" aria-label="obligatorio">*</span>
                            </label>
                            <div class="field-hint">Define el nivel de acceso dentro del sistema</div>
                            <div class="field-wrap">
                                <span class="field-icon" aria-hidden="true">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                        <path d="M12 12C14.7614 12 17 9.76142 17 7C17 4.23858 14.7614 2 12 2C9.23858 2 7 4.23858 7 7C7 9.76142 9.23858 12 12 12Z" stroke="currentColor" stroke-width="1.5" />
                                        <path d="M4 21C4 17.6863 7.13401 15 11 15H13C16.866 15 20 17.6863 20 21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                    </svg>
                                </span>
                                <select id="ddlRol" class="field-select">
                                    <option value="">Selecciona un rol</option>
                                    <option value="Administrador">Administrador</option>
                                    <option value="Usuario">Usuario</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="field">
                        <label class="field-label" for="txtContrasena">
                            Contraseña <span class="field-required" aria-label="obligatorio">*</span>
                        </label>
                        <div class="field-hint" id="litPasswordHint">Usa una contraseña segura de al menos 8 caracteres.</div>
                        <div class="field-wrap password-wrap">
                            <span class="field-icon" aria-hidden="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                    <rect x="5" y="11" width="14" height="10" rx="2" stroke="currentColor" stroke-width="1.5" />
                                    <path d="M8 11V8C8 5.79086 9.79086 4 12 4C14.2091 4 16 5.79086 16 8V11" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                </svg>
                            </span>
                            <input id="txtContrasena" class="field-input password-input" type="password" placeholder="••••••••" maxlength="40" autocomplete="new-password" />
                            <button type="button" class="btn-password-toggle" id="btnTogglePassword" aria-label="Mostrar u ocultar contraseña">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                    <path d="M2 12C4.5 7.5 8 5 12 5C16 5 19.5 7.5 22 12C19.5 16.5 16 19 12 19C8 19 4.5 16.5 2 12Z" stroke="currentColor" stroke-width="1.5" />
                                    <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="1.5" />
                                </svg>
                            </button>
                        </div>
                    </div>

                    <%--<div class="field">
                        <label class="field-label" for="chkEstado">Estado</label>
                        <div class="field-hint">Los usuarios inactivos no podrán iniciar sesión.</div>
                        <label style="display: flex; align-items: center; gap: 10px; font-size: 14px; color: var(--clr-gray-700); margin-top: 10px;">
                            <input type="checkbox" id="chkEstado" checked="checked" />
                            Usuario activo
                        </label>
                    </div>--%>
                </div>

                <div class="required-legend">
                    <span class="required-mark">*</span> Campos obligatorios
                </div>

                <div class="form-actions">
                    <a class="btn-cancel" href="usuarios.aspx">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                            <path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                        </svg>
                        Cancelar
                    </a>
                    <button id="btnGuardar" type="button" class="btn-save">Guardar usuario</button>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="PageScripts" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ResolveUrl("~/JS/nuevoUsuario.js") %>"></script>
</asp:Content>
