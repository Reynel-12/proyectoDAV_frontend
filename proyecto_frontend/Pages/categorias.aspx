<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="categorias.aspx.cs" Inherits="proyecto_frontend.Pages.categorias" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Categorías - InvControl Pro</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="~/CSS/categorias.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-shell">

            <header class="topbar">
                <button class="tb-menu-btn" id="menuBtn" aria-label="Abrir menú de navegación" aria-expanded="false" aria-controls="sidebar">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                        <path d="M3 12H21" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        <path d="M3 6H21" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        <path d="M3 18H21" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
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
                                    <rect x="3" y="3" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <rect x="14" y="3" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <rect x="3" y="14" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <rect x="14" y="14" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
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
                                    <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <path d="M8 6V4H16V6" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                </svg>
                            </span>
                            <span class="nav-text">Productos</span>
                        </a>
                        <a class="nav-item active" href="Categorias.aspx" aria-current="page">
                            <span class="nav-icon" aria-hidden="true">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 6L10 4L20 6L22 12L20 18L14 20L4 18L2 12L4 6Z" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none"/>
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
                                    <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <path d="M8 6V4H16V6" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <path d="M8 10H16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                    <path d="M8 14H14" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
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
                                    <path d="M15 3H19C20.1 3 21 3.9 21 5V19C21 20.1 20.1 21 19 21H15" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <path d="M10 17L15 12L10 7" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                    <path d="M15 12H3" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                </svg>
                            </span>
                            <span class="nav-text">Cerrar sesión</span>
                        </a>
                    </div>
                </nav>

                <main class="main-content" id="main-content">

                    <!-- Page header -->
                    <div class="page-header">
                        <div>
                            <h1 class="page-title">Categorías</h1>
                            <p class="page-subtitle">
                                <asp:Literal ID="litTotal" runat="server" Text="0" />
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
                                <asp:Literal ID="litTotalKpi" runat="server" Text="0" />
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
                                <asp:Literal ID="litActivasKpi" runat="server" Text="0" />
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
                                <asp:Literal ID="litProductosKpi" runat="server" Text="0" />
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
                        <button class="view-tab active" id="tabCards" role="tab" aria-selected="true" aria-controls="viewCards">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <rect x="4" y="4" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                <rect x="13" y="4" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                <rect x="4" y="13" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                <rect x="13" y="13" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none"/>
                            </svg>
                            Tarjetas
                        </button>
                        <button class="view-tab" id="tabTable" role="tab" aria-selected="false" aria-controls="viewTable">
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
                        <div class="cat-grid" id="catGrid">
                            <asp:Repeater ID="rptCategorias" runat="server">
                                <ItemTemplate>
                                    <div class="cat-card"
                                        data-nombre='<%# Eval("Nombre") %>'
                                        data-activa='<%# Eval("Activa") %>'>

                                        <div class="cat-card-header">
                                            <div class="cat-icon-wrap"
                                                style="background: var(--cat-bg-<%# Eval("ColorIdx") %>); color: var(--cat-clr-<%# Eval("ColorIdx") %>)"
                                                aria-hidden="true">
                                                <%# Eval("Icono") %>
                                            </div>
                                            <div class="cat-card-info">
                                                <div class="cat-name"><%# Eval("Nombre") %></div>
                                                <div class="cat-desc"><%# Eval("Descripcion") %></div>
                                            </div>
                                        </div>

                                        <div class="cat-card-meta">
                                            <div class="meta-chip">
                                                <span class="meta-chip-dot"></span>
                                                <span><strong><%# Eval("CantProductos") %></strong> productos</span>
                                            </div>
                                            <span class="cat-status-pill <%# (bool)Eval("Activa") ? "activa" : "inactiva" %>">
                                                <%# (bool)Eval("Activa") ? "Activa" : "Inactiva" %>
                                            </span>
                                        </div>

                                        <div class="cat-card-footer">
                                            <span class="cat-date">Creada <%# Eval("FechaCreacion", "{0:dd/MM/yyyy}") %></span>
                                            <a class="btn-action edit"
                                                href='EditarCategoria.aspx?id=<%# Eval("Id") %>'
                                                title="Editar <%# Eval("Nombre") %>"
                                                aria-label="Editar categoría <%# Eval("Nombre") %>">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                                </svg>
                                            </a>
                                            <button class="btn-action del"
                                                type="button"
                                                title="Eliminar <%# Eval("Nombre") %>"
                                                aria-label="Eliminar categoría <%# Eval("Nombre") %>"
                                                onclick="openDeleteModal('<%# Eval("Id") %>','<%# Server.HtmlEncode(Eval("Nombre").ToString()) %>','<%# Eval("CantProductos") %>','<%# Eval("Icono") %>','<%# Eval("ColorIdx") %>')">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                                    <path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                                    <path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                                    <path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                                    <path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                                </svg>
                                            </button>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>

                        <!-- Empty state -->
                        <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
                            <div class="empty-icon" aria-hidden="true">
                                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 6L10 4L20 6L22 12L20 18L14 20L4 18L2 12L4 6Z" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                    <circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                </svg>
                            </div>
                            <div class="empty-title">No hay categorías registradas</div>
                            <div class="empty-desc">Crea la primera categoría para organizar tus productos.</div>
                            <a class="btn-new" href="nuevaCategoria.aspx">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                    <path d="M12 4V20M20 12H4" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                                </svg>
                                Crear primera categoría
                            </a>
                        </asp:Panel>
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
                                <tbody id="tableBody">
                                    <asp:Repeater ID="rptCategoriasTable" runat="server">
                                        <ItemTemplate>
                                            <tr data-nombre='<%# Eval("Nombre") %>' data-activa='<%# Eval("Activa") %>'>
                                                <td>
                                                    <div class="td-icon-name">
                                                        <div class="tbl-cat-icon"
                                                            style="background: var(--cat-bg-<%# Eval("ColorIdx") %>); color: var(--cat-clr-<%# Eval("ColorIdx") %>)"
                                                            aria-hidden="true">
                                                            <%# Eval("Icono") %>
                                                        </div>
                                                        <span class="tbl-cat-name"><%# Eval("Nombre") %></span>
                                                    </div>
                                                </td>
                                                <td><span class="tbl-desc" title="<%# Eval("Descripcion") %>"><%# Eval("Descripcion") %></span></td>
                                                <td class="td-center"><strong><%# Eval("CantProductos") %></strong></td>
                                                <td class="td-center">
                                                    <span class="cat-status-pill <%# (bool)Eval("Activa") ? "activa" : "inactiva" %>">
                                                        <%# (bool)Eval("Activa") ? "Activa" : "Inactiva" %>
                                                    </span>
                                                </td>
                                                <td class="td-center"><%# Eval("FechaCreacion", "{0:dd/MM/yyyy}") %></td>
                                                <td class="td-center">
                                                    <div class="action-wrap">
                                                        <a class="btn-action edit"
                                                            href='EditarCategoria.aspx?id=<%# Eval("Id") %>'
                                                            aria-label="Editar <%# Eval("Nombre") %>">
                                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                <path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                                            </svg>
                                                        </a>
                                                        <button class="btn-action del" type="button"
                                                            aria-label="Eliminar <%# Eval("Nombre") %>"
                                                            onclick="openDeleteModal('<%# Eval("Id") %>','<%# Server.HtmlEncode(Eval("Nombre").ToString()) %>','<%# Eval("CantProductos") %>','<%# Eval("Icono") %>','<%# Eval("ColorIdx") %>')">
                                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                                <path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                                                <path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                                                <path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
                                                                <path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                                                <path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none"/>
                                                            </svg>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </main>
            </div>
        </div>

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

        <asp:HiddenField ID="hfDeleteId" runat="server" />
        <asp:Button ID="btnDeleteConfirm" runat="server" Style="display: none" OnClick="btnDeleteConfirm_Click" CausesValidation="false" />

        <div class="toast" id="toast" role="status" aria-live="polite">
            <span class="ti" id="toastIcon"></span>
            <span id="toastMsg"></span>
        </div>
    </form>
    <script src="JS/categorias.js"></script>
</body>
</html>