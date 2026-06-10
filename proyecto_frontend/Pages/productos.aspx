<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="productos.aspx.cs" Inherits="proyecto_frontend.productos" MasterPageFile="~/AppShell.Master" Title="Productos" %>
<asp:Content ID="PageHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/CSS/productos.css") %>" />
</asp:Content>
<asp:Content ID="PageBody" ContentPlaceHolderID="BodyContent" runat="server">
<main class="main-content" id="main-content" data-api-base="https://localhost:44316/productos.asmx">

                    <div class="page-header">
                        <div>
                            <h1 class="page-title">Productos</h1>
                            <p class="page-subtitle">
                                <span id="totalCountLabel">0</span>
                                productos registrados en el sistema
                            </p>
                        </div>
                        <a class="btn-new" href="NuevoProducto.aspx" aria-label="Agregar nuevo producto">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <path d="M12 4V20M20 12H4" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                            </svg>
                            Nuevo producto
                        </a>
                    </div>

                    <div class="toolbar">
                        <div class="search-wrap">
                            <span class="search-icon" aria-hidden="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <circle cx="10" cy="10" r="7" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <path d="M15 15L21 21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                </svg>
                            </span>
                            <input
                                type="search"
                                class="search-input"
                                id="searchInput"
                                placeholder="Buscar por código, categoría o descripción..."
                                aria-label="Buscar productos"
                                autocomplete="off" />
                        </div>

                        <select class="filter-select" id="filterCategoria" aria-label="Filtrar por categoría">
                            <option value="">Todas las categorías</option>
                        </select>

                        <select class="filter-select" id="filterStock" aria-label="Filtrar por estado de stock" style="min-width: 150px">
                            <option value="">Todo el stock</option>
                            <option value="ok">Stock normal</option>
                            <option value="low">Baja existencia</option>
                            <option value="critical">Sin stock</option>
                        </select>

                        <div class="toolbar-right">
                            <span class="results-count" id="resultsCount" aria-live="polite"></span>
                            <button type="button" class="btn-view-toggle active" id="btnTableView" title="Vista tabla" aria-label="Cambiar a vista tabla" aria-pressed="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <rect x="3" y="3" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <rect x="14" y="3" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <rect x="3" y="14" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <rect x="14" y="14" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </button>
                            <button type="button" class="btn-view-toggle" id="btnCardView" title="Vista tarjetas" aria-label="Cambiar a vista tarjetas" aria-pressed="false">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <rect x="4" y="4" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <rect x="13" y="4" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <rect x="4" y="13" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <rect x="13" y="13" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                </svg>
                            </button>
                        </div>
                    </div>

                    <div class="table-card">

                        <div class="table-wrap" id="tableView">
                            <table class="data-table" aria-label="Listado de productos">
                                <thead>
                                    <tr>
                                        <th class="sortable" data-col="codigo" scope="col">Producto
                                            <span class="sort-icon" aria-hidden="true">
                                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M12 4L12 20M12 4L18 10M12 4L6 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                                </svg>
                                            </span>
                                        </th>
                                        <th scope="col">Categoría</th>
                                        <th class="th-center sortable" data-col="existencia" scope="col">Existencia
                                            <span class="sort-icon" aria-hidden="true">
                                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M12 4L12 20M12 4L18 10M12 4L6 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                                </svg>
                                            </span>
                                        </th>
                                        <th class="th-center" scope="col">ISV</th>
                                        <th class="sortable" data-col="preciocompra" scope="col">P. Compra
                                            <span class="sort-icon" aria-hidden="true">
                                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M12 4L12 20M12 4L18 10M12 4L6 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                                </svg>
                                            </span>
                                        </th>
                                        <th class="sortable" data-col="precioventa" scope="col">P. Venta
                                            <span class="sort-icon" aria-hidden="true">
                                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M12 4L12 20M12 4L18 10M12 4L6 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                                </svg>
                                            </span>
                                        </th>
                                        <th class="th-center" scope="col">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tableBody"></tbody>
                            </table>

                            <div id="emptyState" class="empty-state" style="display: none;">
                                <div class="empty-icon" aria-hidden="true">
                                    <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                        <path d="M8 6V4H16V6" stroke="currentColor" stroke-width="1.5" fill="none" />
                                        <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    </svg>
                                </div>
                                <div class="empty-title">No hay productos registrados</div>
                                <div class="empty-desc">Comienza agregando tu primer producto al inventario.</div>
                                <a class="btn-new" href="NuevoProducto.aspx">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                        <path d="M12 4V20M20 12H4" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                    Agregar primer producto
                                </a>
                            </div>
                        </div>

                        <div class="card-grid" id="cardView"></div>

                        <div class="table-footer" id="tableFooterEl">
                            <span class="footer-info" id="footerInfo"></span>
                            <div class="pagination" id="pagination" role="navigation" aria-label="Paginación de productos"></div>
                        </div>
                    </div>

                </main>

        <div class="modal-backdrop" id="deleteModal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
            <div class="modal">
                <div class="modal-header">
                    <div class="modal-icon-wrap" aria-hidden="true">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none" />
                        </svg>
                    </div>
                    <div>
                        <div class="modal-title" id="modalTitle">Eliminar producto</div>
                        <div class="modal-subtitle">Esta acción no se puede deshacer. El producto será eliminado permanentemente del inventario.</div>
                    </div>
                </div>

                <div class="modal-product-ref" id="modalProductRef">
                    <div class="modal-product-ref-img-placeholder" id="modalImgPlaceholder" aria-hidden="true">
                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <rect x="2" y="3" width="20" height="18" rx="2" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <path d="M9 11L6 16H18L15 13L12 15L9 11Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <circle cx="16.5" cy="8.5" r="1.5" fill="currentColor" stroke="currentColor" stroke-width="1" />
                        </svg>
                    </div>
                    <img id="modalProductImg" class="modal-product-ref-img" src="#" alt="" style="display: none" />
                    <div>
                        <div class="modal-product-name" id="modalProductName"></div>
                        <div class="modal-product-code" id="modalProductCode"></div>
                    </div>
                </div>

                <div class="modal-warning" role="alert">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                        <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                        <path d="M12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                    </svg>
                    También se eliminarán los registros de bitácora y movimientos asociados a este producto.
                </div>

                <div class="modal-actions">
                    <button class="btn-modal-cancel" id="btnModalCancel" type="button">Cancelar</button>
                    <button class="btn-modal-delete" id="btnModalDelete" type="button">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                            <path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none" />
                        </svg>
                        Sí, eliminar
                    </button>
                </div>
            </div>
        </div>

        <div class="toast" id="toast" role="status" aria-live="polite">
            <span class="toast-icon" id="toastIcon"></span>
            <span id="toastMsg"></span>
        </div>
</asp:Content>
<asp:Content ID="PageScripts" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ResolveUrl("~/JS/productos.js") %>"></script>
</asp:Content>
