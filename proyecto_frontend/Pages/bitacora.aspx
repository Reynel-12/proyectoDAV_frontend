<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bitacora.aspx.cs" Inherits="proyecto_frontend.Pages.bitacora" MasterPageFile="~/AppShell.Master" Title="Bitácora — InvControl Pro" ResponseEncoding="utf-8" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/CSS/bitacora.css") %>" />
</asp:Content>
<asp:Content ID="PageBody" ContentPlaceHolderID="BodyContent" runat="server">
    <main class="main-content" id="main-content" tabindex="-1">

        <!-- Page header -->
        <div class="page-header">
            <div>
                <h1 class="page-title">Bitácora de movimientos</h1>
                <p class="page-subtitle">Historial completo de operaciones realizadas en el sistema</p>
            </div>
            <div class="header-actions">
                <button class="btn-export"
                    id="btnExportCSV"
                    type="button"
                    aria-label="Exportar bitácora completa a formato CSV">
                    <%-- File download icon --%>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" aria-hidden="true" focusable="false">
                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" />
                        <polyline points="7 10 12 15 17 10" />
                        <line x1="12" y1="15" x2="12" y2="3" />
                    </svg>
                    <span>Exportar CSV</span>
                </button>
            </div>
        </div>

        <!-- KPIs -->
        <div class="kpi-row" role="region" aria-label="Resumen de movimientos">

            <div class="kpi-card">
                <div class="kpi-icon-wrap blue" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20" />
                        <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value">
                        <asp:Literal ID="litTotalMovs" runat="server" Text="0" />
                    </div>
                    <div class="kpi-label">Total de movimientos</div>
                </div>
            </div>

            <div class="kpi-card">
                <div class="kpi-icon-wrap green" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <circle cx="12" cy="12" r="10" />
                        <line x1="12" y1="8" x2="12" y2="16" />
                        <line x1="8" y1="12" x2="16" y2="12" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value">
                        <asp:Literal ID="litCreaciones" runat="server" Text="0" />
                    </div>
                    <div class="kpi-label">Creaciones</div>
                </div>
            </div>

            <div class="kpi-card">
                <div class="kpi-icon-wrap blue" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value">
                        <asp:Literal ID="litEdiciones" runat="server" Text="0" />
                    </div>
                    <div class="kpi-label">Ediciones</div>
                </div>
            </div>

            <div class="kpi-card">
                <div class="kpi-icon-wrap red" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <polyline points="3 6 5 6 21 6" />
                        <path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6" />
                        <path d="M10 11v6" />
                        <path d="M14 11v6" />
                        <path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value">
                        <asp:Literal ID="litEliminaciones" runat="server" Text="0" />
                    </div>
                    <div class="kpi-label">Eliminaciones</div>
                </div>
            </div>

            <div class="kpi-card">
                <div class="kpi-icon-wrap cyan" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <line x1="12" y1="5" x2="12" y2="19" />
                        <polyline points="19 12 12 19 5 12" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value">
                        <asp:Literal ID="litEntradas" runat="server" Text="0" />
                    </div>
                    <div class="kpi-label">Entradas de stock</div>
                </div>
            </div>

            <div class="kpi-card">
                <div class="kpi-icon-wrap amber" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <line x1="12" y1="19" x2="12" y2="5" />
                        <polyline points="5 12 12 5 19 12" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value">
                        <asp:Literal ID="litSalidas" runat="server" Text="0" />
                    </div>
                    <div class="kpi-label">Salidas de stock</div>
                </div>
            </div>

            <div class="kpi-card">
                <div class="kpi-icon-wrap purple" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <circle cx="12" cy="12" r="3" />
                        <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value">
                        <asp:Literal ID="litAjustes" runat="server" Text="0" />
                    </div>
                    <div class="kpi-label">Ajustes</div>
                </div>
            </div>

            <div class="kpi-card">
                <div class="kpi-icon-wrap green" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                        <circle cx="12" cy="7" r="4" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value">
                        <asp:Literal ID="litUsuariosActivos" runat="server" Text="0" />
                    </div>
                    <div class="kpi-label">Usuarios activos</div>
                </div>
            </div>

        </div>

        <!-- Filter panel -->
        <section class="filter-card" aria-label="Filtros de búsqueda">
            <div class="filter-row">
                <div class="filter-group">
                    <label class="filter-label" for="fBusqueda">Búsqueda</label>
                    <input type="search"
                        class="filter-input"
                        id="fBusqueda"
                        name="fBusqueda"
                        placeholder="Producto, usuario, descripción..."
                        aria-label="Buscar registros en la bitácora"
                        autocomplete="off" />
                </div>
                <div class="filter-group">
                    <label class="filter-label" for="fOperacion">Operación</label>
                    <select class="filter-select" id="fOperacion" name="fOperacion">
                        <option value="">Todas las operaciones</option>
                        <option value="creacion">Creación</option>
                        <option value="edicion">Edición</option>
                        <option value="eliminacion">Eliminación</option>
                        <option value="entrada">Entrada de stock</option>
                        <option value="salida">Salida de stock</option>
                        <option value="ajuste">Ajuste</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label class="filter-label" for="fUsuario">Usuario</label>
                    <select class="filter-select" id="fUsuario" name="fUsuario">
                        <option value="">Todos los usuarios</option>
                        <asp:Literal ID="litUsuariosOpts" runat="server" />
                    </select>
                </div>
                <div class="filter-group">
                    <label class="filter-label" for="fFechaDesde">Desde</label>
                    <input type="date" class="filter-date" id="fFechaDesde" name="fFechaDesde"
                        aria-label="Fecha de inicio del rango" />
                </div>
                <div class="filter-group">
                    <label class="filter-label" for="fFechaHasta">Hasta</label>
                    <input type="date" class="filter-date" id="fFechaHasta" name="fFechaHasta"
                        aria-label="Fecha de fin del rango" />
                </div>
                <div class="filter-actions">
                    <button class="btn-filter-clear" id="btnClearFilters" type="button">
                        Limpiar filtros
                    </button>
                    <button class="btn-filter-apply" id="btnApplyFilters" type="button">
                        Aplicar filtros
                    </button>
                </div>
            </div>
            <div class="active-filters"
                id="activeFilters"
                style="display: none"
                role="status"
                aria-live="polite"
                aria-label="Filtros activos">
            </div>
        </section>

        <!-- ── TABLE VIEW (desktop/tablet) ── -->
        <section class="table-card" aria-label="Registros de bitácora">
            <div class="table-toolbar">
                <div class="table-toolbar-left">
                    <p class="results-info" id="resultsInfo" role="status" aria-live="polite">
                        Mostrando <strong id="resultsCount">0</strong> registros
                    </p>
                </div>
                <div class="table-toolbar-right">
                    <label for="pageSize" style="font-size: 12px; color: var(--clr-gray-500)">
                        Filas por página:
                    </label>
                    <select class="page-size-select" id="pageSize">
                        <option value="10">10</option>
                        <option value="25" selected>25</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>
                </div>
            </div>

            <div class="table-wrap">
                <table class="data-table" aria-label="Bitácora de movimientos del sistema">
                    <thead>
                        <tr>
                            <th class="sortable" data-col="usuario" scope="col" aria-sort="none">Usuario
                                            <svg class="sort-icon" width="14" height="14" viewBox="0 0 24 24"
                                                fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round"
                                                aria-hidden="true" focusable="false">
                                                <line x1="12" y1="5" x2="12" y2="19" />
                                                <polyline points="19 12 12 19 5 12" />
                                            </svg>
                            </th>
                            <th class="sortable" data-col="fecha" scope="col" aria-sort="none">Fecha / hora
                                            <svg class="sort-icon" width="14" height="14" viewBox="0 0 24 24"
                                                fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round"
                                                aria-hidden="true" focusable="false">
                                                <line x1="12" y1="5" x2="12" y2="19" />
                                                <polyline points="19 12 12 19 5 12" />
                                            </svg>
                            </th>
                            <th scope="col">Operación</th>
                            <th scope="col">Entidad afectada</th>
                            <th scope="col">Valores anteriores / nuevos</th>
                            <th class="th-center" scope="col">Detalle</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <asp:Repeater ID="rptBitacora" runat="server">
                            <ItemTemplate>
                                <tr class="data-row"
                                    data-id='<%# Eval("Id") %>'
                                    data-usuario='<%# Eval("Usuario") %>'
                                    data-fecha='<%# Eval("FechaISO") %>'
                                    data-op='<%# Eval("OperacionCss") %>'
                                    data-entidad='<%# Eval("EntidadNombre") %>'
                                    data-busq='<%# (Eval("Usuario").ToString() + " " + Eval("EntidadNombre").ToString() + " " + Eval("Descripcion").ToString()).ToLower() %>'>

                                    <!-- Usuario -->
                                    <td>
                                        <div class="user-cell">
                                            <div class="user-avatar <%# Eval("AvatarColor") %>"
                                                aria-hidden="true">
                                                <%# Eval("Iniciales") %>
                                            </div>
                                            <span class="user-name"><%# Eval("Usuario") %></span>
                                        </div>
                                    </td>

                                    <!-- Fecha -->
                                    <td>
                                        <div class="date-cell">
                                            <time class="date-main"
                                                datetime='<%# Eval("FechaISO") %>'>
                                                <%# Eval("FechaFormateada") %>
                                            </time>
                                            <span class="date-rel"
                                                data-ts='<%# Eval("FechaISO") %>'
                                                aria-hidden="true"></span>
                                        </div>
                                    </td>

                                    <!-- Operación -->
                                    <td>
                                        <span class="op-pill <%# Eval("OperacionCss") %>">
                                            <span class="op-dot" aria-hidden="true"></span>
                                            <%# Eval("OperacionLabel") %>
                                        </span>
                                    </td>

                                    <!-- Entidad afectada -->
                                    <td>
                                        <div class="entity-cell">
                                            <span class="entity-type"><%# Eval("EntidadTipo") %></span>
                                            <span class="entity-name"
                                                title='<%# Eval("EntidadNombre") %>'>
                                                <%# Eval("EntidadNombre") %>
                                            </span>
                                        </div>
                                    </td>

                                    <!-- Valores previos / nuevos -->
                                    <td>
                                        <div class="vals-preview">
                                            <%# string.IsNullOrEmpty(Eval("ValorAnteriorResumen").ToString())
                                                            ? "<span class=\"val-badge none\">Sin datos previos</span>"
                                                            : $"<span class=\"val-badge prev\" title=\"{Eval("ValorAnteriorResumen")}\">{Eval("ValorAnteriorResumen")}</span>" %>
                                            <span class="val-arrow" aria-label="hacia">&#8594;</span>
                                            <%# string.IsNullOrEmpty(Eval("ValorNuevoResumen").ToString())
                                                            ? "<span class=\"val-badge none\">Sin datos nuevos</span>"
                                                            : $"<span class=\"val-badge next\" title=\"{Eval("ValorNuevoResumen")}\">{Eval("ValorNuevoResumen")}</span>" %>
                                        </div>
                                    </td>

                                    <!-- Detalle -->
                                    <td class="td-center">
                                        <button class="btn-detail"
                                            type="button"
                                            data-row-id='<%# Eval("Id") %>'
                                            onclick="toggleDetail(this, '<%# Eval("Id") %>')"
                                            aria-expanded="false"
                                            aria-controls='detail-<%# Eval("Id") %>'
                                            aria-label='Ver detalle del movimiento #<%# Eval("Id") %>'>
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
                                                stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round"
                                                aria-hidden="true" focusable="false">
                                                <circle cx="11" cy="11" r="8" />
                                                <line x1="21" y1="21" x2="16.65" y2="16.65" />
                                            </svg>
                                            <span>Ver</span>
                                        </button>
                                    </td>
                                </tr>

                                <!-- Inline expanded detail row -->
                                <tr class="detail-row"
                                    id='detail-<%# Eval("Id") %>'
                                    hidden>
                                    <td colspan="6">
                                        <div class="detail-inner">
                                            <div class="detail-panel prev-panel">
                                                <div class="detail-panel-header">Valores anteriores</div>
                                                <div class="detail-panel-body">
                                                    <%# RenderDiffPanelAnterior(Eval("ValoresAnterioresJson").ToString()) %>
                                                </div>
                                            </div>
                                            <div class="detail-panel next-panel">
                                                <div class="detail-panel-header">Valores nuevos</div>
                                                <div class="detail-panel-body">
                                                    <%# RenderDiffPanelNuevo(Eval("ValoresNuevosJson").ToString()) %>
                                                </div>
                                            </div>
                                            <div class="detail-meta">
                                                <div class="detail-meta-item">
                                                    <span class="detail-meta-label">ID de registro:</span>
                                                    <span>#<%# Eval("Id") %></span>
                                                </div>
                                                <div class="detail-meta-item">
                                                    <span class="detail-meta-label">Descripción:</span>
                                                    <span><%# Eval("Descripcion") %></span>
                                                </div>
                                                <div class="detail-meta-item">
                                                    <span class="detail-meta-label">Dirección IP:</span>
                                                    <span><%# Eval("IpAddress") %></span>
                                                </div>
                                                <button class="btn-detail"
                                                    style="margin-left: auto"
                                                    type="button"
                                                    onclick="openModal('<%# Eval("Id") %>')"
                                                    aria-label='Abrir detalle completo del movimiento #<%# Eval("Id") %> en panel'>
                                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
                                                        stroke="currentColor" stroke-width="2"
                                                        stroke-linecap="round" stroke-linejoin="round"
                                                        aria-hidden="true" focusable="false">
                                                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
                                                        <polyline points="14 2 14 8 20 8" />
                                                    </svg>
                                                    <span>Detalle completo</span>
                                                </button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <!-- Empty state -->
                <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
                    <div class="empty-icon" aria-hidden="true">
                        <svg width="48" height="48" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="1.5" stroke-linecap="round"
                            stroke-linejoin="round" focusable="false">
                            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20" />
                            <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" />
                        </svg>
                    </div>
                    <div class="empty-title">No hay registros en la bitácora</div>
                    <div class="empty-desc">Los movimientos del sistema aparecerán aquí automáticamente cuando se realicen operaciones.</div>
                </asp:Panel>
            </div>

            <!-- Table footer / pagination -->
            <div class="table-footer">
                <span class="footer-info" id="footerInfo" aria-live="polite"></span>
                <nav class="pagination" id="pagination" aria-label="Paginación de resultados"></nav>
            </div>
        </section>

        <!-- ── MOBILE CARD VIEW ── -->
        <div class="log-card-list" id="cardList" aria-label="Lista de movimientos (vista móvil)">
            <asp:Repeater ID="rptBitacoraCard" runat="server">
                <ItemTemplate>
                    <article class="log-card"
                        data-usuario='<%# Eval("Usuario") %>'
                        data-op='<%# Eval("OperacionCss") %>'
                        data-entidad='<%# Eval("EntidadNombre") %>'
                        data-busq='<%# (Eval("Usuario").ToString() + " " + Eval("EntidadNombre").ToString() + " " + Eval("Descripcion").ToString()).ToLower() %>'
                        data-fecha='<%# Eval("FechaISO") %>'>

                        <div class="log-card-header">
                            <div class="log-card-icon <%# Eval("OperacionCss") %>" aria-hidden="true">
                                <%# GetOpIcon(Eval("OperacionCss").ToString()) %>
                            </div>
                            <div class="log-card-info">
                                <div class="log-card-entity"><%# Eval("EntidadNombre") %></div>
                                <div class="log-card-op-row">
                                    <span class="op-pill <%# Eval("OperacionCss") %>">
                                        <span class="op-dot" aria-hidden="true"></span>
                                        <%# Eval("OperacionLabel") %>
                                    </span>
                                    <span style="font-size: 11px; color: var(--clr-gray-400)"><%# Eval("EntidadTipo") %></span>
                                </div>
                            </div>
                        </div>

                        <dl class="log-card-meta">
                            <div class="log-card-field">
                                <dt class="log-card-field-label">Usuario</dt>
                                <dd class="log-card-field-val"><%# Eval("Usuario") %></dd>
                            </div>
                            <div class="log-card-field">
                                <dt class="log-card-field-label">Fecha</dt>
                                <dd class="log-card-field-val">
                                    <time datetime='<%# Eval("FechaISO") %>'>
                                        <%# Eval("FechaFormateada") %>
                                    </time>
                                </dd>
                            </div>
                        </dl>

                        <div class="log-card-vals">
                            <div class="vals-label">Cambios registrados</div>
                            <div class="vals-diff-row">
                                <span class="vals-diff-key">Anterior:</span>
                                <%# string.IsNullOrEmpty(Eval("ValorAnteriorResumen").ToString())
                                                ? "<span class=\"val-badge none\">Sin datos previos</span>"
                                                : $"<span class=\"val-badge prev\">{Eval("ValorAnteriorResumen")}</span>" %>
                            </div>
                            <div class="vals-diff-row">
                                <span class="vals-diff-key">Nuevo:</span>
                                <%# string.IsNullOrEmpty(Eval("ValorNuevoResumen").ToString())
                                                ? "<span class=\"val-badge none\">Sin datos nuevos</span>"
                                                : $"<span class=\"val-badge next\">{Eval("ValorNuevoResumen")}</span>" %>
                            </div>
                        </div>

                        <button class="log-card-btn-detail"
                            type="button"
                            onclick="openModal('<%# Eval("Id") %>')"
                            aria-label='Ver detalle completo del movimiento #<%# Eval("Id") %>'>
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" stroke-linejoin="round"
                                aria-hidden="true" focusable="false">
                                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
                                <polyline points="14 2 14 8 20 8" />
                            </svg>
                            <span>Ver detalle completo</span>
                        </button>
                    </article>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </main>

    </div>
        </div>

        <!-- ══════════════ DETAIL MODAL ══════════════ -->
    <div class="modal-backdrop"
        id="detailModal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="modalTitle"
        hidden>
        <div class="modal">
            <div class="modal-header">
                <div class="modal-header-icon" id="mHeaderIcon" aria-hidden="true"></div>
                <div>
                    <h2 class="modal-header-title" id="modalTitle">Detalle del movimiento</h2>
                    <div class="modal-header-sub" id="mHeaderSub"></div>
                </div>
                <button class="modal-close"
                    id="btnModalClose"
                    type="button"
                    aria-label="Cerrar panel de detalle">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" aria-hidden="true" focusable="false">
                        <line x1="18" y1="6" x2="6" y2="18" />
                        <line x1="6" y1="6" x2="18" y2="18" />
                    </svg>
                </button>
            </div>

            <div class="modal-body">
                <dl class="modal-meta-strip">
                    <div class="modal-meta-item">
                        <dt class="modal-meta-label">ID de registro</dt>
                        <dd class="modal-meta-val" id="mMetaId"></dd>
                    </div>
                    <div class="modal-meta-item">
                        <dt class="modal-meta-label">Usuario</dt>
                        <dd class="modal-meta-val" id="mMetaUsuario"></dd>
                    </div>
                    <div class="modal-meta-item">
                        <dt class="modal-meta-label">Fecha y hora</dt>
                        <dd class="modal-meta-val" id="mMetaFecha"></dd>
                    </div>
                    <div class="modal-meta-item">
                        <dt class="modal-meta-label">Operación</dt>
                        <dd class="modal-meta-val" id="mMetaOp"></dd>
                    </div>
                    <div class="modal-meta-item">
                        <dt class="modal-meta-label">Entidad</dt>
                        <dd class="modal-meta-val" id="mMetaEntidad"></dd>
                    </div>
                    <div class="modal-meta-item">
                        <dt class="modal-meta-label">Dirección IP</dt>
                        <dd class="modal-meta-val" id="mMetaIp"></dd>
                    </div>
                </dl>

                <h3 class="modal-section-title">Descripción</h3>
                <p style="font-size: 13px; color: var(--clr-gray-600); margin-bottom: 20px; line-height: 1.6"
                    id="mDesc">
                </p>

                <h3 class="modal-section-title">Comparativa de cambios</h3>
                <div id="mDiffArea"></div>
            </div>

            <div class="modal-footer">
                <button class="btn-modal-close"
                    id="btnModalCloseFooter"
                    type="button">
                    Cerrar</button>
            </div>
        </div>
    </div>

    <!-- Hidden JSON data store for modal access -->
    <asp:HiddenField ID="hfMovimientosJson" runat="server" />

    <!-- Toast notification -->
    <div class="toast"
        id="toast"
        role="alert"
        aria-live="assertive"
        aria-atomic="true">
        <span class="ti" id="toastIcon" aria-hidden="true"></span>
        <span id="toastMsg"></span>
    </div>
</asp:Content>
<asp:Content ID="PageScripts" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ResolveUrl("~/JS/bitacora.js") %>"></script>
</asp:Content>
