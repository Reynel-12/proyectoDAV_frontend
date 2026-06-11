<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="categorias.aspx.cs" Inherits="proyecto_frontend.Pages.categorias" MasterPageFile="~/AppShell.Master" Title="Categorías" %>
<asp:Content ID="PageHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/CSS/categorias.css") %>" />
</asp:Content>
<asp:Content ID="PageBody" ContentPlaceHolderID="BodyContent" runat="server">
<main class="main-content" id="main-content" data-api-base="https://localhost:44316/categorias.asmx">

                    <!-- Page header -->
                    <div class="page-header">
                        <div>
                            <h1 class="page-title">Categorías</h1>
                            <p class="page-subtitle">
                                <span id="litTotal">0</span>
                                categorías registradas
                            </p>
                        </div>
                        <a class="btn-new" href="nuevaCategoria.aspx" aria-label="Crear nueva categoría">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <path d="M12 4V20M20 12H4" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                            </svg>
                            Nueva categoría
                        </a>
                    </div>

                    <!-- KPI row -->
                    <div class="kpi-row">
                        <div class="kpi-card">
                            <div class="kpi-icon-wrap blue" aria-hidden="true">
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 6L10 4L20 6L22 12L20 18L14 20L4 18L2 12L4 6Z" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                </svg>
                            </div>
                            <div class="kpi-value">
                                <span id="litTotalKpi">0</span>
                            </div>
                            <div class="kpi-label">Total de categorías</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-icon-wrap green" aria-hidden="true">
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                                </svg>
                            </div>
                            <div class="kpi-value">
                                <span id="litActivasKpi">0</span>
                            </div>
                            <div class="kpi-label">Categorías activas</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-icon-wrap amber" aria-hidden="true">
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <path d="M8 6V4H16V6" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                </svg>
                            </div>
                            <div class="kpi-value">
                                <span id="litProductosKpi">0</span>
                            </div>
                            <div class="kpi-label">Productos categorizados</div>
                        </div>
                    </div>

                    <!-- Toolbar -->
                    <div class="toolbar">
                        <div class="search-wrap">
                            <span class="search-icon" aria-hidden="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <circle cx="10" cy="10" r="7" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <path d="M15 15L21 21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                </svg>
                            </span>
                            <input type="search" class="search-input" id="searchInput"
                                placeholder="Buscar categoría..." aria-label="Buscar categoría" autocomplete="off" />
                        </div>
                        <span class="results-count" id="resultsCount" aria-live="polite"></span>
                    </div>

                    <!-- View tabs -->
                    <div class="view-tabs" role="tablist" aria-label="Vista de categorías">
                        <button type="button" class="view-tab active" id="tabCards" role="tab" aria-selected="true" aria-controls="viewCards">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <rect x="4" y="4" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                <rect x="13" y="4" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                <rect x="4" y="13" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                <rect x="13" y="13" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                            </svg>
                            Tarjetas
                        </button>
                        <button type="button" class="view-tab" id="tabTable" role="tab" aria-selected="false" aria-controls="viewTable">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <rect x="3" y="3" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                <rect x="14" y="3" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                <rect x="3" y="14" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                <rect x="14" y="14" width="7" height="7" rx="1" stroke="currentColor" stroke-width="1.5" fill="none"/>
                            </svg>
                            Tabla
                        </button>
                    </div>

                    <!-- CARD VIEW -->
                    <div id="viewCards" role="tabpanel" aria-labelledby="tabCards">
                        <div class="cat-grid" id="catGrid"></div>
                    </div>

                    <!-- TABLE VIEW -->
                    <div class="table-card" id="viewTable" role="tabpanel" aria-labelledby="tabTable">
                        <div class="table-wrap">
                            <table class="data-table" aria-label="Tabla de categorías">
                                <thead>
                                    <tr>
                                        <th scope="col">Categoría</th>
                                        <th scope="col">Descripción</th>
                                        <th class="th-center" scope="col">Productos</th>
                                        <th class="th-center" scope="col">Estado</th>
                                        <th class="th-center" scope="col">Creada</th>
                                        <th class="th-center" scope="col">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody id="tableBody"></tbody>
                            </table>
                        </div>
                    </div>

                </main>

        <!-- Delete modal -->
        <div class="modal-backdrop" id="deleteModal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
            <div class="modal">
                <div class="modal-header">
                    <div class="modal-icon-wrap" aria-hidden="true">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                            <path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                            <path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                            <path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none"/>
                            <path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none"/>
                        </svg>
                    </div>
                    <div>
                        <div class="modal-title" id="modalTitle">Eliminar categoría</div>
                        <div class="modal-subtitle">Esta acción es permanente y no se puede deshacer.</div>
                    </div>
                </div>
                <div class="modal-cat-ref" id="modalCatRef">
                    <div class="modal-cat-icon" id="modalCatIcon" aria-hidden="true"></div>
                    <div>
                        <div class="modal-cat-name" id="modalCatName"></div>
                        <div class="modal-cat-count" id="modalCatCount"></div>
                    </div>
                </div>
                <div class="modal-warning" role="alert">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                        <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        <path d="M12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21Z" stroke="currentColor" stroke-width="1.5" fill="none"/>
                    </svg>
                    Si la categoría tiene productos asignados, deberás reasignarlos antes de eliminarla. Esta acción podría afectar los reportes existentes.
                </div>
                <div class="modal-actions">
                    <button class="btn-modal-cancel" id="btnModalCancel" type="button">Cancelar</button>
                    <button class="btn-modal-delete" id="btnModalDelete" type="button">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                            <path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                            <path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                            <path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                            <path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none"/>
                            <path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none"/>
                        </svg>
                        Sí, eliminar
                    </button>
                </div>
            </div>
        </div>

        <div class="toast" id="toast" role="status" aria-live="polite">
            <span class="ti" id="toastIcon"></span>
            <span id="toastMsg"></span>
        </div>
</asp:Content>
<asp:Content ID="PageScripts" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ResolveUrl("~/JS/categorias.js") %>"></script>
</asp:Content>
