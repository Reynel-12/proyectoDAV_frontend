<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="bitacora.aspx.cs" Inherits="proyecto_frontend.Pages.bitacora" MasterPageFile="~/AppShell.Master" Title="Bitácora" ResponseEncoding="utf-8" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/CSS/bitacora.css") %>" />
</asp:Content>
<asp:Content ID="PageBody" ContentPlaceHolderID="BodyContent" runat="server">

    <%-- ✅ data-api-base agregado --%>
    <main class="main-content" id="main-content" tabindex="-1"
          data-api-base="https://localhost:44316/bitacora.asmx">

        <!-- Page header -->
        <div class="page-header">
            <div>
                <h1 class="page-title">Bitácora de movimientos</h1>
                <p class="page-subtitle">Historial completo de operaciones realizadas en el sistema</p>
            </div>
            <div class="header-actions">
                <button class="btn-export" id="btnExportCSV" type="button"
                    aria-label="Exportar bitácora completa a formato CSV">
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

        <!-- KPIs ✅ asp:Literal reemplazados por span -->
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
                    <div class="kpi-value"><span id="litTotalMovs">0</span></div>
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
                    <div class="kpi-value"><span id="litCreaciones">0</span></div>
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
                    <div class="kpi-value"><span id="litEdiciones">0</span></div>
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
                    <div class="kpi-value"><span id="litEliminaciones">0</span></div>
                    <div class="kpi-label">Eliminaciones</div>
                </div>
            </div>

            <%--<div class="kpi-card">
                <div class="kpi-icon-wrap cyan" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <line x1="12" y1="5" x2="12" y2="19" />
                        <polyline points="19 12 12 19 5 12" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value"><span id="litEntradas">0</span></div>
                    <div class="kpi-label">Entradas de stock</div>
                </div>
            </div>--%>

            <%--<div class="kpi-card">
                <div class="kpi-icon-wrap amber" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <line x1="12" y1="19" x2="12" y2="5" />
                        <polyline points="5 12 12 5 19 12" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value"><span id="litSalidas">0</span></div>
                    <div class="kpi-label">Salidas de stock</div>
                </div>
            </div>--%>

            <%--<div class="kpi-card">
                <div class="kpi-icon-wrap purple" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round"
                        stroke-linejoin="round" focusable="false">
                        <circle cx="12" cy="12" r="3" />
                        <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value"><span id="litAjustes">0</span></div>
                    <div class="kpi-label">Ajustes</div>
                </div>
            </div>--%>

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
                    <div class="kpi-value"><span id="litUsuariosActivos">0</span></div>
                    <div class="kpi-label">Usuarios activos</div>
                </div>
            </div>

        </div>

        <!-- Filter panel -->
        <section class="filter-card" aria-label="Filtros de búsqueda">
            <div class="filter-row">
                <div class="filter-group">
                    <label class="filter-label" for="fBusqueda">Búsqueda</label>
                    <input type="search" class="filter-input" id="fBusqueda" name="fBusqueda"
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
                    <%-- ✅ select vacío — JS lo llenará con poblarUsuarios() --%>
                    <select class="filter-select" id="fUsuario" name="fUsuario">
                        <option value="">Todos los usuarios</option>
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
                    <button class="btn-filter-clear" id="btnClearFilters" type="button">Limpiar filtros</button>
                    <button class="btn-filter-apply" id="btnApplyFilters" type="button">Aplicar filtros</button>
                </div>
            </div>
            <div class="active-filters" id="activeFilters" style="display:none"
                role="status" aria-live="polite" aria-label="Filtros activos">
            </div>
        </section>

        <!-- TABLE VIEW -->
        <section class="table-card" aria-label="Registros de bitácora">
            <div class="table-toolbar">
                <div class="table-toolbar-left">
                    <p class="results-info" id="resultsInfo" role="status" aria-live="polite">
                        Mostrando <strong id="resultsCount">0</strong> registros
                    </p>
                </div>
                <div class="table-toolbar-right">
                    <label for="pageSize" style="font-size:12px;color:var(--clr-gray-500)">Filas por página:</label>
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
                                <svg class="sort-icon" width="14" height="14" viewBox="0 0 24 24" fill="none"
                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" aria-hidden="true" focusable="false">
                                    <line x1="12" y1="5" x2="12" y2="19" /><polyline points="19 12 12 19 5 12" />
                                </svg>
                            </th>
                            <th class="sortable" data-col="fecha" scope="col" aria-sort="none">Fecha / hora
                                <svg class="sort-icon" width="14" height="14" viewBox="0 0 24 24" fill="none"
                                    stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" aria-hidden="true" focusable="false">
                                    <line x1="12" y1="5" x2="12" y2="19" /><polyline points="19 12 12 19 5 12" />
                                </svg>
                            </th>
                            <th scope="col">Operación</th>
                            <th scope="col">Entidad afectada</th>
                            <th scope="col">Dirección IP</th>
                            <th scope="col">Valores anteriores / nuevos</th>
                        </tr>
                    </thead>
                    <%-- ✅ tbody vacío — JS lo llenará --%>
                    <tbody id="tableBody"></tbody>
                </table>

                <%-- ✅ Panel vacío como div normal --%>
                <div id="pnlEmpty" class="empty-state" style="display:none;">
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
                </div>
            </div>

            <div class="table-footer">
                <span class="footer-info" id="footerInfo" aria-live="polite"></span>
                <nav class="pagination" id="pagination" aria-label="Paginación de resultados"></nav>
            </div>
        </section>

        <%-- ✅ cardList vacío — JS lo llenará --%>
        <div class="log-card-list" id="cardList" aria-label="Lista de movimientos (vista móvil)"></div>

        <!-- Toast -->
        <div class="toast" id="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <span class="ti" id="toastIcon" aria-hidden="true"></span>
            <span id="toastMsg"></span>
        </div>

    </main>

</asp:Content>
<asp:Content ID="PageScripts" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ResolveUrl("~/JS/bitacora.js") %>"></script>
</asp:Content>