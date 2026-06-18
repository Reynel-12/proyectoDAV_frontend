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
        var activeTrigger = null;

        var modalBackdrop = document.getElementById('bitacoraDetailModal');
        var modalBody = document.getElementById('bitacoraModalBody');
        var modalTitle = document.getElementById('bitacoraModalTitle');
        var modalSubtitle = document.getElementById('bitacoraModalSubtitle');
        var modalIcon = document.getElementById('bitacoraModalIcon');
        var modalClose = document.getElementById('bitacoraModalClose');
        var modalFooterClose = document.getElementById('bitacoraModalFooterClose');

        function esc(value) {
            return String(value == null ? '' : value)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        async function postJson(url, payload) {
            var response = await fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: JSON.stringify(payload || {})
            });

            if (!response.ok) {
                throw new Error('HTTP ' + response.status);
            }

            var result = await response.json();
            return result.d || result;
        }

        function relativeDate(isoStr) {
            if (!isoStr) return '';

            var d = new Date(isoStr);
            var now = new Date();
            var diff = Math.floor((now - d) / 1000);

            if (diff < 60) return 'Hace ' + diff + ' s';
            if (diff < 3600) return 'Hace ' + Math.floor(diff / 60) + ' min';
            if (diff < 86400) return 'Hace ' + Math.floor(diff / 3600) + ' h';
            if (diff < 604800) return 'Hace ' + Math.floor(diff / 86400) + ' dias';

            return d.toLocaleDateString('es-HN');
        }

        function updateRelativeDates() {
            document.querySelectorAll('.date-rel[data-ts]').forEach(function (el) {
                el.textContent = relativeDate(el.getAttribute('data-ts'));
            });
        }

        function getOpIcon(css) {
            switch (css) {
                case 'creacion':
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="16"></line><line x1="8" y1="12" x2="16" y2="12"></line></svg>';
                case 'edicion':
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>';
                case 'eliminacion':
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"></path><path d="M10 11v6"></path><path d="M14 11v6"></path></svg>';
                case 'entrada':
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><polyline points="19 12 12 19 5 12"></polyline></svg>';
                case 'salida':
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="19" x2="12" y2="5"></line><polyline points="5 12 12 5 19 12"></polyline></svg>';
                default:
                    return '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"></circle></svg>';
            }
        }

        function valueToText(value) {
            if (value == null || value === '') return '';
            if (typeof value === 'string') return value;
            if (typeof value === 'number' || typeof value === 'boolean') return String(value);

            try {
                return JSON.stringify(value, null, 2);
            } catch (error) {
                return String(value);
            }
        }

        function safeParseJson(json) {
            if (!json) return null;

            try {
                return JSON.parse(json);
            } catch (error) {
                return null;
            }
        }

        function toComparableMap(raw) {
            if (raw == null || raw === '') return {};
            if (Array.isArray(raw)) {
                var arrMap = {};
                raw.forEach(function (item, index) {
                    arrMap['Item ' + (index + 1)] = item;
                });
                return arrMap;
            }
            if (typeof raw === 'object') return raw;

            return { Valor: raw };
        }

        function parseComparableJson(json) {
            return toComparableMap(safeParseJson(json));
        }

        function prettyRawJson(json) {
            if (!json) return 'Sin datos';

            var parsed = safeParseJson(json);
            if (parsed == null) return json;

            try {
                return JSON.stringify(parsed, null, 2);
            } catch (error) {
                return json;
            }
        }

        function getEntityLabel(m) {
            return m.EntidadNombre || m.EntidadTipo || 'Registro';
        }

        function getSearchableText(m) {
            return [m.Usuario, m.EntidadNombre, m.Descripcion].join(' ').toLowerCase();
        }

        function renderRow(m) {
            var tr = document.createElement('tr');
            tr.className = 'data-row';
            tr.setAttribute('data-id', m.Id);
            tr.setAttribute('data-usuario', m.Usuario);
            tr.setAttribute('data-fecha', m.FechaISO);
            tr.setAttribute('data-op', m.OperacionCss);
            tr.setAttribute('data-entidad', m.EntidadNombre);
            tr.setAttribute('data-busq', getSearchableText(m));
            tr.setAttribute('tabindex', '0');
            tr.setAttribute('role', 'button');
            tr.setAttribute('aria-label', 'Ver detalle completo de ' + getEntityLabel(m));

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
                '<td><span class="table-ip" title="' + esc(m.IpAddress || 'N/A') + '">' + esc(m.IpAddress || 'N/A') + '</span></td>' +
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

        function renderCard(m) {
            var article = document.createElement('article');
            article.className = 'log-card';
            article.setAttribute('data-id', m.Id);
            article.setAttribute('data-usuario', m.Usuario);
            article.setAttribute('data-op', m.OperacionCss);
            article.setAttribute('data-entidad', m.EntidadNombre);
            article.setAttribute('data-busq', getSearchableText(m));
            article.setAttribute('data-fecha', m.FechaISO);
            article.setAttribute('tabindex', '0');
            article.setAttribute('role', 'button');
            article.setAttribute('aria-label', 'Abrir detalle completo de ' + getEntityLabel(m));

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
                    '<div class="log-card-field"><dt class="log-card-field-label">Direccion IP</dt><dd class="log-card-field-val log-card-field-ip">' + esc(m.IpAddress || 'N/A') + '</dd></div>' +
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
                    '<span class="log-card-field-label">Descripcion</span>' +
                    '<p class="log-card-desc-text">' + esc(m.Descripcion || 'Sin descripcion disponible.') + '</p>' +
                '</div>' +
                '<div class="log-card-open">Ver informacion completa</div>';

            return article;
        }

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

            if (pnlEmpty) {
                pnlEmpty.style.display = lista.length === 0 ? '' : 'none';
            }

            updateRelativeDates();
        }

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
                if (el) {
                    el.textContent = ids[id] || 0;
                }
            });
        }

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
            var busq = getSearchableText(m);
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
            registrosFiltrados = registros.filter(function (m) {
                return registroMatches(m, f);
            });

            if (sortState.col) {
                sortRegistros();
            }

            currentPage = 1;
            renderPagination();
            updateActiveChips(f);
            updateResultsCount();
        }

        function sortRegistros() {
            var col = sortState.col;
            var asc = sortState.asc;

            registrosFiltrados.sort(function (a, b) {
                var va = (a[col] || '').toString().toLowerCase();
                var vb = (b[col] || '').toString().toLowerCase();
                return asc ? va.localeCompare(vb) : vb.localeCompare(va);
            });
        }

        function renderPagination() {
            var total = registrosFiltrados.length;
            var pages = Math.ceil(total / pageSize) || 1;
            var pg = document.getElementById('pagination');
            var footer = document.getElementById('footerInfo');
            var start = total === 0 ? 0 : (currentPage - 1) * pageSize + 1;
            var end = Math.min(currentPage * pageSize, total);

            if (footer) {
                footer.textContent = total > 0
                    ? 'Mostrando ' + start + '-' + end + ' de ' + total + ' registros'
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

            addBtn('<', currentPage - 1, currentPage === 1, false);

            for (var p = 1; p <= pages; p++) {
                var hideMiddle = pages > 7 && ((p > 2 && p < currentPage - 1) || (p > currentPage + 1 && p < pages - 1));
                if (hideMiddle) {
                    if (p === 3 || p === pages - 2) {
                        var dots = document.createElement('span');
                        dots.className = 'page-ellipsis';
                        dots.textContent = '...';
                        pg.appendChild(dots);
                    }
                    continue;
                }

                addBtn(p, p, false, p === currentPage);
            }

            addBtn('>', currentPage + 1, currentPage === pages, false);
        }

        function updateActiveChips(f) {
            var wrap = document.getElementById('activeFilters');
            if (!wrap) return;

            wrap.innerHTML = '';
            var hasAny = false;

            function addChip(label, clearFn) {
                hasAny = true;
                var chip = document.createElement('div');
                chip.className = 'filter-chip';
                chip.innerHTML = esc(label) + '<button class="filter-chip-remove" aria-label="Quitar filtro">&#10005;</button>';
                chip.querySelector('button').addEventListener('click', function () {
                    clearFn();
                    applyFilters();
                });
                wrap.appendChild(chip);
            }

            if (f.q) addChip('Busqueda: ' + f.q, function () { document.getElementById('fBusqueda').value = ''; });
            if (f.op) addChip('Operacion: ' + f.op, function () { document.getElementById('fOperacion').value = ''; });
            if (f.user) addChip('Usuario: ' + f.user, function () { document.getElementById('fUsuario').value = ''; });
            if (f.desde) addChip('Desde: ' + f.desde, function () { document.getElementById('fFechaDesde').value = ''; });
            if (f.hasta) addChip('Hasta: ' + f.hasta, function () { document.getElementById('fFechaHasta').value = ''; });

            wrap.style.display = hasAny ? 'flex' : 'none';
        }

        function updateResultsCount() {
            var el = document.getElementById('resultsCount');
            var info = document.getElementById('resultsInfo');

            if (el) {
                el.textContent = registrosFiltrados.length;
            }

            if (info) {
                info.innerHTML = 'Mostrando <strong>' + registrosFiltrados.length + '</strong> de ' + registros.length + ' registros';
            }
        }

        function exportCSV() {
            var headers = ['ID', 'Usuario', 'Fecha', 'Operacion', 'Entidad Tipo', 'Entidad Nombre', 'Descripcion', 'IP', 'Val. Anteriores', 'Val. Nuevos'];
            var rows = [headers];

            Object.values(movData).forEach(function (m) {
                rows.push([
                    m.Id,
                    m.Usuario,
                    m.FechaFormateada,
                    m.OperacionLabel,
                    m.EntidadTipo,
                    m.EntidadNombre,
                    m.Descripcion,
                    m.IpAddress || '',
                    m.ValoresAnterioresJson || '',
                    m.ValoresNuevosJson || ''
                ].map(function (v) {
                    return '"' + String(v).replace(/"/g, '""') + '"';
                }));
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
            showToast('Bitacora exportada correctamente.', 'success');
        }

        function showToast(msg, type) {
            var t = document.getElementById('toast');
            var ti = document.getElementById('toastIcon');
            var tm = document.getElementById('toastMsg');
            if (!t || !ti || !tm) return;

            ti.textContent = type === 'error' ? 'X' : 'OK';
            tm.textContent = msg;
            t.className = 'toast ' + (type || 'success');
            t.classList.add('show');

            setTimeout(function () {
                t.classList.remove('show');
            }, 4000);
        }

        function buildJsonListHtml(data) {
            var keys = Object.keys(data || {});
            if (!keys.length) {
                return '<p class="modal-json-value empty">Sin informacion disponible.</p>';
            }

            return '<div class="modal-json-list">' + keys.map(function (key) {
                var text = valueToText(data[key]);
                return '' +
                    '<div class="modal-json-row">' +
                        '<span class="modal-json-key">' + esc(key) + '</span>' +
                        '<pre class="modal-json-value' + (text ? '' : ' empty') + '">' + esc(text || 'Sin valor') + '</pre>' +
                    '</div>';
            }).join('') + '</div>';
        }

        function buildDiffTableHtml(prevMap, nextMap) {
            var keysMap = {};

            Object.keys(prevMap).forEach(function (key) { keysMap[key] = true; });
            Object.keys(nextMap).forEach(function (key) { keysMap[key] = true; });

            var keys = Object.keys(keysMap);
            if (!keys.length) {
                return '<p class="modal-json-value empty">No hay campos comparables para mostrar.</p>';
            }

            keys.sort(function (a, b) {
                return a.localeCompare(b);
            });

            var rows = keys.map(function (key) {
                var prevText = valueToText(prevMap[key]);
                var nextText = valueToText(nextMap[key]);
                var changed = prevText !== nextText;

                return '' +
                    '<tr class="' + (changed ? 'row-changed' : '') + '">' +
                        '<td class="diff-field-name">' + esc(key) + '</td>' +
                        '<td class="diff-cell"><span class="diff-val-cell prev' + (prevText ? '' : ' empty') + '">' + esc(prevText || 'Sin valor') + '</span></td>' +
                        '<td class="diff-cell">' + (changed ? '<span class="diff-changed-icon" aria-hidden="true">&#9888;</span>' : '<span class="diff-ok-icon" aria-hidden="true">&#8226;</span>') + '</td>' +
                        '<td class="diff-cell"><span class="diff-val-cell next' + (nextText ? '' : ' empty') + '">' + esc(nextText || 'Sin valor') + '</span></td>' +
                    '</tr>';
            }).join('');

            return '' +
                '<table class="diff-table">' +
                    '<thead>' +
                        '<tr>' +
                            '<th>Campo</th>' +
                            '<th>Anterior</th>' +
                            '<th>Cambio</th>' +
                            '<th>Nuevo</th>' +
                        '</tr>' +
                    '</thead>' +
                    '<tbody>' + rows + '</tbody>' +
                '</table>';
        }

        function openDetailModalById(id, triggerEl) {
            var record = movData[String(id)];
            if (!record || !modalBackdrop || !modalBody) return;

            activeTrigger = triggerEl || document.activeElement;

            var prevMap = parseComparableJson(record.ValoresAnterioresJson);
            var nextMap = parseComparableJson(record.ValoresNuevosJson);
            var relative = relativeDate(record.FechaISO);
            var entityLabel = getEntityLabel(record);

            modalTitle.textContent = 'Detalle del movimiento #' + record.Id;
            modalSubtitle.textContent = record.OperacionLabel + ' sobre ' + (record.EntidadTipo || 'registro');
            modalIcon.className = 'modal-header-icon log-card-icon ' + record.OperacionCss;
            modalIcon.innerHTML = getOpIcon(record.OperacionCss);

            modalBody.innerHTML = '' +
                '<div class="modal-meta-strip">' +
                    '<div class="modal-meta-item">' +
                        '<span class="modal-meta-label">Usuario</span>' +
                        '<span class="modal-meta-val">' + esc(record.Usuario || 'Sin usuario') + '</span>' +
                    '</div>' +
                    '<div class="modal-meta-item">' +
                        '<span class="modal-meta-label">Fecha y hora</span>' +
                        '<span class="modal-meta-val">' + esc(record.FechaFormateada || 'Sin fecha') + '</span>' +
                    '</div>' +
                    '<div class="modal-meta-item">' +
                        '<span class="modal-meta-label">Referencia</span>' +
                        '<span class="modal-meta-val">ID ' + esc(record.Id) + (relative ? ' · ' + esc(relative) : '') + '</span>' +
                    '</div>' +
                '</div>' +
                '<section class="modal-summary-card">' +
                    '<div class="modal-summary-main">' +
                        '<div class="modal-summary-kicker">' +
                            '<span class="op-pill ' + esc(record.OperacionCss) + '"><span class="op-dot" aria-hidden="true"></span>' + esc(record.OperacionLabel || 'Movimiento') + '</span>' +
                        '</div>' +
                        '<div class="modal-summary-entity">' + esc(entityLabel) + '</div>' +
                        '<p class="modal-summary-desc">' + esc(record.Descripcion || 'Sin descripcion disponible.') + '</p>' +
                    '</div>' +
                    '<div class="modal-summary-side">' +
                        '<div class="modal-side-card">' +
                            '<span class="modal-side-label">Entidad</span>' +
                            '<span class="modal-side-value">' + esc(record.EntidadTipo || 'No definida') + '</span>' +
                        '</div>' +
                        '<div class="modal-side-card">' +
                            '<span class="modal-side-label">Direccion IP</span>' +
                            '<span class="modal-side-value ip">' + esc(record.IpAddress || 'N/A') + '</span>' +
                        '</div>' +
                    '</div>' +
                '</section>' +
                '<section>' +
                    '<div class="modal-section-title">Comparacion de cambios</div>' +
                    buildDiffTableHtml(prevMap, nextMap) +
                '</section>' +
                '<section class="modal-panels-grid">' +
                    '<article class="modal-json-panel prev-panel">' +
                        '<div class="modal-json-header">' +
                            '<span class="modal-json-title">Valores anteriores</span>' +
                        '</div>' +
                        '<div class="modal-json-body">' + buildJsonListHtml(prevMap) + '</div>' +
                    '</article>' +
                    '<article class="modal-json-panel next-panel">' +
                        '<div class="modal-json-header">' +
                            '<span class="modal-json-title">Valores nuevos</span>' +
                        '</div>' +
                        '<div class="modal-json-body">' + buildJsonListHtml(nextMap) + '</div>' +
                    '</article>' +
                '</section>' +
                '<section>' +
                    '<div class="modal-section-title">Datos completos en bruto</div>' +
                    '<div class="modal-raw-grid">' +
                        '<article class="modal-raw-card">' +
                            '<div class="modal-raw-header">JSON anterior</div>' +
                            '<pre class="modal-raw-body">' + esc(prettyRawJson(record.ValoresAnterioresJson)) + '</pre>' +
                        '</article>' +
                        '<article class="modal-raw-card">' +
                            '<div class="modal-raw-header">JSON nuevo</div>' +
                            '<pre class="modal-raw-body">' + esc(prettyRawJson(record.ValoresNuevosJson)) + '</pre>' +
                        '</article>' +
                    '</div>' +
                '</section>';

            modalBackdrop.classList.add('open');
            modalBackdrop.setAttribute('aria-hidden', 'false');
            document.body.style.overflow = 'hidden';

            window.setTimeout(function () {
                if (modalClose) {
                    modalClose.focus();
                }
            }, 0);
        }

        function closeDetailModal() {
            if (!modalBackdrop) return;

            modalBackdrop.classList.remove('open');
            modalBackdrop.setAttribute('aria-hidden', 'true');
            document.body.style.overflow = '';

            if (activeTrigger && typeof activeTrigger.focus === 'function') {
                activeTrigger.focus();
            }

            activeTrigger = null;
        }

        async function cargarBitacora() {
            try {
                var result = await postJson(apiBase + '/ListarBitacora', {});
                if (!result.Exitoso) {
                    throw new Error(result.Mensaje || 'No fue posible cargar la bitacora.');
                }

                registros = result.Registros || [];
                movData = {};

                registros.forEach(function (m) {
                    movData[String(m.Id)] = m;
                });

                actualizarKpis(result);
                poblarUsuarios(result.Usuarios || []);

                registrosFiltrados = registros.slice();
                renderPagination();
                updateResultsCount();
            } catch (error) {
                showToast(error.message || 'No fue posible cargar la bitacora.', 'error');
            }
        }

        var btnApply = document.getElementById('btnApplyFilters');
        var btnClear = document.getElementById('btnClearFilters');
        var btnExport = document.getElementById('btnExportCSV');
        var fBusqueda = document.getElementById('fBusqueda');
        var pageSizeEl = document.getElementById('pageSize');
        var tableBody = document.getElementById('tableBody');
        var cardList = document.getElementById('cardList');

        if (btnApply) btnApply.addEventListener('click', applyFilters);
        if (btnExport) btnExport.addEventListener('click', exportCSV);

        if (pageSizeEl) {
            pageSizeEl.addEventListener('change', function () {
                pageSize = parseInt(this.value, 10) || 25;
                currentPage = 1;
                renderPagination();
            });
        }

        if (fBusqueda) {
            fBusqueda.addEventListener('input', function () {
                clearTimeout(this._t);
                this._t = setTimeout(applyFilters, 280);
            });
        }

        if (btnClear) {
            btnClear.addEventListener('click', function () {
                document.getElementById('fBusqueda').value = '';
                document.getElementById('fOperacion').value = '';
                document.getElementById('fUsuario').value = '';
                document.getElementById('fFechaDesde').value = '';
                document.getElementById('fFechaHasta').value = '';
                applyFilters();
            });
        }

        document.querySelectorAll('th.sortable').forEach(function (th) {
            th.addEventListener('click', function () {
                var col = th.getAttribute('data-col');
                sortState.asc = sortState.col === col ? !sortState.asc : true;
                sortState.col = col;

                document.querySelectorAll('th.sortable').forEach(function (header) {
                    header.classList.remove('sort-asc', 'sort-desc');
                    header.setAttribute('aria-sort', 'none');
                });

                th.classList.add(sortState.asc ? 'sort-asc' : 'sort-desc');
                th.setAttribute('aria-sort', sortState.asc ? 'ascending' : 'descending');

                applyFilters();
            });
        });

        function handleDetailTrigger(eventTarget) {
            var row = eventTarget.closest('[data-id]');
            if (!row) return;

            openDetailModalById(row.getAttribute('data-id'), row);
        }

        if (tableBody) {
            tableBody.addEventListener('click', function (event) {
                handleDetailTrigger(event.target);
            });

            tableBody.addEventListener('keydown', function (event) {
                if (event.key !== 'Enter' && event.key !== ' ') return;
                event.preventDefault();
                handleDetailTrigger(event.target);
            });
        }

        if (cardList) {
            cardList.addEventListener('click', function (event) {
                handleDetailTrigger(event.target);
            });

            cardList.addEventListener('keydown', function (event) {
                if (event.key !== 'Enter' && event.key !== ' ') return;
                event.preventDefault();
                handleDetailTrigger(event.target);
            });
        }

        if (modalClose) {
            modalClose.addEventListener('click', closeDetailModal);
        }

        if (modalFooterClose) {
            modalFooterClose.addEventListener('click', closeDetailModal);
        }

        if (modalBackdrop) {
            modalBackdrop.addEventListener('click', function (event) {
                if (event.target === modalBackdrop) {
                    closeDetailModal();
                }
            });
        }

        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape' && modalBackdrop && modalBackdrop.classList.contains('open')) {
                closeDetailModal();
            }
        });

        cargarBitacora();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initBitacoraPage);
    } else {
        initBitacoraPage();
    }
})();
