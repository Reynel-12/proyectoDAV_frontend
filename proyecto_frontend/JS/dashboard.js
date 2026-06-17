(function () {

    var main = document.getElementById('main-content');
    var apiBase = main ? main.getAttribute('data-api-base') || '' : '';

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

})();