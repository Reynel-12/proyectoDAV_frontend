<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="proyecto_frontend.dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="~/CSS/dashboard.css" />
    <title>Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
</head>
<body>
    <div class="app-shell" id="appShell">

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

            <!-- ── Sidebar overlay ── -->
            <div class="sidebar-overlay" id="sidebarOverlay" aria-hidden="true"></div>

            <!-- ── Sidebar ── -->
            <nav class="sidebar" id="sidebar" aria-label="Navegación principal">

                <div class="nav-section">
                    <span class="nav-section-label">Principal</span>
                    <a class="nav-item active" href="Dashboard.aspx" aria-current="page">
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
                    <a class="nav-item" href="productos.aspx">
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

                <div class="page-header">
                    <h1 class="page-title">Dashboard</h1>
                    <p class="page-subtitle">Resumen general del inventario</p>
                </div>

                <!-- KPI Cards -->
                <div class="kpi-grid">
                    <div class="kpi-card">
                        <div class="kpi-icon-wrap blue" aria-hidden="true">
                            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect x="3" y="3" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                <rect x="14" y="3" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                <rect x="3" y="14" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                                <rect x="14" y="14" width="7" height="7" rx="1.5" stroke="currentColor" stroke-width="1.5" fill="none" />
                            </svg>
                        </div>
                        <div class="kpi-value">
                            <asp:Literal ID="litTotalProductos" runat="server" Text="0" />
                        </div>
                        <div class="kpi-label">Total de productos</div>
                        <div class="kpi-trend up">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <path d="M12 4L12 20M12 4L18 10M12 4L6 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                            </svg>
                            +12 este mes
                        </div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-icon-wrap amber" aria-hidden="true">
                            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                <path d="M12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                            </svg>
                        </div>
                        <div class="kpi-value">
                            <asp:Literal ID="litBajaExistenciaCount" runat="server" Text="0" />
                        </div>
                        <div class="kpi-label">Baja existencia</div>
                        <div class="kpi-trend warn">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="1.5" fill="none" />
                                <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                            </svg>
                            Requiere atención
                        </div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-icon-wrap green" aria-hidden="true">
                            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M20 6L9 17L4 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                            </svg>
                        </div>
                        <div class="kpi-value">
                            <asp:Literal ID="litEnStock" runat="server" Text="0" />
                        </div>
                        <div class="kpi-label">En stock normal</div>
                        <div class="kpi-trend up">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <path d="M12 4L12 20M12 4L18 10M12 4L6 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                            </svg>
                            <asp:Literal ID="litPorcentajeStock" runat="server" Text="0%" />
                        </div>
                    </div>
                    <div class="kpi-card">
                        <div class="kpi-icon-wrap red" aria-hidden="true">
                            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                            </svg>
                        </div>
                        <div class="kpi-value">
                            <asp:Literal ID="litSinStock" runat="server" Text="0" />
                        </div>
                        <div class="kpi-label">Sin stock</div>
                        <div class="kpi-trend down">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <path d="M12 20L12 4M12 20L18 14M12 20L6 14" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                            </svg>
                            -3 vs ayer
                        </div>
                    </div>
                </div>

                <!-- Mid row: baja existencia + accesos rápidos -->
                <div class="mid-row">

                    <!-- Baja existencia -->
                    <div class="section-card">
                        <div class="sc-header">
                            <span class="sc-title">
                                <span class="sc-title-icon" style="color: var(--clr-amber-500)" aria-hidden="true">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M12 8V12M12 16H12.01" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                        <path d="M12 21C16.9706 21 21 16.9706 21 12C21 7.02944 16.9706 3 12 3C7.02944 3 3 7.02944 3 12C3 16.9706 7.02944 21 12 21Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    </svg>
                                </span>
                                Productos con baja existencia
                            </span>
                        </div>
                        <div class="stock-list">
                            <asp:Repeater ID="rptBajaExistencia" runat="server">
                                <ItemTemplate>
                                    <div class="stock-item">
                                        <div class="stock-dot <%# (int)Eval("Stock") <= 2 ? "critical" : "warning" %>"></div>
                                        <span class="stock-name"><%# Eval("Nombre") %></span>
                                        <div class="stock-bar-wrap">
                                            <div class="stock-bar <%# (int)Eval("Stock") <= 2 ? "critical" : "warning" %>"
                                                style="width: <%# Math.Min(100, (int)Eval("Stock") * 5) %>%">
                                            </div>
                                        </div>
                                        <span class="stock-qty <%# (int)Eval("Stock") <= 2 ? "critical" : "warning" %>">
                                            <%# Eval("Stock") %> uds
                                        </span>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                    <!-- Accesos rápidos -->
                    <div class="section-card">
                        <div class="sc-header">
                            <span class="sc-title">
                                <span class="sc-title-icon" style="color: var(--clr-blue-500)" aria-hidden="true">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M13 2L3 14H12L11 22L21 10H12L13 2Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    </svg>
                                </span>
                                Accesos rápidos
                            </span>
                        </div>
                        <div class="qa-grid">
                            <a class="qa-btn" href="nuevoProducto.aspx">
                                <span class="qa-icon" aria-hidden="true">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M12 4V20M20 12H4" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </span>
                                <span class="qa-label">Nuevo producto</span>
                            </a>
                            <a class="qa-btn" href="RegistrarEntrada.aspx">
                                <span class="qa-icon" aria-hidden="true">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M12 4L12 20M12 4L18 10M12 4L6 10" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </span>
                                <span class="qa-label">Registrar entrada</span>
                            </a>
                            <a class="qa-btn" href="RegistrarSalida.aspx">
                                <span class="qa-icon" aria-hidden="true">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M12 20L12 4M12 20L18 14M12 20L6 14" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
                                    </svg>
                                </span>
                                <span class="qa-label">Registrar salida</span>
                            </a>
                            <a class="qa-btn" href="Productos.aspx?buscar=1">
                                <span class="qa-icon" aria-hidden="true">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <circle cx="10" cy="10" r="7" stroke="currentColor" stroke-width="1.5" fill="none" />
                                        <path d="M15 15L21 21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                    </svg>
                                </span>
                                <span class="qa-label">Buscar producto</span>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Bitácora -->
                <div class="section-card">
                    <div class="sc-header">
                        <span class="sc-title">
                            <span class="sc-title-icon" style="color: var(--clr-blue-500)" aria-hidden="true">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M4 6H20V18H4V6Z" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <path d="M8 6V4H16V6" stroke="currentColor" stroke-width="1.5" fill="none" />
                                    <path d="M8 10H16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                    <path d="M8 14H14" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" />
                                </svg>
                            </span>
                            Bitácora — últimos movimientos
                        </span>
                        <button class="sc-action" onclick="location.href='Bitacora.aspx'">Ver bitácora completa</button>
                    </div>
                    <div class="log-table-wrap">
                        <table class="log-table" aria-label="Bitácora de últimos movimientos">
                            <thead>
                                <tr>
                                    <th scope="col">Fecha / hora</th>
                                    <th scope="col">Producto</th>
                                    <th scope="col">Tipo</th>
                                    <th scope="col">Cantidad</th>
                                    <th scope="col">Usuario</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptBitacora" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("Fecha", "{0:dd/MM/yyyy HH:mm}") %></td>
                                            <td><%# Eval("Producto") %></td>
                                            <td>
                                                <span class="log-pill <%# Eval("TipoMovimiento").ToString().ToLower() %>">
                                                    <%# Eval("TipoMovimiento") %>
                                                </span>
                                            </td>
                                            <td><%# Eval("Cantidad") %></td>
                                            <td><%# Eval("Usuario") %></td>
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
    <script src="JS/dashboard.js"></script>
</body>
</html>
