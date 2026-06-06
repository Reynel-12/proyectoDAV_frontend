(function () {
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

    document.querySelectorAll('.date-rel[data-ts]').forEach(function (el) {
        el.textContent = relativeDate(el.getAttribute('data-ts'));
    });

    var hfJson = document.getElementById('hfMovimientosJson');
    var movData = {};
    try {
        var arr = JSON.parse(hfJson ? hfJson.value : '[]');
        arr.forEach(function (m) { movData[String(m.Id)] = m; });
    } catch (_) { }

    var allRows = Array.from(document.querySelectorAll('#tableBody .data-row'));
    var allCards = Array.from(document.querySelectorAll('#cardList .log-card'));
    var currentPage = 1;
    var pageSize = 25;

    function getFilters() {
        return {
            q: document.getElementById('fBusqueda').value.toLowerCase().trim(),
            op: document.getElementById('fOperacion').value,
            user: document.getElementById('fUsuario').value.toLowerCase(),
            desde: document.getElementById('fFechaDesde').value,
            hasta: document.getElementById('fFechaHasta').value
        };
    }

    function rowMatches(el, f) {
        var busq = el.getAttribute('data-busq') || '';
        var op = el.getAttribute('data-op') || '';
        var user = (el.getAttribute('data-usuario') || '').toLowerCase();
        var fecha = el.getAttribute('data-fecha') || '';

        if (f.q && !busq.includes(f.q)) return false;
        if (f.op && op !== f.op) return false;
        if (f.user && !user.includes(f.user)) return false;
        if (f.desde && fecha.slice(0, 10) < f.desde) return false;
        if (f.hasta && fecha.slice(0, 10) > f.hasta) return false;
        return true;
    }

    function updateResultsCount(vis, total) {
        var el = document.getElementById('resultsCount');
        if (el) el.textContent = vis;
        var info = document.getElementById('resultsInfo');
        if (info) info.innerHTML = 'Mostrando <strong id="resultsCount">' + vis + '</strong> de ' + total + ' registros';
    }

    function updateActiveChips(f) {
        var wrap = document.getElementById('activeFilters');
        wrap.innerHTML = '';
        var hasAny = false;

        function addChip(label, clearFn) {
            hasAny = true;
            var chip = document.createElement('div');
            chip.className = 'filter-chip';
            chip.innerHTML = label + '<button class="filter-chip-remove" aria-label="Quitar filtro">&#10005;</button>';
            chip.querySelector('button').addEventListener('click', function () {
                clearFn();
                applyFilters();
            });
            wrap.appendChild(chip);
        }

        if (f.q) addChip('Búsqueda: ' + f.q, function () { document.getElementById('fBusqueda').value = ''; });
        if (f.op) addChip('Op.: ' + f.op, function () { document.getElementById('fOperacion').value = ''; });
        if (f.user) addChip('Usuario: ' + f.user, function () { document.getElementById('fUsuario').value = ''; });
        if (f.desde) addChip('Desde: ' + f.desde, function () { document.getElementById('fFechaDesde').value = ''; });
        if (f.hasta) addChip('Hasta: ' + f.hasta, function () { document.getElementById('fFechaHasta').value = ''; });

        wrap.style.display = hasAny ? 'flex' : 'none';
    }

    function renderPagination(visible) {
        var total = visible.length;
        var pages = Math.ceil(total / pageSize) || 1;
        var pg = document.getElementById('pagination');
        var footer = document.getElementById('footerInfo');
        var start = (currentPage - 1) * pageSize + 1;
        var end = Math.min(currentPage * pageSize, total);

        footer.textContent = total > 0
            ? 'Mostrando ' + start + '–' + end + ' de ' + total + ' registros'
            : 'Sin resultados';

        visible.forEach(function (row, i) {
            var onPage = i >= (currentPage - 1) * pageSize && i < currentPage * pageSize;
            row.style.display = onPage ? '' : 'none';
        });

        pg.innerHTML = '';
        function addBtn(label, page, disabled, isActive) {
            var btn = document.createElement('button');
            btn.className = 'page-btn' + (isActive ? ' active' : '');
            btn.textContent = label;
            btn.disabled = disabled;
            btn.setAttribute('aria-label', 'Página ' + label);
            if (!disabled && !isActive) {
                btn.addEventListener('click', function () {
                    currentPage = page;
                    renderPagination(visible);
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

    function applyFilters() {
        var f = getFilters();
        var visible = [];

        allRows.forEach(function (row) {
            var matches = rowMatches(row, f);
            row.style.display = matches ? '' : 'none';
            if (matches) visible.push(row);
        });

        allCards.forEach(function (card) {
            card.style.display = rowMatches(card, f) ? '' : 'none';
        });

        currentPage = 1;
        renderPagination(visible);
        updateActiveChips(f);
        updateResultsCount(visible.length, allRows.length);
    }

    document.getElementById('btnApplyFilters').addEventListener('click', applyFilters);
    document.getElementById('btnClearFilters').addEventListener('click', function () {
        document.getElementById('fBusqueda').value = '';
        document.getElementById('fOperacion').value = '';
        document.getElementById('fUsuario').value = '';
        document.getElementById('fFechaDesde').value = '';
        document.getElementById('fFechaHasta').value = '';
        applyFilters();
    });
    document.getElementById('fBusqueda').addEventListener('input', function () {
        clearTimeout(this._t);
        this._t = setTimeout(applyFilters, 280);
    });
    document.getElementById('pageSize').addEventListener('change', function () {
        pageSize = parseInt(this.value, 10);
        applyFilters();
    });

    applyFilters();

    var sortState = { col: null, asc: true };
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

            var tbody = document.getElementById('tableBody');
            var rows = Array.from(tbody.querySelectorAll('.data-row'));
            rows.sort(function (a, b) {
                var va = (a.getAttribute('data-' + col) || '').toLowerCase();
                var vb = (b.getAttribute('data-' + col) || '').toLowerCase();
                return sortState.asc ? va.localeCompare(vb) : vb.localeCompare(va);
            });
            rows.forEach(function (r) { tbody.appendChild(r); });
            applyFilters();
        });
    });

    document.getElementById('btnExportCSV').addEventListener('click', function () {
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
    });

    function showToast(msg, type) {
        var t = document.getElementById('toast');
        var ti = document.getElementById('toastIcon');
        var tm = document.getElementById('toastMsg');
        ti.textContent = type === 'error' ? '✖' : '✔';
        tm.textContent = msg;
        t.className = 'toast ' + (type || 'success');
        t.classList.add('show');
        setTimeout(function () { t.classList.remove('show'); }, 4000);
    }
})();
