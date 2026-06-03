<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="nuevaCategoria.aspx.cs" Inherits="proyecto_frontend.Pages.nuevaCategoria" MasterPageFile="~/AppShell.Master" Title="Nueva categoría" %>
<asp:Content ID="PageHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/CSS/nuevaCategoria.css") %>" />
</asp:Content>
<asp:Content ID="PageBody" ContentPlaceHolderID="BodyContent" runat="server">
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
</asp:Content>
<asp:Content ID="PageScripts" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ResolveUrl("~/JS/nuevaCategoria.js") %>"></script>
</asp:Content>

