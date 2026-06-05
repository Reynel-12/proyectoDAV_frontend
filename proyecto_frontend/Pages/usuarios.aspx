<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="usuarios.aspx.cs" Inherits="proyecto_frontend.Pages.usuarios" MasterPageFile="~/AppShell.Master" Title="Usuarios" %>
<asp:Content ID="PageHead" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/CSS/usuarios.css") %>" />
</asp:Content>

<asp:Content ID="PageBody" ContentPlaceHolderID="BodyContent" runat="server">
    <main class="main-content" id="main-content">
        <div class="page-header">
            <div>
                <h1 class="page-title">Usuarios</h1>
                <p class="page-subtitle">
                    <asp:Literal ID="litTotalUsuarios" runat="server" Text="0" />
                    cuentas registradas en la plataforma
                </p>
            </div>
        </div>

        <section class="kpi-grid" aria-label="Resumen de usuarios">
            <article class="kpi-card">
                <div class="kpi-icon blue" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M20 21V19C20 17.3 18.7 16 17 16H7C5.3 16 4 17.3 4 19V21" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" />
                        <circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="1.8" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value"><asp:Literal ID="litKpiTotal" runat="server" Text="0" /></div>
                    <div class="kpi-label">Usuarios registrados</div>
                </div>
            </article>

            <article class="kpi-card">
                <div class="kpi-icon green" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value"><asp:Literal ID="litKpiActivos" runat="server" Text="0" /></div>
                    <div class="kpi-label">Cuentas activas</div>
                </div>
            </article>

            <article class="kpi-card">
                <div class="kpi-icon purple" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M12 12C14.7614 12 17 9.76142 17 7C17 4.23858 14.7614 2 12 2C9.23858 2 7 4.23858 7 7C7 9.76142 9.23858 12 12 12Z" stroke="currentColor" stroke-width="1.8" />
                        <path d="M4 21C4 17.6863 7.13401 15 11 15H13C16.866 15 20 17.6863 20 21" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value"><asp:Literal ID="litKpiAdministradores" runat="server" Text="0" /></div>
                    <div class="kpi-label">Administradores</div>
                </div>
            </article>

            <article class="kpi-card">
                <div class="kpi-icon amber" aria-hidden="true">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M12 5V19" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" />
                        <path d="M5 12H19" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" />
                    </svg>
                </div>
                <div class="kpi-body">
                    <div class="kpi-value"><asp:Literal ID="litKpiNuevosMes" runat="server" Text="0" /></div>
                    <div class="kpi-label">Nuevos este mes</div>
                </div>
            </article>
        </section>

        <section class="toolbar" aria-label="Filtros de usuarios">
            <div class="search-wrap">
                <span class="search-icon" aria-hidden="true">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                        <circle cx="10" cy="10" r="7" stroke="currentColor" stroke-width="1.5" />
                        <path d="M15 15L21 21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                    </svg>
                </span>
                <input type="search" class="search-input" id="searchInput" placeholder="Buscar por nombre, correo o teléfono..." aria-label="Buscar usuarios" autocomplete="off" />
            </div>

            <select class="filter-select" id="filterRol" aria-label="Filtrar por rol">
                <option value="">Todos los roles</option>
                <asp:Literal ID="litRolOptions" runat="server" />
            </select>

            <select class="filter-select" id="filterEstado" aria-label="Filtrar por estado">
                <option value="">Todos los estados</option>
                <asp:Literal ID="litEstadoOptions" runat="server" />
            </select>

            <div class="toolbar-right">
                <span class="results-count" id="resultsCount" aria-live="polite"></span>
                <button type="button" class="btn-view-toggle active" id="btnTableView" aria-label="Vista tabla" aria-pressed="true">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                        <rect x="3" y="4" width="18" height="4" rx="1" stroke="currentColor" stroke-width="1.5" />
                        <rect x="3" y="10" width="18" height="4" rx="1" stroke="currentColor" stroke-width="1.5" />
                        <rect x="3" y="16" width="18" height="4" rx="1" stroke="currentColor" stroke-width="1.5" />
                    </svg>
                </button>
                <button type="button" class="btn-view-toggle" id="btnCardView" aria-label="Vista tarjetas" aria-pressed="false">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                        <rect x="4" y="4" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" />
                        <rect x="13" y="4" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" />
                        <rect x="4" y="13" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" />
                        <rect x="13" y="13" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" />
                    </svg>
                </button>
            </div>
        </section>

        <section class="table-card">
            <div class="table-wrap" id="tableView">
                <table class="data-table" aria-label="Listado de usuarios registrados">
                    <thead>
                        <tr>
                            <th class="sortable" data-col="nombre" scope="col">Usuario<span class="sort-icon">⇕</span></th>
                            <th class="sortable" data-col="correo" scope="col">Correo<span class="sort-icon">⇕</span></th>
                            <th class="sortable" data-col="rol" scope="col">Rol<span class="sort-icon">⇕</span></th>
                            <th class="sortable" data-col="estado" scope="col">Estado<span class="sort-icon">⇕</span></th>
                            <th class="sortable" data-col="registro" scope="col">Registro<span class="sort-icon">⇕</span></th>
                            <th class="sortable" data-col="ultimoacceso" scope="col">Último acceso<span class="sort-icon">⇕</span></th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                        <asp:Repeater ID="rptUsuarios" runat="server">
                            <ItemTemplate>
                                <tr class="user-row"
                                    data-nombre='<%# Eval("NombreCompleto") %>'
                                    data-correo='<%# Eval("Correo") %>'
                                    data-telefono='<%# Eval("Telefono") %>'
                                    data-rol='<%# Eval("RolKey") %>'
                                    data-estado='<%# Eval("EstadoKey") %>'
                                    data-registro='<%# Eval("FechaRegistroOrden") %>'
                                    data-ultimoacceso='<%# Eval("UltimoAccesoOrden") %>'>
                                    <td>
                                        <div class="user-cell">
                                            <div class='user-avatar <%# Eval("AvatarClase") %>' aria-hidden="true"><%# Eval("Iniciales") %></div>
                                            <div>
                                                <div class="user-name"><%# Eval("NombreCompleto") %></div>
                                                <div class="user-meta"><%# Eval("Telefono") %></div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="text-strong"><%# Eval("Correo") %></div>
                                        <div class="text-muted"><%# Eval("Ciudad") %></div>
                                    </td>
                                    <td><span class='role-pill <%# Eval("RolKey") %>'><%# Eval("Rol") %></span></td>
                                    <td><span class='status-pill <%# Eval("EstadoKey") %>'><span class="status-dot"></span><%# Eval("Estado") %></span></td>
                                    <td>
                                        <div class="text-strong"><%# Eval("FechaRegistro") %></div>
                                        <div class="text-muted"><%# Eval("Origen") %></div>
                                    </td>
                                    <td>
                                        <div class="text-strong"><%# Eval("UltimoAcceso") %></div>
                                        <div class="text-muted"><%# Eval("Actividad") %></div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-state">
                    <div class="empty-icon" aria-hidden="true">
                        <svg width="56" height="56" viewBox="0 0 24 24" fill="none">
                            <path d="M20 21V19C20 17.3 18.7 16 17 16H7C5.3 16 4 17.3 4 19V21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" />
                            <circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="1.6" />
                        </svg>
                    </div>
                    <div class="empty-title">No hay usuarios registrados</div>
                    <div class="empty-desc">Cuando existan cuentas creadas en la plataforma, aparecerán listadas aquí.</div>
                </asp:Panel>
            </div>

            <div class="card-grid" id="cardView">
                <asp:Repeater ID="rptUsuariosCard" runat="server">
                    <ItemTemplate>
                        <article class="user-card"
                            data-nombre='<%# Eval("NombreCompleto") %>'
                            data-correo='<%# Eval("Correo") %>'
                            data-telefono='<%# Eval("Telefono") %>'
                            data-rol='<%# Eval("RolKey") %>'
                            data-estado='<%# Eval("EstadoKey") %>'
                            data-registro='<%# Eval("FechaRegistroOrden") %>'
                            data-ultimoacceso='<%# Eval("UltimoAccesoOrden") %>'>
                            <div class="user-card-top">
                                <div class='user-avatar lg <%# Eval("AvatarClase") %>' aria-hidden="true"><%# Eval("Iniciales") %></div>
                                <div>
                                    <div class="user-name"><%# Eval("NombreCompleto") %></div>
                                    <div class="text-muted"><%# Eval("Correo") %></div>
                                </div>
                            </div>

                            <div class="user-card-tags">
                                <span class='role-pill <%# Eval("RolKey") %>'><%# Eval("Rol") %></span>
                                <span class='status-pill <%# Eval("EstadoKey") %>'><span class="status-dot"></span><%# Eval("Estado") %></span>
                            </div>

                            <div class="user-card-grid">
                                <div>
                                    <div class="meta-label">Teléfono</div>
                                    <div class="meta-value"><%# Eval("Telefono") %></div>
                                </div>
                                <div>
                                    <div class="meta-label">Ciudad</div>
                                    <div class="meta-value"><%# Eval("Ciudad") %></div>
                                </div>
                                <div>
                                    <div class="meta-label">Registro</div>
                                    <div class="meta-value"><%# Eval("FechaRegistro") %></div>
                                </div>
                                <div>
                                    <div class="meta-label">Último acceso</div>
                                    <div class="meta-value"><%# Eval("UltimoAcceso") %></div>
                                </div>
                            </div>

                            <div class="user-card-footer">
                                <span class="text-muted"><%# Eval("Origen") %></span>
                                <span class="text-strong"><%# Eval("Actividad") %></span>
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </section>
    </main>
</asp:Content>

<asp:Content ID="PageScripts" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ResolveUrl("~/JS/usuarios.js") %>"></script>
</asp:Content>
