<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editarProducto.aspx.cs" Inherits="proyecto_frontend.Pages.editarProducto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Editar producto</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="~/CSS/nuevoProducto.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-shell">

            <!-- ── Top Bar ── -->
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

                <!-- ── Sidebar ── -->
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
                        <a class="nav-item active" href="Productos.aspx" aria-current="page">
                            <span class="nav-icon" aria-hidden="true">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <path d="M8 6V4H16V6" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </span>
                            <span class="nav-text">Productos</span>
                        </a>
                        <a class="nav-item" href="categorias.aspx">
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

                <!-- ── Main Content ── -->
                <main class="main-content" id="main-content">

                    <!-- Page header -->
                    <div class="page-header">
                        <div class="page-header-left">
                            <a class="btn-back" href="productos.aspx" aria-label="Volver a productos">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path d="M19 12H5M12 5L5 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                </svg>
                                Volver
                            </a>
                            <div>
                                <h1 class="page-title">Editar producto</h1>
                                <p class="page-subtitle">Completa el formulario para editar un producto</p>
                            </div>
                        </div>
                    </div>

                    <!-- Form card -->
                    <div class="form-card">

                        <div class="form-card-header">
                            <div class="form-card-header-icon" aria-hidden="true">
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <path d="M8 6V4H16V6" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </div>
                            <div>
                                <div class="form-card-title">Información del producto</div>
                                <div class="form-card-subtitle">Todos los campos marcados con * son obligatorios</div>
                            </div>
                        </div>

                        <!-- Validation summary (server-side) -->
                        <asp:ValidationSummary
                            ID="vsSummary"
                            runat="server"
                            CssClass="validation-summary"
                            HeaderText="⚠ Por favor corrige los siguientes errores:"
                            ValidationGroup="vgProducto"
                            DisplayMode="BulletList"
                            Style="margin: 20px 24px 0;" />

                        <asp:Panel ID="pnlForm" runat="server" DefaultButton="btnGuardar">
                            <div class="form-body">

                                <!-- ── Sección 1: Identificación ── -->
                                <div class="form-section">
                                    <div class="form-section-title">Identificación</div>
                                    <div class="field-grid">

                                        <!-- Código -->
                                        <div class="field">
                                            <label class="field-label" for="<%= txtCodigo.ClientID %>">
                                                Código <span class="field-required" aria-label="obligatorio">*</span>
                                            </label>
                                            <div class="field-hint">Identificador único del producto (ej. PROD-001)</div>
                                            <div class="field-wrap">
                                                <span class="field-icon" aria-hidden="true">
                                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M4 4H20V20H4V4Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                        <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                    </svg>
                                                </span>
                                                <asp:TextBox
                                                    ID="txtCodigo"
                                                    runat="server"
                                                    CssClass="field-input has-icon"
                                                    placeholder="PROD-001"
                                                    MaxLength="30"
                                                    autocomplete="off" />
                                                <asp:RequiredFieldValidator
                                                    ID="rfvCodigo"
                                                    runat="server"
                                                    ControlToValidate="txtCodigo"
                                                    ErrorMessage="El código del producto es obligatorio."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                                <asp:RegularExpressionValidator
                                                    ID="revCodigo"
                                                    runat="server"
                                                    ControlToValidate="txtCodigo"
                                                    ValidationExpression="^[A-Za-z0-9\-_]{1,30}$"
                                                    ErrorMessage="El código solo puede contener letras, números, guiones y guiones bajos."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                            </div>
                                        </div>

                                        <!-- Categoría -->
                                        <div class="field">
                                            <label class="field-label" for="<%= ddlCategoria.ClientID %>">
                                                Categoría <span class="field-required" aria-label="obligatorio">*</span>
                                            </label>
                                            <div class="field-hint">Selecciona la categoría del producto</div>
                                            <div class="field-wrap">
                                                <span class="field-icon" aria-hidden="true">
                                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M4 6L10 4L20 6L22 12L20 18L14 20L4 18L2 12L4 6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                        <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                    </svg>
                                                </span>
                                                <asp:DropDownList
                                                    ID="ddlCategoria"
                                                    runat="server"
                                                    CssClass="field-select">
                                                    <asp:ListItem Value="" Text="— Selecciona una categoría —" />
                                                </asp:DropDownList>
                                                <span class="select-arrow" aria-hidden="true">
                                                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                                    </svg>
                                                </span>
                                                <asp:RequiredFieldValidator
                                                    ID="rfvCategoria"
                                                    runat="server"
                                                    ControlToValidate="ddlCategoria"
                                                    InitialValue=""
                                                    ErrorMessage="La categoría es obligatoria."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                            </div>
                                        </div>

                                        <!-- Descripción (full width) -->
                                        <div class="field field-full">
                                            <label class="field-label" for="<%= txtDescripcion.ClientID %>">
                                                Descripción <span class="field-required" aria-label="obligatorio">*</span>
                                            </label>
                                            <div class="field-wrap">
                                                <span class="textarea-icon" aria-hidden="true">
                                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M17 4H7C5.89543 4 5 4.89543 5 6V18C5 19.1046 5.89543 20 7 20H17C18.1046 20 19 19.1046 19 18V6C19 4.89543 18.1046 4 17 4Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                        <path d="M8 8H16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                                        <path d="M8 12H14" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                                        <path d="M8 16H12" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                                    </svg>
                                                </span>
                                                <asp:TextBox
                                                    ID="txtDescripcion"
                                                    runat="server"
                                                    CssClass="field-textarea"
                                                    TextMode="MultiLine"
                                                    placeholder="Describe el producto: características, uso, especificaciones..."
                                                    MaxLength="300"
                                                    Rows="3" />
                                                <asp:RequiredFieldValidator
                                                    ID="rfvDescripcion"
                                                    runat="server"
                                                    ControlToValidate="txtDescripcion"
                                                    ErrorMessage="La descripción del producto es obligatoria."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                            </div>
                                            <div class="field-footer">
                                                <span></span>
                                                <span class="char-counter" id="charCounter">0 / 300</span>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <!-- ── Sección 2: Precios e Impuesto ── -->
                                <div class="form-section">
                                    <div class="form-section-title">Precios e impuesto</div>
                                    <div class="field-grid">

                                        <!-- Precio de compra -->
                                        <div class="field">
                                            <label class="field-label" for="<%= txtPrecioCompra.ClientID %>">
                                                Precio de compra <span class="field-required" aria-label="obligatorio">*</span>
                                            </label>
                                            <div class="field-hint">Costo de adquisición del producto</div>
                                            <div class="field-wrap">
                                                <span class="field-prefix" aria-hidden="true">L</span>
                                                <asp:TextBox
                                                    ID="txtPrecioCompra"
                                                    runat="server"
                                                    CssClass="field-input has-prefix has-suffix"
                                                    TextMode="Number"
                                                    placeholder="0.00"
                                                    autocomplete="off" />
                                                <span class="field-suffix" aria-hidden="true">HNL</span>
                                                <asp:RequiredFieldValidator
                                                    ID="rfvPrecioCompra"
                                                    runat="server"
                                                    ControlToValidate="txtPrecioCompra"
                                                    ErrorMessage="El precio de compra es obligatorio."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                                <asp:RegularExpressionValidator
                                                    ID="revPrecioCompra"
                                                    runat="server"
                                                    ControlToValidate="txtPrecioCompra"
                                                    ValidationExpression="^\d+(\.\d{1,2})?$"
                                                    ErrorMessage="El precio de compra debe ser un número positivo válido."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                            </div>
                                        </div>

                                        <!-- Precio de venta -->
                                        <div class="field">
                                            <label class="field-label" for="<%= txtPrecioVenta.ClientID %>">
                                                Precio de venta <span class="field-required" aria-label="obligatorio">*</span>
                                            </label>
                                            <div class="field-hint">Precio al que se vende al cliente</div>
                                            <div class="field-wrap">
                                                <span class="field-prefix" aria-hidden="true">L</span>
                                                <asp:TextBox
                                                    ID="txtPrecioVenta"
                                                    runat="server"
                                                    CssClass="field-input has-prefix has-suffix"
                                                    TextMode="Number"
                                                    placeholder="0.00"
                                                    autocomplete="off" />
                                                <span class="field-suffix" aria-hidden="true">HNL</span>
                                                <asp:RequiredFieldValidator
                                                    ID="rfvPrecioVenta"
                                                    runat="server"
                                                    ControlToValidate="txtPrecioVenta"
                                                    ErrorMessage="El precio de venta es obligatorio."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                                <asp:RegularExpressionValidator
                                                    ID="revPrecioVenta"
                                                    runat="server"
                                                    ControlToValidate="txtPrecioVenta"
                                                    ValidationExpression="^\d+(\.\d{1,2})?$"
                                                    ErrorMessage="El precio de venta debe ser un número positivo válido."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                            </div>
                                        </div>

                                        <!-- Impuesto -->
                                        <div class="field">
                                            <label class="field-label" for="<%= ddlImpuesto.ClientID %>">
                                                Impuesto (ISV) <span class="field-required" aria-label="obligatorio">*</span>
                                            </label>
                                            <div class="field-hint">Tasa de Impuesto Sobre Ventas aplicable</div>
                                            <div class="field-wrap">
                                                <span class="field-icon" aria-hidden="true">
                                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M12 2V4M12 20V22M4 12H2M6.5 6.5L5 5M17.5 6.5L19 5M6.5 17.5L5 19M17.5 17.5L19 19M22 12H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                                        <circle cx="12" cy="12" r="4" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                    </svg>
                                                </span>
                                                <asp:DropDownList
                                                    ID="ddlImpuesto"
                                                    runat="server"
                                                    CssClass="field-select">
                                                    <asp:ListItem Value="" Text="— Selecciona ISV —" />
                                                    <asp:ListItem Value="0" Text="0% — Exento" />
                                                    <asp:ListItem Value="15" Text="15% — Tasa general" />
                                                    <asp:ListItem Value="18" Text="18% — Tasa especial (bebidas alcohólicas)" />
                                                </asp:DropDownList>
                                                <span class="select-arrow" aria-hidden="true">
                                                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M6 9L12 15L18 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                                    </svg>
                                                </span>
                                                <asp:RequiredFieldValidator
                                                    ID="rfvImpuesto"
                                                    runat="server"
                                                    ControlToValidate="ddlImpuesto"
                                                    InitialValue=""
                                                    ErrorMessage="El impuesto (ISV) es obligatorio."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                            </div>
                                        </div>

                                        <!-- Existencia -->
                                        <div class="field">
                                            <label class="field-label" for="<%= txtExistencia.ClientID %>">
                                                Existencia inicial <span class="field-required" aria-label="obligatorio">*</span>
                                            </label>
                                            <div class="field-hint">Cantidad de unidades disponibles al registrar</div>
                                            <div class="field-wrap">
                                                <span class="field-icon" aria-hidden="true">
                                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                        <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                        <path d="M8 6V4H16V6" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                        <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                    </svg>
                                                </span>
                                                <asp:TextBox
                                                    ID="txtExistencia"
                                                    runat="server"
                                                    CssClass="field-input has-icon has-suffix"
                                                    TextMode="Number"
                                                    placeholder="0"
                                                    autocomplete="off" />
                                                <span class="field-suffix" aria-hidden="true">uds</span>
                                                <asp:RequiredFieldValidator
                                                    ID="rfvExistencia"
                                                    runat="server"
                                                    ControlToValidate="txtExistencia"
                                                    ErrorMessage="La existencia inicial es obligatoria."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                                <asp:RegularExpressionValidator
                                                    ID="revExistencia"
                                                    runat="server"
                                                    ControlToValidate="txtExistencia"
                                                    ValidationExpression="^\d+$"
                                                    ErrorMessage="La existencia debe ser un número entero positivo."
                                                    Display="None"
                                                    ValidationGroup="vgProducto" />
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <!-- ── Sección 3: Fotografía ── -->
                                <div class="form-section">
                                    <div class="form-section-title">Fotografía del producto</div>

                                    <div
                                        class="photo-upload-zone"
                                        id="dropZone"
                                        role="button"
                                        tabindex="0"
                                        aria-label="Zona de carga de fotografía. Haz clic o arrastra una imagen aquí.">

                                        <!-- Input file oculto — el CustomValidator lo leerá -->
                                        <asp:FileUpload
                                            ID="fuFoto"
                                            runat="server"
                                            CssClass="photo-upload-input"
                                            accept=".jpg,.jpeg,.png"
                                            aria-label="Seleccionar fotografía del producto" />

                                        <div class="photo-upload-icon" id="uploadIcon" aria-hidden="true">
                                            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <rect x="2" y="3" width="20" height="18" rx="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                <path d="M9 11L6 16H18L15 13L12 15L9 11Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                <circle cx="16.5" cy="8.5" r="1.5" fill="currentColor" stroke="currentColor" stroke-width="1" />
                                            </svg>
                                        </div>
                                        <div class="photo-upload-title">
                                            <span>Haz clic para seleccionar</span> o arrastra aquí
                                        </div>
                                        <div class="photo-upload-subtitle">Tamaño máximo recomendado: 2 MB</div>
                                        <div class="photo-upload-formats">
                                            <span class="format-pill">.jpg</span>
                                            <span class="format-pill">.jpeg</span>
                                            <span class="format-pill">.png</span>
                                        </div>
                                    </div>

                                    <!-- Preview de imagen -->
                                    <div class="photo-preview-wrap" id="photoPreview" aria-live="polite">
                                        <img id="previewImg" class="photo-preview-img" src="#" alt="Vista previa de la fotografía del producto" />
                                        <div class="photo-preview-info">
                                            <div class="photo-preview-name" id="previewName"></div>
                                            <div class="photo-preview-size" id="previewSize"></div>
                                        </div>
                                        <button
                                            type="button"
                                            class="photo-preview-remove"
                                            id="btnRemovePhoto"
                                            aria-label="Quitar fotografía seleccionada">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                            </svg>
                                        </button>
                                    </div>

                                    <!-- Error de formato (client-side) -->
                                    <div class="photo-error-msg" id="photoErrorMsg" role="alert">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                            <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                            <path d="M12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                        </svg>
                                        Solo se aceptan imágenes en formato <strong>.jpg</strong>, <strong>.jpeg</strong> o <strong>.png</strong>.
                                    </div>

                                    <!-- CustomValidator server-side para extensión -->
                                    <asp:CustomValidator
                                        ID="cvFoto"
                                        runat="server"
                                        ErrorMessage="La fotografía debe ser un archivo .jpg, .jpeg o .png."
                                        Display="None"
                                        ValidationGroup="vgProducto"
                                        OnServerValidate="cvFoto_ServerValidate" />
                                </div>

                            </div>
                        </asp:Panel>

                        <div class="required-legend">
                            <span>*</span> Campos obligatorios
                        </div>

                        <!-- Form actions -->
                        <div class="form-actions">
                            <a class="btn-cancel" href="dashboard.aspx">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                </svg>
                                Cancelar
                            </a>
                            <asp:Button
                                ID="btnGuardar"
                                runat="server"
                                Text="Guardar producto"
                                CssClass="btn-save"
                                ValidationGroup="vgProducto"
                                OnClick="btnGuardar_Click" />
                        </div>

                    </div>
                    <!-- /form-card -->
                </main>
            </div>
        </div>
    </form>
    <script src="JS/nuevoProducto.js"></script>
</body>
</html>
