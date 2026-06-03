<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nuevaCategoria.aspx.cs" Inherits="proyecto_frontend.Pages.nuevaCategoria" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Nueva categoría</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="~/CSS/nuevaCategoria.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-shell">

            <header class="topbar">
                <button class="tb-menu-btn" id="menuBtn" aria-label="Abrir menú de navegación" aria-expanded="false" aria-controls="sidebar">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                        <path d="M3 12H21" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                        <path d="M3 6H21" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                        <path d="M3 18H21" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                    </svg>
                </button>
                <div class="tb-logo" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <rect x="2" y="2" width="9" height="9" rx="2" fill="white" opacity=".95" />
                        <rect x="13" y="2" width="9" height="9" rx="2" fill="white" opacity=".6" />
                        <rect x="2" y="13" width="9" height="9" rx="2" fill="white" opacity=".6" />
                        <rect x="13" y="13" width="9" height="9" rx="2" fill="white" opacity=".3" />
                    </svg>
                </div>
                <span class="tb-brand">InvControl Pro</span>
                <div class="tb-spacer"></div>
                <div class="tb-status" role="status" aria-label="Estado del sistema: en línea">
                    <div class="tb-status-dot"></div>
                    En línea
                </div>
                <div class="tb-avatar" title="Carlos Admin" aria-label="Usuario: Carlos Admin">CA</div>
            </header>

            <div class="body-wrap">
                <div class="sidebar-overlay" id="sidebarOverlay" aria-hidden="true"></div>

                <nav class="sidebar" id="sidebar" aria-label="Navegación principal">
                    <div class="nav-section">
                        <span class="nav-section-label">Principal</span>
                        <a class="nav-item" href="Dashboard.aspx">
                            <span class="nav-icon" aria-hidden="true">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <rect x="3" y="3" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <rect x="14" y="3" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <rect x="3" y="14" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <rect x="14" y="14" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </span>
                            <span class="nav-text">Dashboard</span>
                        </a>
                    </div>
                    <div class="nav-section">
                        <span class="nav-section-label">Inventario</span>
                        <a class="nav-item" href="Productos.aspx">
                            <span class="nav-icon" aria-hidden="true">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <path d="M8 6V4H16V6" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </span>
                            <span class="nav-text">Productos</span>
                        </a>
                        <a class="nav-item active" href="categorias.aspx" aria-current="page">
                            <span class="nav-icon" aria-hidden="true">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 6L10 4L20 6L22 12L20 18L14 20L4 18L2 12L4 6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </span>
                            <span class="nav-text">Categorías</span>
                        </a>
                    </div>
                    <hr class="nav-divider" />
                    <div class="nav-section">
                        <span class="nav-section-label">Movimientos</span>
                        <a class="nav-item" href="Bitacora.aspx">
                            <span class="nav-icon" aria-hidden="true">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <path d="M8 6V4H16V6" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <path d="M8 10H16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                    <path d="M8 14H14" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                </svg>
                            </span>
                            <span class="nav-text">Bitácora</span>
                        </a>
                    </div>
                    <hr class="nav-divider" />
                    <div class="nav-section">
                        <span class="nav-section-label">Sistema</span>
                        <a class="nav-item" href="Login.aspx">
                            <span class="nav-icon" aria-hidden="true">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M15 3H19C20.1 3 21 3.9 21 5V19C21 20.1 20.1 21 19 21H15" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <path d="M10 17L15 12L10 7" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                    <path d="M15 12H3" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                </svg>
                            </span>
                            <span class="nav-text">Cerrar sesión</span>
                        </a>
                    </div>
                </nav>

                <main class="main-content" id="main-content">

                    <div class="page-header">
                        <div class="page-header-left">
                            <a class="btn-back" href="categorias.aspx" aria-label="Volver a Categorías">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path d="M19 12H5M12 5L5 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                </svg>
                                Volver
                            </a>
                            <div>
                                <h1 class="page-title">
                                    <asp:Literal ID="litPageTitle" runat="server" Text="Nueva categoría" />
                                </h1>
                                <p class="page-subtitle">Completa la información de la categoría</p>
                            </div>
                        </div>
                    </div>

                    <asp:ValidationSummary
                        ID="vsSummary"
                        runat="server"
                        CssClass="validation-summary"
                        HeaderText="⚠ Por favor corrige los siguientes errores:"
                        ValidationGroup="vgCategoria"
                        Style="margin-bottom: 16px;" />

                    <asp:Panel ID="pnlForm" runat="server" DefaultButton="btnGuardar">
                        <div class="form-layout">

                            <!-- ── columna principal ── -->
                            <div class="form-card">
                                <div class="form-card-header">
                                    <div class="form-card-header-icon" aria-hidden="true">
                                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M4 6L10 4L20 6L22 12L20 18L14 20L4 18L2 12L4 6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                            <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                        </svg>
                                    </div>
                                    <div>
                                        <div class="form-card-title">Información de la categoría</div>
                                        <div class="form-card-subtitle">Los campos marcados con * son obligatorios</div>
                                    </div>
                                </div>

                                <div class="form-body">

                                    <!-- Nombre -->
                                    <div class="field">
                                        <label class="field-label" for="<%= txtNombre.ClientID %>">
                                            Nombre <span class="field-required" aria-label="obligatorio">*</span>
                                        </label>
                                        <div class="field-hint">Nombre único para identificar la categoría</div>
                                        <div class="field-wrap">
                                            <span class="field-icon" aria-hidden="true">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M4 6L10 4L20 6L22 12L20 18L14 20L4 18L2 12L4 6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                    <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                </svg>
                                            </span>
                                            <asp:TextBox ID="txtNombre" runat="server" CssClass="field-input"
                                                placeholder="Ej. Electrónica, Papelería, Repuestos..." MaxLength="80" autocomplete="off" />
                                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                                                ControlToValidate="txtNombre"
                                                ErrorMessage="El nombre de la categoría es obligatorio."
                                                Display="None" ValidationGroup="vgCategoria" />
                                            <asp:RegularExpressionValidator ID="revNombre" runat="server"
                                                ControlToValidate="txtNombre"
                                                ValidationExpression="^.{2,80}$"
                                                ErrorMessage="El nombre debe tener entre 2 y 80 caracteres."
                                                Display="None" ValidationGroup="vgCategoria" />
                                        </div>
                                    </div>

                                    <!-- Descripción -->
                                    <div class="field">
                                        <label class="field-label" for="<%= txtDescripcion.ClientID %>">Descripción</label>
                                        <div class="field-hint">Breve descripción de los productos que incluye esta categoría</div>
                                        <div class="field-wrap">
                                            <span class="textarea-icon" aria-hidden="true">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M17 4H7C5.89543 4 5 4.89543 5 6V18C5 19.1046 5.89543 20 7 20H17C18.1046 20 19 19.1046 19 18V6C19 4.89543 18.1046 4 17 4Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                    <path d="M8 8H16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                                    <path d="M8 12H14" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                                    <path d="M8 16H12" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                                </svg>
                                            </span>
                                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="field-textarea"
                                                TextMode="MultiLine" placeholder="Describe brevemente el tipo de productos de esta categoría..."
                                                MaxLength="200" Rows="3" />
                                        </div>
                                        <div class="char-counter" id="charCounter">0 / 200</div>
                                    </div>
                                </div>

                                <div class="required-legend" style="font-size: 12px; color: var(--clr-gray-400); padding: 0 24px 14px">
                                    <span style="color: var(--clr-red-500)">*</span> Campos obligatorios
                                </div>

                                <div class="form-actions">
                                    <a class="btn-cancel" href="categorias.aspx">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                            <path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                        </svg>
                                        Cancelar
                                    </a>
                                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar categoría"
                                        CssClass="btn-save" ValidationGroup="vgCategoria" OnClick="btnGuardar_Click" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </main>
            </div>
        </div>
    </form>
    <script src="JS/nuevaCategoria.js"></script>
</body>
</html>
