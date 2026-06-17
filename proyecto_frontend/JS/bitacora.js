(function () {
    function initBitacoraPage() {

        var main = document.getElementById('main-content');
        if (!main) return;

        var apiBase = main.getAttribute('data-api-base') || '';
        if (!apiBase) return;

        var registros = [];
        var registrosFiltrados = [];
        var currentPage = 1;
        var pageSize = 25;
        var sortState = { col: null, asc: true };
        var movData = {};

        // ── Escape HTML ──────────────────────────────────────────────────
        function esc(value) {
            return String(value || '')
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        // ── Fetch ────────────────────────────────────────────────────────
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

        // ── Fechas relativas ─────────────────────────────────────────────
        function relativeDate(isoStr) {
            if (!isoStr) return '';
            var d = new Date(isoStr);
            var now = new Date();
            var diff = Math.floor((now - d) / 1000);
            if (diff < 60) return 'Hace ' + diff + 's';
            if (diff < 3600) return 'Hace ' + Math.floor(diff / 60) + ' min';
            if (diff < 86400) return 'Hace ' + Math.floor(diff / 3600) + ' h';
            if (diff < 604800) return 'Hace ' + Math.floor(diff / 86400) + ' días';
            return d.toLocaleDateString('es-HN');
        }

        function updateRelativeDates() {
            document.querySelectorAll('.date-rel[data-ts]').forEach(function (el) {
                el.textContent = relativeDate(el.getAttribute('data-ts'));
            });
        }

        // ── Iconos de operación ──────────────────────────────────────────
        function getOpIcon(css) {
            switch (css) {
                case 'creacion':
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>';
                case 'edicion':
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>';
                case 'eliminacion':
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/></svg>';
                case 'entrada':
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"/><polyline points="19 12 12 19 5 12"/></svg>';
                case 'salida':
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="19" x2="12" y2="5"/><polyline points="5 12 12 5 19 12"/></svg>';
                default:
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/></svg>';
            }
        }

        // ── Render fila tabla ────────────────────────────────────────────
        function renderRow(m) {
            var tr = document.createElement('tr');
            tr.className = 'data-row';
            tr.setAttribute('data-id', m.Id);
            tr.setAttribute('data-usuario', m.Usuario);
            tr.setAttribute('data-fecha', m.FechaISO);
            tr.setAttribute('data-op', m.OperacionCss);
            tr.setAttribute('data-entidad', m.EntidadNombre);
            tr.setAttribute('data-busq', (m.Usuario + ' ' + m.EntidadNombre + ' ' + m.Descripcion).toLowerCase());

            tr.innerHTML =
                '<td>' +
                '<div class="user-cell">' +
                '<div class="user-avatar ' + esc(m.AvatarColor) + '" aria-hidden="true">' + esc(m.Iniciales) + '</div>' +
                '<span class="user-name">' + esc(m.Usuario) + '</span>' +
                '</div>' +
                '</td>' +
                '<td>' +
                '<div class="date-cell">' +
                '<time class="date-main" datetime="' + esc(m.FechaISO) + '">' + esc(m.FechaFormateada) + '</time>' +
                '<span class="date-rel" data-ts="' + esc(m.FechaISO) + '" aria-hidden="true"></span>' +
                '</div>' +
                '</td>' +
                '<td>' +
                '<span class="op-pill ' + esc(m.OperacionCss) + '">' +
                '<span class="op-dot" aria-hidden="true"></span>' +
                esc(m.OperacionLabel) +
                '</span>' +
                '</td>' +
                '<td>' +
                '<div class="entity-cell">' +
                '<span class="entity-type">' + esc(m.EntidadTipo) + '</span>' +
                '<span class="entity-name" title="' + esc(m.EntidadNombre) + '">' + esc(m.EntidadNombre) + '</span>' +
                '</div>' +
                '</td>' +
                '<td><span class="table-ip" title="' + esc(m.IpAddress) + '">' + esc(m.IpAddress) + '</span></td>' +
                '<td>' +
                '<div class="vals-preview">' +
                (m.ValorAnteriorResumen
                    ? '<span class="val-badge prev" title="' + esc(m.ValorAnteriorResumen) + '">' + esc(m.ValorAnteriorResumen) + '</span>'
                    : '<span class="val-badge none">Sin datos previos</span>') +
                '<span class="val-arrow" aria-label="hacia">&#8594;</span>' +
                (m.ValorNuevoResumen
                    ? '<span class="val-badge next" title="' + esc(m.ValorNuevoResumen) + '">' + esc(m.ValorNuevoResumen) + '</span>'
                    : '<span class="val-badge none">Sin datos nuevos</span>') +
                '</div>' +
                '</td>';

            return tr;
        }

        // ── Render card móvil ────────────────────────────────────────────
        function renderCard(m) {
            var article = document.createElement('article');
            article.className = 'log-card';
            article.setAttribute('data-usuario', m.Usuario);
            article.setAttribute('data-op', m.OperacionCss);
            article.setAttribute('data-entidad', m.EntidadNombre);
            article.setAttribute('data-busq', (m.Usuario + ' ' + m.EntidadNombre + ' ' + m.Descripcion).toLowerCase());
            article.setAttribute('data-fecha', m.FechaISO);

            article.innerHTML =
                '<div class="log-card-header">' +
                '<div class="log-card-icon ' + esc(m.OperacionCss) + '" aria-hidden="true">' + getOpIcon(m.OperacionCss) + '</div>' +
                '<div class="log-card-info">' +
                '<div class="log-card-entity">' + esc(m.EntidadNombre) + '</div>' +
                '<div class="log-card-op-row">' +
                '<span class="op-pill ' + esc(m.OperacionCss) + '"><span class="op-dot" aria-hidden="true"></span>' + esc(m.OperacionLabel) + '</span>' +
                '<span style="font-size:11px;color:var(--clr-gray-400)">' + esc(m.EntidadTipo) + '</span>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '<dl class="log-card-meta">' +
                '<div class="log-card-field"><dt class="log-card-field-label">Usuario</dt><dd class="log-card-field-val">' + esc(m.Usuario) + '</dd></div>' +
                '<div class="log-card-field"><dt class="log-card-field-label">Fecha</dt><dd class="log-card-field-val"><time datetime="' + esc(m.FechaISO) + '">' + esc(m.FechaFormateada) + '</time></dd></div>' +
                '<div class="log-card-field"><dt class="log-card-field-label">Dirección IP</dt><dd class="log-card-field-val log-card-field-ip">' + esc(m.IpAddress) + '</dd></div>' +
                '</dl>' +
                '<div class="log-card-vals">' +
                '<div class="vals-label">Cambios registrados</div>' +
                '<div class="vals-diff-row"><span class="vals-diff-key">Anterior:</span>' +
                (m.ValorAnteriorResumen
                    ? '<span class="val-badge prev">' + esc(m.ValorAnteriorResumen) + '</span>'
                    : '<span class="val-badge none">Sin datos previos</span>') +
                '</div>' +
                '<div class="vals-diff-row"><span class="vals-diff-key">Nuevo:</span>' +
                (m.ValorNuevoResumen
                    ? '<span class="val-badge next">' + esc(m.ValorNuevoResumen) + '</span>'
                    : '<span class="val-badge none">Sin datos nuevos</span>') +
                '</div>' +
                '</div>' +
                '<div class="log-card-desc">' +
                '<span class="log-card-field-label">Descripción</span>' +
                '<p class="log-card-desc-text">' + esc(m.Descripcion) + '</p>' +
                '</div>';

            return article;
        }

        // ── Render todos los registros ───────────────────────────────────
        function renderRegistros(lista) {
            var tbody = document.getElementById('tableBody');
            var cardList = document.getElementById('cardList');
            var pnlEmpty = document.getElementById('pnlEmpty');

            tbody.innerHTML = '';
            cardList.innerHTML = '';

            lista.forEach(function (m) {
                tbody.appendChild(renderRow(m));
                cardList.appendChild(renderCard(m));
            });

            if (pnlEmpty) pnlEmpty.style.display = lista.length === 0 ? '' : 'none';

            updateRelativeDates();
        }

        // ── KPIs ─────────────────────────────────────────────────────────
        function actualizarKpis(data) {
            var ids = {
                litTotalMovs: data.TotalMovs,
                litCreaciones: data.Creaciones,
                litEdiciones: data.Ediciones,
                litEliminaciones: data.Eliminaciones,
                litEntradas: data.Entradas,
                litSalidas: data.Salidas,
                litAjustes: data.Ajustes,
                litUsuariosActivos: data.UsuariosActivos
            };
            Object.keys(ids).forEach(function (id) {
                var el = document.getElementById(id);
                if (el) el.textContent = ids[id] || 0;
            });
        }

        // ── Opciones de usuario en filtro ────────────────────────────────
        function poblarUsuarios(usuarios) {
            var select = document.getElementById('fUsuario');
            if (!select) return;
            select.innerHTML = '<option value="">Todos los usuarios</option>';
            (usuarios || []).forEach(function (u) {
                var opt = document.createElement('option');
                opt.value = u.toLowerCase();
                opt.textContent = u;
                select.appendChild(opt);
            });
        }

        // ── Filtros ──────────────────────────────────────────────────────
        function getFilters() {
            return {
                q: (document.getElementById('fBusqueda').value || '').toLowerCase().trim(),
                op: document.getElementById('fOperacion').value || '',
                user: (document.getElementById('fUsuario').value || '').toLowerCase(),
                desde: document.getElementById('fFechaDesde').value || '',
                hasta: document.getElementById('fFechaHasta').value || ''
            };
        }

        function registroMatches(m, f) {
            var busq = (m.Usuario + ' ' + m.EntidadNombre + ' ' + m.Descripcion).toLowerCase();
            var fecha = m.FechaISO ? m.FechaISO.slice(0, 10) : '';

            if (f.q && !busq.includes(f.q)) return false;
            if (f.op && m.OperacionCss !== f.op) return false;
            if (f.user && !m.Usuario.toLowerCase().includes(f.user)) return false;
            if (f.desde && fecha < f.desde) return false;
            if (f.hasta && fecha > f.hasta) return false;
            return true;
        }

        function applyFilters() {
            var f = getFilters();
            registrosFiltrados = registros.filter(function (m) { return registroMatches(m, f); });

            if (sortState.col) sortRegistros();

            currentPage = 1;
            renderPagination();
            updateActiveChips(f);
            updateResultsCount();
        }

        // ── Sort ─────────────────────────────────────────────────────────
        function sortRegistros() {
            var col = sortState.col;
            var asc = sortState.asc;
            registrosFiltrados.sort(function (a, b) {
                var va = (a[col] || '').toString().toLowerCase();
                var vb = (b[col] || '').toString().toLowerCase();
                return asc ? va.localeCompare(vb) : vb.localeCompare(va);
            });
        }

        // ── Paginación ───────────────────────────────────────────────────
        function renderPagination() {
            var total = registrosFiltrados.length;
            var pages = Math.ceil(total / pageSize) || 1;
            var pg = document.getElementById('pagination');
            var footer = document.getElementById('footerInfo');
            var start = (currentPage - 1) * pageSize + 1;
            var end = Math.min(currentPage * pageSize, total);

            if (footer) {
                footer.textContent = total > 0
                    ? 'Mostrando ' + start + '–' + end + ' de ' + total + ' registros'
                    : 'Sin resultados';
            }

            var pagina = registrosFiltrados.slice((currentPage - 1) * pageSize, currentPage * pageSize);
            renderRegistros(pagina);

            if (!pg) return;
            pg.innerHTML = '';

            function addBtn(label, page, disabled, isActive) {
                var btn = document.createElement('button');
                btn.className = 'page-btn' + (isActive ? ' active' : '');
                btn.textContent = label;
                btn.disabled = disabled;
                if (!disabled && !isActive) {
                    btn.addEventListener('click', function () {
                        currentPage = page;
                        renderPagination();
                    });
                }
                pg.appendChild(btn);
            }

            addBtn('‹', currentPage - 1, currentPage === 1, false);
            for (var p = 1; p <= pages; p++) {
                if (pages > 7 && (p > 2 && p < currentPage - 1 || p > currentPage + 1 && p < pages - 1)) {
                    if (p === 3 || p === pages - 2) {
                        var dots = document.createElement('span');
                        dots.className = 'page-ellipsis';
                        dots.textContent = '…';
                        pg.appendChild(dots);
                    }
                    continue;
                }
                addBtn(p, p, false, p === currentPage);
            }
            addBtn('›', currentPage + 1, currentPage === pages, false);
        }

        // ── Chips de filtros activos ─────────────────────────────────────
        function updateActiveChips(f) {
            var wrap = document.getElementById('activeFilters');
            if (!wrap) return;
            wrap.innerHTML = '';
            var hasAny = false;

            function addChip(label, clearFn) {
                hasAny = true;
                var chip = document.createElement('div');
                chip.className = 'filter-chip';
                chip.innerHTML = label + '<button class="filter-chip-remove" aria-label="Quitar filtro">&#10005;</button>';
                chip.querySelector('button').addEventListener('click', function () { clearFn(); applyFilters(); });
                wrap.appendChild(chip);
            }

            if (f.q) addChip('Búsqueda: ' + f.q, function () { document.getElementById('fBusqueda').value = ''; });
            if (f.op) addChip('Op.: ' + f.op, function () { document.getElementById('fOperacion').value = ''; });
            if (f.user) addChip('Usuario: ' + f.user, function () { document.getElementById('fUsuario').value = ''; });
            if (f.desde) addChip('Desde: ' + f.desde, function () { document.getElementById('fFechaDesde').value = ''; });
            if (f.hasta) addChip('Hasta: ' + f.hasta, function () { document.getElementById('fFechaHasta').value = ''; });

            wrap.style.display = hasAny ? 'flex' : 'none';
        }

        function updateResultsCount() {
            var el = document.getElementById('resultsCount');
            var info = document.getElementById('resultsInfo');
            if (el) el.textContent = registrosFiltrados.length;
            if (info) info.innerHTML = 'Mostrando <strong>' + registrosFiltrados.length + '</strong> de ' + registros.length + ' registros';
        }

        // ── Export CSV ───────────────────────────────────────────────────
        function exportCSV() {
            var headers = ['ID', 'Usuario', 'Fecha', 'Operacion', 'Entidad Tipo', 'Entidad Nombre', 'Descripcion', 'IP', 'Val. Anteriores', 'Val. Nuevos'];
            var rows = [headers];

            Object.values(movData).forEach(function (m) {
                rows.push([
                    m.Id, m.Usuario, m.FechaFormateada, m.OperacionLabel,
                    m.EntidadTipo, m.EntidadNombre, m.Descripcion, m.IpAddress || '',
                    m.ValoresAnterioresJson || '', m.ValoresNuevosJson || ''
                ].map(function (v) { return '"' + String(v).replace(/"/g, '""') + '"'; }));
            });

            var csv = rows.map(function (r) { return r.join(','); }).join('\n');
            var blob = new Blob(['\uFEFF' + csv], { type: 'text/csv;charset=utf-8;' });
            var url = URL.createObjectURL(blob);
            var a = document.createElement('a');
            a.href = url;
            a.download = 'bitacora_' + new Date().toISOString().slice(0, 10) + '.csv';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            URL.revokeObjectURL(url);
            showToast('Bitácora exportada correctamente.', 'success');
        }

        // ── Toast ────────────────────────────────────────────────────────
        function showToast(msg, type) {
            var t = document.getElementById('toast');
            var ti = document.getElementById('toastIcon');
            var tm = document.getElementById('toastMsg');
            if (!t || !ti || !tm) return;
            ti.textContent = type === 'error' ? '✖' : '✔';
            tm.textContent = msg;
            t.className = 'toast ' + (type || 'success');
            t.classList.add('show');
            setTimeout(function () { t.classList.remove('show'); }, 4000);
        }

        // ── Cargar desde backend ─────────────────────────────────────────
        async function cargarBitacora() {
            try {
                var result = await postJson(apiBase + '/ListarBitacora', {});
                if (!result.Exitoso) throw new Error(result.Mensaje || 'No fue posible cargar la bitácora.');

                registros = result.Registros || [];
                movData = {};
                registros.forEach(function (m) { movData[String(m.Id)] = m; });

                actualizarKpis(result);
                poblarUsuarios(result.Usuarios || []);

                registrosFiltrados = registros.slice();
                renderPagination();
                updateResultsCount();

            } catch (error) {
                showToast(error.message || 'No fue posible cargar la bitácora.', 'error');
            }
        }

        // ── Event listeners ──────────────────────────────────────────────
        var btnApply = document.getElementById('btnApplyFilters');
        var btnClear = document.getElementById('btnClearFilters');
        var btnExport = document.getElementById('btnExportCSV');
        var fBusqueda = document.getElementById('fBusqueda');
        var pageSizeEl = document.getElementById('pageSize');

        if (btnApply) btnApply.addEventListener('click', applyFilters);
        if (btnExport) btnExport.addEventListener('click', exportCSV);
        if (pageSizeEl) pageSizeEl.addEventListener('change', function () {
            pageSize = parseInt(this.value, 10);
            currentPage = 1;
            renderPagination();
        });
        if (fBusqueda) fBusqueda.addEventListener('input', function () {
            clearTimeout(this._t);
            this._t = setTimeout(applyFilters, 280);
        });
        if (btnClear) btnClear.addEventListener('click', function () {
            document.getElementById('fBusqueda').value = '';
            document.getElementById('fOperacion').value = '';
            document.getElementById('fUsuario').value = '';
            document.getElementById('fFechaDesde').value = '';
            document.getElementById('fFechaHasta').value = '';
            applyFilters();
        });

        // Sort headers
        document.querySelectorAll('th.sortable').forEach(function (th) {
            th.addEventListener('click', function () {
                var col = th.getAttribute('data-col');
                sortState.asc = sortState.col === col ? !sortState.asc : true;
                sortState.col = col;

                document.querySelectorAll('th.sortable').forEach(function (h) {
                    h.classList.remove('sort-asc', 'sort-desc');
                    h.querySelector('.sort-icon').textContent = '⇕';
                });

                th.classList.add(sortState.asc ? 'sort-asc' : 'sort-desc');
                th.querySelector('.sort-icon').textContent = sortState.asc ? '↑' : '↓';

                applyFilters();
            });
        });

        // ── Inicio ───────────────────────────────────────────────────────
        cargarBitacora();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initBitacoraPage);
    } else {
        initBitacoraPage();
    }
})();