<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="editarProducto.aspx.cs" Inherits="proyecto_frontend.Pages.editarProducto" MasterPageFile="~/AppShell.Master" Title="Editar producto" %>
<asp:Content ID="PageHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/CSS/nuevoProducto.css") %>" />
</asp:Content>
<asp:Content ID="PageBody" ContentPlaceHolderID="BodyContent" runat="server">
<main class="main-content" id="main-content" data-api-base="https://localhost:44316/productos.asmx" data-categorias-api-base="https://localhost:44316/categorias.asmx" data-mode="edit" data-product-id="<%= Request.QueryString["id"] ?? string.Empty %>">

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

                        <div id="formMessage" class="validation-summary" style="display: none; margin: 20px 24px 0;"></div>

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
                                            <div class="field-hint">Codigo actual del producto</div>
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
                                                    ClientIDMode="Static"
                                                    CssClass="field-input has-icon"
                                                    placeholder="1001"
                                                    MaxLength="10"
                                                    TextMode="Number"
                                                    autocomplete="off"
                                                    ReadOnly="true" />
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
                                                    ValidationExpression="^\d+$"
                                                    ErrorMessage="El código debe ser un número entero positivo."
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
                                                    ClientIDMode="Static"
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
                                                    ClientIDMode="Static"
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
                                                    ClientIDMode="Static"
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
                                                    ClientIDMode="Static"
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
                                                    ClientIDMode="Static"
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
                                                    ClientIDMode="Static"
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
                                            ClientIDMode="Static"
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
                            <a class="btn-cancel" href="productos.aspx">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                </svg>
                                Cancelar
                            </a>
                            <asp:Button
                                ID="btnGuardar"
                                runat="server"
                                ClientIDMode="Static"
                                Text="Guardar producto"
                                CssClass="btn-save"
                                ValidationGroup="vgProducto"
                                OnClick="btnGuardar_Click" />
                        </div>

                    </div>
                    <!-- /form-card -->
                </main>
</asp:Content>
<asp:Content ID="PageScripts" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ResolveUrl("~/JS/nuevoProducto.js") %>"></script>
</asp:Content>

