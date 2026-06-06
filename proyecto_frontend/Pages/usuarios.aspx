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
            <a class="btn-new" href="nuevoUsuario.aspx" aria-label="Crear nuevo usuario">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                    <path d="M12 5V19" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                    <path d="M5 12H19" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                </svg>
                Nuevo usuario
            </a>
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
                            <th scope="col" class="th-actions">Acciones</th>
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
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="text-strong"><%# Eval("Correo") %></div>
                                    </td>
                                    <td><span class='role-pill <%# Eval("RolKey") %>'><%# Eval("Rol") %></span></td>
                                    <td><span class='status-pill <%# Eval("EstadoKey") %>'><span class="status-dot"></span><%# Eval("Estado") %></span></td>
                                    <td>
                                        <div class="text-strong"><%# Eval("FechaRegistro") %></div>
                                    </td>
                                    <td class="td-actions">
                                        <div class="action-wrap">
                                            <a class="btn-action edit" href='nuevoUsuario.aspx?id=<%# Eval("Id") %>' title='Editar usuario <%# Eval("NombreCompleto") %>' aria-label='Editar usuario <%# Eval("NombreCompleto") %>'>
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                                    <path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                </svg>
                                            </a>
                                            <button class="btn-action del" type="button" title='Eliminar usuario <%# Eval("NombreCompleto") %>' aria-label='Eliminar usuario <%# Eval("NombreCompleto") %>' onclick="openDeleteModal('<%# Eval("Id") %>','<%# Server.HtmlEncode(Eval("NombreCompleto").ToString()) %>','<%# Server.HtmlEncode(Eval("Correo").ToString()) %>','<%# Eval("Iniciales") %>','<%# Eval("AvatarClase") %>')">
                                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                                                    <path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                                    <path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                                    <path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                                    <path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                    <path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none" />
                                                </svg>
                                            </button>
                                        </div>
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
                    <a class="btn-new" href="nuevoUsuario.aspx">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                            <path d="M12 5V19" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                            <path d="M5 12H19" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                        </svg>
                        Crear primer usuario
                    </a>
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
                                <!-- <div>
                                    <div class="meta-label">Teléfono</div>
                                    <div class="meta-value"><%# Eval("Telefono") %></div>
                                </div>
                                     
                               <!-- <div>
                                    <div class="meta-label">Ciudad</div>
                                    <div class="meta-value"><%# Eval("Ciudad") %></div>
                                </div>
                                    -->
                                <div>
                                    <div class="meta-label">Registro</div>
                                    <div class="meta-value"><%# Eval("FechaRegistro") %></div>
                                </div>
                               <!-- <div>
                                    <div class="meta-label">Último acceso</div>
                                    <div class="meta-value"><%# Eval("UltimoAcceso") %></div>
                                </div>
                                   -->
                            </div>

                           <!-- <div class="user-card-footer">
                                <span class="text-muted"><%# Eval("Origen") %></span>
                                <span class="text-strong"><%# Eval("Actividad") %></span>
                            </div>
                                -->

                            <div class="card-actions">
                                <a class="btn-card-action edit" href='nuevoUsuario.aspx?id=<%# Eval("Id") %>'>
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                                        <path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    </svg>
                                    Editar
                                </a>
                                <button class="btn-card-action del" type="button" onclick="openDeleteModal('<%# Eval("Id") %>','<%# Server.HtmlEncode(Eval("NombreCompleto").ToString()) %>','<%# Server.HtmlEncode(Eval("Correo").ToString()) %>','<%# Eval("Iniciales") %>','<%# Eval("AvatarClase") %>')">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                                        <path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                        <path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                        <path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                        <path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none" />
                                        <path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    </svg>
                                    Eliminar
                                </button>
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </section>

        <asp:HiddenField ID="hfDeleteId" runat="server" ClientIDMode="Static" />
        <asp:Button ID="btnDeleteConfirm" runat="server" ClientIDMode="Static" Style="display:none" OnClick="btnDeleteConfirm_Click" CausesValidation="false" />

        <div class="modal-backdrop" id="deleteModal" role="dialog" aria-modal="true" aria-labelledby="deleteModalTitle">
            <div class="modal">
                <div class="modal-header">
                    <div class="modal-icon-wrap" aria-hidden="true">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
                            <path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                            <path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none" />
                            <path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none" />
                        </svg>
                    </div>
                    <div>
                        <div class="modal-title" id="deleteModalTitle">Eliminar usuario</div>
                        <div class="modal-subtitle">Esta acción retirará el usuario de la lista actual.</div>
                    </div>
                </div>

                <div class="modal-user-ref">
                    <div class="modal-user-avatar ua-blue" id="modalUserAvatar">US</div>
                    <div>
                        <div class="modal-user-name" id="modalUserName">Usuario</div>
                        <div class="modal-user-email" id="modalUserEmail">correo@dominio.com</div>
                    </div>
                </div>

                <div class="modal-warning">
                    Verifica que el usuario ya no necesite acceso antes de confirmar la eliminación.
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn-modal-cancel" id="btnModalCancel">Cancelar</button>
                    <button type="button" class="btn-modal-delete" id="btnModalDelete">Eliminar usuario</button>
                </div>
            </div>
        </div>

        <div class="toast" id="toast" role="status" aria-live="polite">
            <span class="toast-icon" id="toastIcon">✔</span>
            <span id="toastMsg">Acción completada</span>
        </div>
    </main>
</asp:Content>

<asp:Content ID="PageScripts" ContentPlaceHolderID="PageScripts" runat="server">
    <script src="<%= ResolveUrl("~/JS/usuarios.js") %>"></script>
</asp:Content>
