(function () {

    var main = document.getElementById('main-content');
    var apiBase = main ? main.getAttribute('data-api-base') || '' : '';
    var productosApiBase = main ? main.getAttribute('data-productos-api-base') || '' : '';

    // ── Sidebar ──────────────────────────────────────────────────────────
    var menuBtn = document.getElementById('menuBtn');
    var sidebar = document.getElementById('sidebar');
    var overlay = document.getElementById('sidebarOverlay');

    function openSidebar() {
        sidebar.classList.add('open');
        overlay.classList.add('active');
        overlay.setAttribute('aria-hidden', 'false');
        menuBtn.setAttribute('aria-expanded', 'true');
    }

    function closeSidebar() {
        sidebar.classList.remove('open');
        overlay.classList.remove('active');
        overlay.setAttribute('aria-hidden', 'true');
        menuBtn.setAttribute('aria-expanded', 'false');
    }

    menuBtn.addEventListener('click', function () {
        sidebar.classList.contains('open') ? closeSidebar() : openSidebar();
    });

    overlay.addEventListener('click', closeSidebar);

    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') closeSidebar();
    });

    function setText(id, value) {
        var el = document.getElementById(id);
        if (el) el.textContent = value;
    }

    function formatNumber(value) {
        return Number(value || 0).toLocaleString('es-HN');
    }

    function renderProductosBajaExistencia(productos) {
        var list = document.getElementById('dashBajaExistenciaList');
        if (!list) return;

        if (!productos.length) {
            list.innerHTML =
                '<div class="stock-item">' +
                '<div class="stock-dot warning"></div>' +
                '<span class="stock-name">Sin productos de baja existencia</span>' +
                '<div class="stock-bar-wrap"><div class="stock-bar warning" style="width: 0%"></div></div>' +
                '<span class="stock-qty warning">0 uds</span>' +
                '</div>';
            return;
        }

        list.innerHTML = '';
        productos.slice(0, 5).forEach(function (producto) {
            var existencia = Number(producto.Existencia || 0);
            var estadoCss = existencia <= 2 ? 'critical' : 'warning';
            var ancho = Math.max(8, Math.min(100, existencia * 20));
            var nombre = producto.Descripcion || producto.Codigo || 'Producto';
            var item = document.createElement('div');

            item.className = 'stock-item';
            item.innerHTML =
                '<div class="stock-dot ' + estadoCss + '"></div>' +
                '<span class="stock-name">' + esc(nombre) + '</span>' +
                '<div class="stock-bar-wrap">' +
                '<div class="stock-bar ' + estadoCss + '" style="width: ' + ancho + '%"></div>' +
                '</div>' +
                '<span class="stock-qty ' + estadoCss + '">' + esc(existencia) + ' uds</span>';

            list.appendChild(item);
        });
    }

    async function cargarResumenProductos() {
        if (!productosApiBase) return;

        try {
            var result = await postJson(productosApiBase + '/ListarProductos', {});
            if (!result.Exitoso) throw new Error(result.Mensaje);

            var productos = result.Productos || [];
            var bajaExistencia = productos.filter(function (producto) {
                return Number(producto.Existencia || 0) <= 5;
            });
            var stockNormal = productos.filter(function (producto) {
                return Number(producto.Existencia || 0) > 5;
            });
            var bajoStock = productos.filter(function (producto) {
                var existencia = Number(producto.Existencia || 0);
                return existencia > 0 && existencia <= 5;
            });
            var productosBajaExistencia = bajaExistencia
                .slice()
                .sort(function (a, b) {
                    var existenciaA = Number(a.Existencia || 0);
                    var existenciaB = Number(b.Existencia || 0);
                    if (existenciaA !== existenciaB) return existenciaA - existenciaB;
                    return String(a.Descripcion || '').localeCompare(String(b.Descripcion || ''), 'es');
                })
                .slice(0, 5);
            var porcentajeNormal = productos.length
                ? ((stockNormal.length / productos.length) * 100).toFixed(1)
                : '0.0';

            setText('dashTotalProductos', formatNumber(productos.length));
            setText('dashBajaExistencia', formatNumber(bajaExistencia.length));
            setText('dashStockNormal', formatNumber(stockNormal.length));
            setText('dashBajoStock', formatNumber(bajoStock.length));
            setText('dashPorcentajeStock', porcentajeNormal + '% del total');
            renderProductosBajaExistencia(productosBajaExistencia);
        } catch (error) {
            console.error('Error cargando resumen de productos:', error);
        }
    }

    // ── Bitácora preview ─────────────────────────────────────────────────
    async function postJson(url, payload) {
        var response = await fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=utf-8' },
            body: JSON.stringify(payload || {})
        });
        if (!response.ok) throw new Error('HTTP ' + response.status);
        var result = await response.json();
        return result.d || result;
    }

    function esc(value) {
        return String(value || '')
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    async function cargarBitacoraPreview() {
        var tbody = document.getElementById('dashBitacoraBody');
        if (!tbody || !apiBase) return;

        try {
            var result = await postJson(apiBase + '/ListarBitacora', {});
            if (!result.Exitoso) throw new Error(result.Mensaje);

            var registros = (result.Registros || []).slice(0, 5);

            if (registros.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;padding:20px;color:var(--clr-gray-400)">Sin movimientos recientes</td></tr>';
                return;
            }

            tbody.innerHTML = '';
            registros.forEach(function (m) {
                var tr = document.createElement('tr');
                tr.innerHTML =
                    '<td>' + esc(m.FechaFormateada) + '</td>' +
                    '<td>' + esc(m.EntidadNombre) + '</td>' +
                    '<td>' +
                    '<span class="log-pill ' + esc(m.OperacionCss) + '">' +
                    esc(m.OperacionLabel) +
                    '</span>' +
                    '</td>' +
                    '<td>—</td>' +
                    '<td>' + esc(m.Usuario) + '</td>';
                tbody.appendChild(tr);
            });

        } catch (error) {
            console.error('Error cargando bitácora:', error);
        }
    }

    cargarBitacoraPreview();
    cargarResumenProductos();

})();