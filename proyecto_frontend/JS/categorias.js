(function () {
    function initCategoriasPage() {
        var main = document.getElementById('main-content');
        if (!main) {
            return;
        }

        var apiBase = main.getAttribute('data-api-base') || '';
        if (!apiBase) {
            return;
        }

        var tabCards = document.getElementById('tabCards');
        var tabTable = document.getElementById('tabTable');
        var viewCards = document.getElementById('viewCards');
        var viewTable = document.getElementById('viewTable');
        var searchInput = document.getElementById('searchInput');
        var resultsCount = document.getElementById('resultsCount');
        var catGrid = document.getElementById('catGrid');
        var tableBody = document.getElementById('tableBody');
        var totalEl = document.getElementById('litTotal');
        var totalKpiEl = document.getElementById('litTotalKpi');
        var activasKpiEl = document.getElementById('litActivasKpi');
        var productosKpiEl = document.getElementById('litProductosKpi');
        var modal = document.getElementById('deleteModal');
        var btnDelete = document.getElementById('btnModalDelete');
        var btnCancel = document.getElementById('btnModalCancel');
        var categorias = [];
        var filtradas = [];
        var actualDelete = null;

        var iconos = ['&#128187;', '&#128203;', '&#128230;', '&#9881;', '&#128717;', '&#128736;', '&#128218;', '&#128295;'];

        function getUsuarioActual() {
            try {
                var raw = sessionStorage.getItem('usuario') || localStorage.getItem('usuario');
                if (!raw) {
                    return 'Sistema web';
                }

                var usuario = JSON.parse(raw);
                return usuario.Usuario || usuario.Nombre || 'Sistema web';
            } catch (error) {
                return 'Sistema web';
            }
        }

        function decodeHtml(value) {
            var tmp = document.createElement('textarea');
            tmp.innerHTML = value || '';
            return tmp.value;
        }

        function escapeHtml(value) {
            return String(value || '')
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        function formatDate(value) {
            if (!value) {
                return '';
            }

            var date = new Date(value);
            if (isNaN(date.getTime())) {
                return '';
            }

            return date.toLocaleDateString('es-HN');
        }

        function showToast(message, type) {
            var toast = document.getElementById('toast');
            var toastMsg = document.getElementById('toastMsg');
            var toastIcon = document.getElementById('toastIcon');

            if (!toast || !toastMsg || !toastIcon) {
                return;
            }

            toast.className = 'toast ' + (type || 'success');
            toastIcon.textContent = type === 'error' ? '✖' : '✔';
            toastMsg.textContent = message;
            toast.classList.add('show');

            window.setTimeout(function () {
                toast.classList.remove('show');
            }, 4000);
        }

        var mensaje = sessionStorage.getItem('mensajeCategoria');
        var tipo = sessionStorage.getItem('tipoMensajeCategoria');

        if (mensaje) {
            showToast(mensaje, tipo || 'success');

            sessionStorage.removeItem('mensajeCategoria');
            sessionStorage.removeItem('tipoMensajeCategoria');
        }

        async function postJson(url, payload) {
            var response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=utf-8'
                },
                body: JSON.stringify(payload || {})
            });

            console.log('Status:', response.status);

            var text = await response.text();
            console.log('Respuesta cruda:', text);

            var result = JSON.parse(text);

            return result.d || result;
        }

        function buildVisualData(categoria, index) {
            return {
                colorIdx: (index % 8) + 1,
                icono: decodeHtml(iconos[index % iconos.length])
            };
        }

        function actualizarResumen() {
            var total = categorias.length;
            var activas = categorias.filter(function (categoria) { return !!categoria.Estado; }).length;
            var productos = categorias.reduce(function (acc, categoria) {
                return acc + Number(categoria.CantProductos || 0);
            }, 0);

            if (totalEl) totalEl.textContent = total;
            if (totalKpiEl) totalKpiEl.textContent = total;
            if (activasKpiEl) activasKpiEl.textContent = activas;
            if (productosKpiEl) productosKpiEl.textContent = productos;
        }

        function renderEmptyState() {
            if (!catGrid) {
                return;
            }

            catGrid.innerHTML =
                '<div class="empty-state">' +
                    '<div class="empty-icon" aria-hidden="true">' +
                        '<svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">' +
                            '<path d="M4 6L10 4L20 6L22 12L20 18L14 20L4 18L2 12L4 6Z" stroke="currentColor" stroke-width="1.5" fill="none"/>' +
                            '<circle cx="12" cy="12" r="2" stroke="currentColor" stroke-width="1.5" fill="none"/>' +
                        '</svg>' +
                    '</div>' +
                    '<div class="empty-title">No hay categorías registradas</div>' +
                    '<div class="empty-desc">Crea la primera categoría para organizar tus productos.</div>' +
                    '<a class="btn-new" href="nuevaCategoria.aspx">Crear primera categoría</a>' +
                '</div>';

            if (tableBody) {
                tableBody.innerHTML = '<tr><td colspan="6" style="text-align:center;padding:40px;color:var(--clr-gray-400);">No hay categorías registradas.</td></tr>';
            }
        }

        function renderCategorias() {
            if (!catGrid || !tableBody) {
                return;
            }

            if (!filtradas.length) {
                if (!categorias.length) {
                    renderEmptyState();
                } else {
                    catGrid.innerHTML =
                        '<div class="empty-state"><div class="empty-title">Sin resultados</div><div class="empty-desc">Prueba con otro término de búsqueda.</div></div>';
                    tableBody.innerHTML = '<tr><td colspan="6" style="text-align:center;padding:40px;color:var(--clr-gray-400);">Sin resultados para la búsqueda actual.</td></tr>';
                }

                if (resultsCount) {
                    resultsCount.textContent = '0 categorías';
                }
                return;
            }

            catGrid.innerHTML = '';
            tableBody.innerHTML = '';

            filtradas.forEach(function (categoria, index) {
                var visual = buildVisualData(categoria, index);
                var estadoTexto = categoria.Estado ? 'Activa' : 'Inactiva';
                var estadoClase = categoria.Estado ? 'activa' : 'inactiva';
                var fecha = formatDate(categoria.FechaRegistro);

                var card = document.createElement('div');
                card.className = 'cat-card';
                card.setAttribute('data-nombre', categoria.Nombre || '');
                card.setAttribute('data-activa', categoria.Estado ? 'true' : 'false');
                card.innerHTML =
                    '<div class="cat-card-header">' +
                        '<div class="cat-icon-wrap" style="background: var(--cat-bg-' + visual.colorIdx + '); color: var(--cat-clr-' + visual.colorIdx + ')" aria-hidden="true">' + visual.icono + '</div>' +
                        '<div class="cat-card-info">' +
                            '<div class="cat-name">' + escapeHtml(categoria.Nombre) + '</div>' +
                            '<div class="cat-desc">' + escapeHtml(categoria.Descripcion || '') + '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="cat-card-meta">' +
                        '<div class="meta-chip"><span class="meta-chip-dot"></span><span><strong>' + Number(categoria.CantProductos || 0) + '</strong> productos</span></div>' +
                        '<span class="cat-status-pill ' + estadoClase + '">' + estadoTexto + '</span>' +
                    '</div>' +
                    '<div class="cat-card-footer">' +
                        '<span class="cat-date">Creada ' + escapeHtml(fecha) + '</span>' +
                        '<a class="btn-action edit" href="editarCategoria.aspx?id=' + encodeURIComponent(categoria.Id) + '" aria-label="Editar categoría ' + escapeHtml(categoria.Nombre) + '">' +
                            '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none"/></svg>' +
                        '</a>' +
                        '<button class="btn-action del js-delete-category" type="button" data-id="' + categoria.Id + '" aria-label="Eliminar categoría ' + escapeHtml(categoria.Nombre) + '">' +
                            '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/><path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/><path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/><path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none"/><path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none"/></svg>' +
                        '</button>' +
                    '</div>';

                var row = document.createElement('tr');
                row.setAttribute('data-nombre', categoria.Nombre || '');
                row.setAttribute('data-activa', categoria.Estado ? 'true' : 'false');
                row.innerHTML =
                    '<td><div class="td-icon-name"><div class="tbl-cat-icon" style="background: var(--cat-bg-' + visual.colorIdx + '); color: var(--cat-clr-' + visual.colorIdx + ')" aria-hidden="true">' + visual.icono + '</div><span class="tbl-cat-name">' + escapeHtml(categoria.Nombre) + '</span></div></td>' +
                    '<td><span class="tbl-desc" title="' + escapeHtml(categoria.Descripcion || '') + '">' + escapeHtml(categoria.Descripcion || '') + '</span></td>' +
                    '<td class="td-center"><strong>' + Number(categoria.CantProductos || 0) + '</strong></td>' +
                    '<td class="td-center"><span class="cat-status-pill ' + estadoClase + '">' + estadoTexto + '</span></td>' +
                    '<td class="td-center">' + escapeHtml(fecha) + '</td>' +
                    '<td class="td-center"><div class="action-wrap"><a class="btn-action edit" href="editarCategoria.aspx?id=' + encodeURIComponent(categoria.Id) + '" aria-label="Editar categoría ' + escapeHtml(categoria.Nombre) + '"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none"/></svg></a><button class="btn-action del js-delete-category" type="button" data-id="' + categoria.Id + '" aria-label="Eliminar categoría ' + escapeHtml(categoria.Nombre) + '"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/><path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/><path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/><path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none"/><path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none"/></svg></button></div></td>';

                catGrid.appendChild(card);
                tableBody.appendChild(row);
            });

            if (resultsCount) {
                resultsCount.textContent = filtradas.length + ' categoría' + (filtradas.length === 1 ? '' : 's');
            }
        }

        function aplicarBusqueda() {
            var q = searchInput ? searchInput.value.toLowerCase().trim() : '';
            filtradas = categorias.filter(function (categoria) {
                return !q ||
                    String(categoria.Nombre || '').toLowerCase().indexOf(q) >= 0 ||
                    String(categoria.Descripcion || '').toLowerCase().indexOf(q) >= 0;
            });

            renderCategorias();
        }

        function showCardsView() {
            if (!tabCards || !tabTable || !viewCards || !viewTable) {
                return;
            }

            tabCards.classList.add('active');
            tabCards.setAttribute('aria-selected', 'true');
            tabTable.classList.remove('active');
            tabTable.setAttribute('aria-selected', 'false');
            viewCards.style.display = '';
            viewTable.classList.remove('visible');
        }

        function showTableView() {
            if (!tabCards || !tabTable || !viewCards || !viewTable) {
                return;
            }

            tabTable.classList.add('active');
            tabTable.setAttribute('aria-selected', 'true');
            tabCards.classList.remove('active');
            tabCards.setAttribute('aria-selected', 'false');
            viewTable.classList.add('visible');
            viewCards.style.display = 'none';
        }

        function closeModal() {
            actualDelete = null;
            if (modal) {
                modal.classList.remove('open');
            }
        }

        function openDeleteModal(categoria) {
            actualDelete = categoria;
            if (!modal) {
                return;
            }

            var modalName = document.getElementById('modalCatName');
            var modalCount = document.getElementById('modalCatCount');
            var modalIcon = document.getElementById('modalCatIcon');
            var visual = buildVisualData(categoria, categoria.Id || 0);

            if (modalName) modalName.textContent = categoria.Nombre || '';
            if (modalCount) {
                modalCount.textContent = Number(categoria.CantProductos || 0) > 0
                    ? categoria.CantProductos + ' producto' + (categoria.CantProductos === 1 ? '' : 's') + ' asignado' + (categoria.CantProductos === 1 ? '' : 's')
                    : 'Sin productos asignados';
            }
            if (modalIcon) {
                modalIcon.textContent = visual.icono;
                modalIcon.style.background = 'var(--cat-bg-' + visual.colorIdx + ')';
                modalIcon.style.color = 'var(--cat-clr-' + visual.colorIdx + ')';
            }

            modal.classList.add('open');
            if (btnDelete) {
                btnDelete.focus();
            }
        }

        async function eliminarCategoria() {
            if (!actualDelete) {
                return;
            }

            try {
                var result = await postJson(apiBase + '/EliminarCategoria', {
                    id: actualDelete.Id,
                    usuario: getUsuarioActual()
                });

                if (!result.Exitoso) {
                    throw new Error(result.Mensaje || 'No fue posible eliminar la categoría.');
                }

                categorias = categorias.filter(function (categoria) {
                    return categoria.Id !== actualDelete.Id;
                });

                actualizarResumen();
                aplicarBusqueda();
                closeModal();
                showToast(result.Mensaje || 'Categoría eliminada correctamente.', 'success');
            } catch (error) {
                closeModal();
                showToast(error.message || 'No fue posible eliminar la categoría.', 'error');
            }
        }

        async function cargarCategorias() {
            try {
                console.log('Consultando API...');

                var result = await postJson(apiBase + '/ListarCategorias', {});

                console.log('Respuesta API:', result);

                if (!result.Exitoso) {
                    throw new Error(result.Mensaje);
                }

                categorias = result.Categorias || [];
                actualizarResumen();
                aplicarBusqueda();
            }
            catch (error) {
                console.error('Error completo:', error);

                alert(error.message);

                showToast(error.message || 'No fue posible cargar las categorías.', 'error');
            }
        }

        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                closeModal();
            }
        });

        if (tabCards) {
            tabCards.addEventListener('click', function (event) {
                event.preventDefault();
                showCardsView();
            });
        }

        if (tabTable) {
            tabTable.addEventListener('click', function (event) {
                event.preventDefault();
                showTableView();
            });
        }

        if (searchInput) {
            searchInput.addEventListener('input', aplicarBusqueda);
        }

        if (btnCancel) {
            btnCancel.addEventListener('click', closeModal);
        }

        if (modal) {
            modal.addEventListener('click', function (event) {
                if (event.target === modal) {
                    closeModal();
                }
            });
        }

        if (btnDelete) {
            btnDelete.addEventListener('click', eliminarCategoria);
        }

        document.addEventListener('click', function (event) {
            var deleteButton = event.target.closest('.js-delete-category');
            if (!deleteButton) {
                return;
            }

            var id = parseInt(deleteButton.getAttribute('data-id') || '0', 10);
            var categoria = categorias.find(function (item) {
                return item.Id === id;
            });

            if (categoria) {
                openDeleteModal(categoria);
            }
        });

        var qs = new URLSearchParams(window.location.search);
        if (qs.get('nueva') === '1') showToast('Categoría creada correctamente.', 'success');
        if (qs.get('editada') === '1') showToast('Categoría actualizada correctamente.', 'success');

        showCardsView();
        cargarCategorias();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initCategoriasPage);
    } else {
        initCategoriasPage();
    }
})();
