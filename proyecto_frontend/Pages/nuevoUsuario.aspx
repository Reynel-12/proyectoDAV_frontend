<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nuevoUsuario.aspx.cs" Inherits="proyecto_frontend.Pages.nuevoUsuario" MasterPageFile="~/AppShell.Master" Title="Nuevo usuario" %>
<asp:Content ID="PageHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/CSS/nuevoUsuario.css") %>" />
</asp:Content>

<asp:Content ID="PageBody" ContentPlaceHolderID="BodyContent" runat="server">
    <main class="main-content" id="main-content">
        <div class="page-header">
            <div class="page-header-left">
                <a class="btn-back" href="usuarios.aspx" aria-label="Volver a usuarios">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                        <path d="M19 12H5M12 5L5 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                    </svg>
                    Volver
                </a>
                <div>
                    <h1 class="page-title">
                        <asp:Literal ID="litPageTitle" runat="server" Text="Nuevo usuario" />
                    </h1>
                    <p class="page-subtitle">
                        <asp:Literal ID="litPageSubtitle" runat="server" Text="Completa los datos para crear una nueva cuenta de usuario" />
                    </p>
                </div>
            </div>
        </div>

        <asp:ValidationSummary
            ID="vsSummary"
            runat="server"
            CssClass="validation-summary"
            HeaderText="⚠ Por favor corrige los siguientes errores:"
            ValidationGroup="vgUsuario"
            Style="margin-bottom: 16px;" />

        <asp:Panel ID="pnlForm" runat="server" DefaultButton="btnGuardar">
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
                                <label class="field-label" for="<%= txtNombre.ClientID %>">
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
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="field-input" placeholder="Ej. Carlos" MaxLength="60" autocomplete="off" />
                                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="El nombre es obligatorio." Display="None" ValidationGroup="vgUsuario" />
                                </div>
                            </div>

                            <div class="field">
                                <label class="field-label" for="<%= txtApellido.ClientID %>">
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
                                    <asp:TextBox ID="txtApellido" runat="server" CssClass="field-input" placeholder="Ej. Alvarado" MaxLength="60" autocomplete="off" />
                                    <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" ErrorMessage="El apellido es obligatorio." Display="None" ValidationGroup="vgUsuario" />
                                </div>
                            </div>

                            <div class="field">
                                <label class="field-label" for="<%= ddlRol.ClientID %>">
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
                                    <asp:DropDownList ID="ddlRol" runat="server" CssClass="field-select" />
                                    <asp:RequiredFieldValidator ID="rfvRol" runat="server" ControlToValidate="ddlRol" InitialValue="" ErrorMessage="Debes seleccionar un rol." Display="None" ValidationGroup="vgUsuario" />
                                </div>
                            </div>

                            <div class="field">
                                <label class="field-label" for="<%= txtCorreo.ClientID %>">
                                    Correo electrónico <span class="field-required" aria-label="obligatorio">*</span>
                                </label>
                                <div class="field-hint">Será el identificador principal para iniciar sesión</div>
                                <div class="field-wrap">
                                    <span class="field-icon" aria-hidden="true">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                            <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                            <path d="M4 7L12 13L20 7" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
                                        </svg>
                                    </span>
                                    <asp:TextBox ID="txtCorreo" runat="server" CssClass="field-input" TextMode="Email" placeholder="usuario@empresa.com" MaxLength="120" autocomplete="off" />
                                    <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" ControlToValidate="txtCorreo" ErrorMessage="El correo electrónico es obligatorio." Display="None" ValidationGroup="vgUsuario" />
                                    <asp:RegularExpressionValidator ID="revCorreo" runat="server" ControlToValidate="txtCorreo" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ErrorMessage="Ingresa un correo electrónico válido." Display="None" ValidationGroup="vgUsuario" />
                                </div>
                            </div>
                        </div>

                        <div class="field">
                            <label class="field-label" for="<%= txtContrasena.ClientID %>">
                                Contraseña <span class="field-required" aria-label="obligatorio">*</span>
                            </label>
                            <div class="field-hint">
                                <asp:Literal ID="litPasswordHint" runat="server" Text="Usa una contraseña segura de al menos 8 caracteres." />
                            </div>
                            <div class="field-wrap password-wrap">
                                <span class="field-icon" aria-hidden="true">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                        <rect x="5" y="11" width="14" height="10" rx="2" stroke="currentColor" stroke-width="1.5" />
                                        <path d="M8 11V8C8 5.79086 9.79086 4 12 4C14.2091 4 16 5.79086 16 8V11" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                    </svg>
                                </span>
                                    <asp:TextBox ID="txtContrasena" runat="server" ClientIDMode="Static" CssClass="field-input password-input" TextMode="Password" placeholder="••••••••" MaxLength="40" autocomplete="new-password" />
                                <button type="button" class="btn-password-toggle" id="btnTogglePassword" aria-label="Mostrar u ocultar contraseña">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                        <path d="M2 12C4.5 7.5 8 5 12 5C16 5 19.5 7.5 22 12C19.5 16.5 16 19 12 19C8 19 4.5 16.5 2 12Z" stroke="currentColor" stroke-width="1.5" />
                                        <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="1.5" />
                                    </svg>
                                </button>
                                <asp:RequiredFieldValidator ID="rfvContrasena" runat="server" ControlToValidate="txtContrasena" ErrorMessage="La contraseña es obligatoria." Display="None" ValidationGroup="vgUsuario" />
                                <asp:RegularExpressionValidator ID="revContrasena" runat="server" ControlToValidate="txtContrasena" ValidationExpression="^.{8,40}$" ErrorMessage="La contraseña debe tener entre 8 y 40 caracteres." Display="None" ValidationGroup="vgUsuario" />
                            </div>
                        </div>
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
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar usuario" CssClass="btn-save" ValidationGroup="vgUsuario" OnClick="btnGuardar_Click" />
                    </div>
                </div>
            </div>
        </asp:Panel>
    </main>
</asp:Content>

<asp:Content ID="PageScripts" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ResolveUrl("~/JS/nuevoUsuario.js") %>"></script>
</asp:Content>
