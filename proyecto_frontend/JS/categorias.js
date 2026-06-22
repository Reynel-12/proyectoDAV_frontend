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
        var filterEstado = document.getElementById('filterEstado');
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
        var actualToggle = null;
        var productosCache = null;
        var productosApiBase = apiBase.replace(/categorias\.asmx$/i, 'productos.asmx');

        var iconos = ['&#128187;', '&#128203;', '&#128230;', '&#9881;', '&#128717;', '&#128736;', '&#128218;', '&#128295;'];

        var SVG_TOGGLE_SMALL =
            '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">' +
                '<path d="M12 2V12" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>' +
                '<path d="M6.8 5.2A8 8 0 1 0 17.2 5.2" stroke="currentColor" stroke-width="1.5" fill="none" stroke-linecap="round"/>' +
            '</svg>';

        var SVG_ACTIVATE_SMALL =
            '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">' +
                '<circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.5" fill="none"/>' +
                '<path d="M8 12L11 15L16 9" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>' +
            '</svg>';

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

            var text = await response.text();
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

        function buildToggleButton(categoria, extraClass) {
            var activa = !!categoria.Estado;
            var cls = ['btn-action', activa ? 'del' : '', 'js-toggle-category', extraClass || '']
                .filter(Boolean).join(' ');
            var iconStyle = activa ? '' : ' style="color:#16a34a"';
            var accion = activa ? 'Desactivar' : 'Activar';
            var svg = activa ? SVG_TOGGLE_SMALL : SVG_ACTIVATE_SMALL;

            return '<button class="' + cls + '" type="button"' +
                ' data-id="' + categoria.Id + '"' +
                ' data-estado="' + (activa ? 'true' : 'false') + '"' +
                ' aria-label="' + accion + ' categoría ' + escapeHtml(categoria.Nombre) + '"' +
                iconStyle + '>' +
                svg +
                '</button>';
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
                if (!categoria.Estado) {
                    card.style.opacity = '0.65';
                }
                card.innerHTML =
                    '<div class="cat-card-header">' +
                        '<div class="cat-icon-wrap" style="background: var(--cat-bg-' + visual.colorIdx + '); color: var(--cat-clr-' + visual.colorIdx + ')" aria-hidden="true">' + visual.icono + '</div>' +
                        '<div class="cat-card-info">' +
                            '<div class="cat-name">' + escapeHtml(categoria.Nombre) + '</div>' +
                            '<div class="cat-desc">' + escapeHtml(categoria.Descripcion || '') + '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="cat-card-meta">' +
                        '<button type="button" class="meta-chip meta-chip-btn js-ver-productos" data-cat-id="' + categoria.Id + '" aria-label="Ver productos de ' + escapeHtml(categoria.Nombre) + '">' +
                            '<span class="meta-chip-dot"></span>' +
                            '<span><strong>' + Number(categoria.CantProductos || 0) + '</strong> productos</span>' +
                        '</button>' +
                        '<span class="cat-status-pill ' + estadoClase + '">' + estadoTexto + '</span>' +
                    '</div>' +
                    '<div class="cat-card-footer">' +
                        '<span class="cat-date">Creada ' + escapeHtml(fecha) + '</span>' +
                        '<a class="btn-action edit" href="editarCategoria.aspx?id=' + encodeURIComponent(categoria.Id) + '" aria-label="Editar categoría ' + escapeHtml(categoria.Nombre) + '">' +
                            '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none"/></svg>' +
                        '</a>' +
                        buildToggleButton(categoria) +
                    '</div>';

                var row = document.createElement('tr');
                row.setAttribute('data-nombre', categoria.Nombre || '');
                row.setAttribute('data-activa', categoria.Estado ? 'true' : 'false');
                if (!categoria.Estado) {
                    row.style.opacity = '0.65';
                }
                row.innerHTML =
                    '<td><div class="td-icon-name"><div class="tbl-cat-icon" style="background: var(--cat-bg-' + visual.colorIdx + '); color: var(--cat-clr-' + visual.colorIdx + ')" aria-hidden="true">' + visual.icono + '</div><span class="tbl-cat-name">' + escapeHtml(categoria.Nombre) + '</span></div></td>' +
                    '<td><span class="tbl-desc" title="' + escapeHtml(categoria.Descripcion || '') + '">' + escapeHtml(categoria.Descripcion || '') + '</span></td>' +
                    '<td class="td-center"><button type="button" class="td-prod-count-btn js-ver-productos" data-cat-id="' + categoria.Id + '" title="Ver productos de ' + escapeHtml(categoria.Nombre) + '">' + Number(categoria.CantProductos || 0) + '</button></td>' +
                    '<td class="td-center"><span class="cat-status-pill ' + estadoClase + '">' + estadoTexto + '</span></td>' +
                    '<td class="td-center">' + escapeHtml(fecha) + '</td>' +
                    '<td class="td-center"><div class="action-wrap">' +
                        '<a class="btn-action edit" href="editarCategoria.aspx?id=' + encodeURIComponent(categoria.Id) + '" aria-label="Editar categoría ' + escapeHtml(categoria.Nombre) + '"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none"/></svg></a>' +
                        buildToggleButton(categoria) +
                    '</div></td>';

                catGrid.appendChild(card);
                tableBody.appendChild(row);
            });

            if (resultsCount) {
                resultsCount.textContent = filtradas.length + ' categoría' + (filtradas.length === 1 ? '' : 's');
            }
        }

        function aplicarBusqueda() {
            var q = searchInput ? searchInput.value.toLowerCase().trim() : '';
            var estado = filterEstado ? filterEstado.value : 'activo';

            filtradas = categorias.filter(function (categoria) {
                var matchQ = !q ||
                    String(categoria.Nombre || '').toLowerCase().indexOf(q) >= 0 ||
                    String(categoria.Descripcion || '').toLowerCase().indexOf(q) >= 0;

                var activa = !!categoria.Estado;
                var matchEstado = !estado ||
                    (estado === 'activo' && activa) ||
                    (estado === 'inactivo' && !activa);

                return matchQ && matchEstado;
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
            actualToggle = null;
            if (modal) {
                modal.classList.remove('open');
            }
        }

        function openToggleModal(categoria) {
            actualToggle = categoria;
            if (!modal) {
                return;
            }

            var activa = !!categoria.Estado;
            var modalTitle = document.getElementById('modalTitle');
            var modalSubtitle = document.getElementById('modalSubtitle');
            var modalWarningText = document.getElementById('modalWarningText');
            var modalName = document.getElementById('modalCatName');
            var modalCount = document.getElementById('modalCatCount');
            var modalIcon = document.getElementById('modalCatIcon');
            var visual = buildVisualData(categoria, categoria.Id || 0);

            if (modalTitle) {
                modalTitle.textContent = activa ? 'Desactivar categoría' : 'Activar categoría';
            }
            if (modalSubtitle) {
                modalSubtitle.textContent = activa
                    ? 'La categoría quedará inactiva y no estará disponible para nuevos productos.'
                    : 'La categoría volverá a estar activa y disponible para los productos.';
            }
            if (modalWarningText) {
                if (activa) {
                    var numActivos = Number(categoria.CantProductosActivos || 0);
                    var numTotal = Number(categoria.CantProductos || 0);
                    if (numActivos > 0) {
                        modalWarningText.textContent = 'Esta categoría tiene ' + numActivos + ' producto' + (numActivos === 1 ? '' : 's') +
                            ' activo' + (numActivos === 1 ? '' : 's') + '. Desactívalos primero desde la página de productos.';
                    } else if (numTotal > 0) {
                        modalWarningText.textContent = 'La categoría tiene ' + numTotal + ' producto' + (numTotal === 1 ? '' : 's') +
                            ' inactivo' + (numTotal === 1 ? '' : 's') + '. Puedes desactivarla sin problema.';
                    } else {
                        modalWarningText.textContent = 'La categoría quedará inactiva. Podrás reactivarla en cualquier momento.';
                    }
                } else {
                    modalWarningText.textContent = 'La categoría volverá a estar activa y disponible para los productos.';
                }
            }
            if (btnDelete) {
                btnDelete.textContent = activa ? 'Sí, desactivar' : 'Sí, activar';
            }

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

        async function toggleCategoria() {
            if (!actualToggle) {
                return;
            }

            var nuevoEstado = !actualToggle.Estado;

            try {
                var result = await postJson(apiBase + '/CambiarEstadoCategoria', {
                    id: actualToggle.Id,
                    estado: nuevoEstado,
                    usuario: getUsuarioActual()
                });

                if (!result.Exitoso) {
                    throw new Error(result.Mensaje || 'No fue posible cambiar el estado de la categoría.');
                }

                var idActualizado = actualToggle.Id;
                categorias = categorias.map(function (cat) {
                    if (cat.Id === idActualizado) {
                        cat.Estado = nuevoEstado;
                    }
                    return cat;
                });

                actualizarResumen();
                aplicarBusqueda();
                closeModal();
                showToast(result.Mensaje || 'Estado actualizado correctamente.', 'success');
            } catch (error) {
                closeModal();
                showToast(error.message || 'No fue posible cambiar el estado de la categoría.', 'error');
            }
        }

        function closeProductosModal() {
            var pModal = document.getElementById('productosModal');
            if (pModal) {
                pModal.classList.remove('open');
            }
        }

        async function openProductosModal(categoria) {
            var pModal = document.getElementById('productosModal');
            var titleEl = document.getElementById('modalProductosTitle');
            var subtitleEl = document.getElementById('modalProductosSubtitle');
            var listEl = document.getElementById('modalProductosList');

            if (!pModal || !listEl) {
                return;
            }

            if (titleEl) titleEl.textContent = categoria.Nombre;
            if (subtitleEl) subtitleEl.textContent = 'Cargando productos...';
            listEl.innerHTML = '<div class="modal-prod-empty">Cargando...</div>';
            pModal.classList.add('open');

            try {
                if (!productosCache) {
                    var result = await postJson(productosApiBase + '/ListarProductos', {});
                    if (!result.Exitoso) {
                        throw new Error(result.Mensaje || 'Error al cargar productos.');
                    }
                    productosCache = result.Productos || [];
                }

                var prods = productosCache.filter(function (p) {
                    return p.CategoriaId === categoria.Id;
                });

                if (subtitleEl) {
                    subtitleEl.textContent = prods.length === 0
                        ? 'Sin productos asignados'
                        : prods.length + ' producto' + (prods.length === 1 ? '' : 's') + ' asignado' + (prods.length === 1 ? '' : 's');
                }

                if (prods.length === 0) {
                    listEl.innerHTML = '<div class="modal-prod-empty">Esta categoría no tiene productos asignados.</div>';
                } else {
                    listEl.innerHTML = prods.map(function (prod) {
                        var activo = prod.Estado !== false;
                        return '<div class="modal-prod-item' + (activo ? '' : ' inactivo') + '">' +
                            '<div class="modal-prod-info">' +
                                '<span class="modal-prod-codigo">#' + escapeHtml(String(prod.Codigo)) + '</span>' +
                                '<span class="modal-prod-desc" title="' + escapeHtml(prod.Descripcion) + '">' + escapeHtml(prod.Descripcion) + '</span>' +
                            '</div>' +
                            '<span class="cat-status-pill ' + (activo ? 'activa' : 'inactiva') + '" style="flex-shrink:0">' + (activo ? 'Activo' : 'Inactivo') + '</span>' +
                        '</div>';
                    }).join('');
                }
            } catch (error) {
                listEl.innerHTML = '<div class="modal-prod-empty">No fue posible cargar los productos.</div>';
                if (subtitleEl) subtitleEl.textContent = '';
            }
        }

        async function cargarCategorias() {
            try {
                var result = await postJson(apiBase + '/ListarCategorias', {});

                if (!result.Exitoso) {
                    throw new Error(result.Mensaje);
                }

                categorias = result.Categorias || [];
                actualizarResumen();
                aplicarBusqueda();
            }
            catch (error) {
                showToast(error.message || 'No fue posible cargar las categorías.', 'error');
            }
        }

        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                closeModal();
                closeProductosModal();
            }
        });

        var btnCerrarProductos = document.getElementById('btnCerrarProductos');
        if (btnCerrarProductos) {
            btnCerrarProductos.addEventListener('click', closeProductosModal);
        }

        var productosModalEl = document.getElementById('productosModal');
        if (productosModalEl) {
            productosModalEl.addEventListener('click', function (event) {
                if (event.target === productosModalEl) {
                    closeProductosModal();
                }
            });
        }

        document.addEventListener('click', function (event) {
            var verBtn = event.target.closest('.js-ver-productos');
            if (!verBtn) {
                return;
            }

            var catId = parseInt(verBtn.getAttribute('data-cat-id') || '0', 10);
            var categoria = categorias.find(function (c) {
                return c.Id === catId;
            });

            if (categoria) {
                openProductosModal(categoria);
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

        if (filterEstado) {
            filterEstado.addEventListener('change', aplicarBusqueda);
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
            btnDelete.addEventListener('click', toggleCategoria);
        }

        document.addEventListener('click', function (event) {
            var toggleButton = event.target.closest('.js-toggle-category');
            if (!toggleButton) {
                return;
            }

            var id = parseInt(toggleButton.getAttribute('data-id') || '0', 10);
            var categoria = categorias.find(function (item) {
                return item.Id === id;
            });

            if (categoria) {
                openToggleModal(categoria);
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
