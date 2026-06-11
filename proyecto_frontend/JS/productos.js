(function () {
    function initProductosPage() {
        var main = document.getElementById('main-content');
        if (!main) {
            return;
        }

        var apiBase = main.getAttribute('data-api-base') || '';
        if (!apiBase) {
            return;
        }

        var btnTable = document.getElementById('btnTableView');
        var btnCard = document.getElementById('btnCardView');
        var tableView = document.getElementById('tableView');
        var cardView = document.getElementById('cardView');
        var tableFooterEl = document.getElementById('tableFooterEl');
        var tableBody = document.getElementById('tableBody');
        var totalCountLabel = document.getElementById('totalCountLabel');
        var emptyState = document.getElementById('emptyState');
        var searchInput = document.getElementById('searchInput');
        var filterCategoria = document.getElementById('filterCategoria');
        var filterStock = document.getElementById('filterStock');
        var resultsCount = document.getElementById('resultsCount');
        var footerInfo = document.getElementById('footerInfo');
        var mobileMq = window.matchMedia('(max-width: 768px)');
        var currentView = mobileMq.matches ? 'card' : 'table';
        var currentDeleteItem = null;
        var productos = [];
        var filteredProducts = [];
        var currentSort = { col: 'codigo', asc: true };

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

        function escapeHtml(value) {
            return String(value || '')
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#39;');
        }

        function formatMoney(value) {
            var amount = Number(value || 0);
            return 'L ' + amount.toLocaleString('es-HN', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            });
        }

        function getCategoryName(producto) {
            return producto.CategoriaNombre || producto.Categoria || '';
        }

        function resolvePhotoUrl(path) {
            if (!path) {
                return '';
            }

            if (/^https?:\/\//i.test(path)) {
                return path;
            }

            var normalized = String(path).replace(/^~\//, '').replace(/^\/+/, '');
            var origin = apiBase.replace(/\/productos\.asmx$/i, '');
            return origin + '/' + normalized;
        }

        function setView(view) {
            if (!tableView || !cardView || !tableFooterEl || !btnTable || !btnCard) {
                return;
            }

            currentView = view;
            if (view === 'card') {
                tableView.classList.add('hidden');
                cardView.classList.add('visible');
                tableFooterEl.style.display = 'none';
                btnCard.classList.add('active');
                btnCard.setAttribute('aria-pressed', 'true');
                btnTable.classList.remove('active');
                btnTable.setAttribute('aria-pressed', 'false');
            } else {
                tableView.classList.remove('hidden');
                cardView.classList.remove('visible');
                tableFooterEl.style.display = '';
                btnTable.classList.add('active');
                btnTable.setAttribute('aria-pressed', 'true');
                btnCard.classList.remove('active');
                btnCard.setAttribute('aria-pressed', 'false');
            }
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

        async function postJson(url, payload) {
            var response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=utf-8'
                },
                body: JSON.stringify(payload || {})
            });

            if (!response.ok) {
                throw new Error('HTTP ' + response.status);
            }

            var result = await response.json();
            return result.d || result;
        }

        function renderCategorias(categorias) {
            if (!filterCategoria) {
                return;
            }

            filterCategoria.innerHTML = '<option value="">Todas las categorías</option>';
            (categorias || []).forEach(function (categoria) {
                var option = document.createElement('option');
                option.value = categoria;
                option.textContent = categoria;
                filterCategoria.appendChild(option);
            });
        }

        function sortProducts(list) {
            var col = currentSort.col;
            var asc = currentSort.asc;

            list.sort(function (a, b) {
                var va = a[col];
                var vb = b[col];

                if (typeof va === 'string') {
                    va = va.toLowerCase();
                    vb = String(vb || '').toLowerCase();
                }

                var cmp = 0;
                if (va < vb) cmp = -1;
                if (va > vb) cmp = 1;
                return asc ? cmp : -cmp;
            });
        }

        function renderProducts() {
            if (!tableBody || !cardView) {
                return;
            }

            tableBody.innerHTML = '';
            cardView.innerHTML = '';

            filteredProducts.forEach(function (producto) {
                var fotoUrl = resolvePhotoUrl(producto.Fotografia);
                var tableRow = document.createElement('tr');
                tableRow.setAttribute('data-codigo', producto.Codigo);
                tableRow.setAttribute('data-desc', producto.Descripcion || '');
                tableRow.setAttribute('data-cat', getCategoryName(producto));
                tableRow.setAttribute('data-stock', producto.StockEstado || '');
                tableRow.setAttribute('data-existencia', producto.Existencia);
                tableRow.setAttribute('data-preciocompra', producto.PrecioCompra);
                tableRow.setAttribute('data-precioventa', producto.PrecioVenta);
                tableRow.innerHTML =
                    '<td>' +
                        '<div class="prod-thumb-wrap">' +
                            (fotoUrl
                                ? '<img class="prod-thumb" src="' + escapeHtml(fotoUrl) + '" alt="Foto de ' + escapeHtml(producto.Codigo) + '" loading="lazy" />'
                                : '<div class="prod-thumb-placeholder" aria-hidden="true"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="3" width="20" height="18" rx="2" stroke="currentColor" stroke-width="1.5" fill="none"/><path d="M9 11L6 16H18L15 13L12 15L9 11Z" stroke="currentColor" stroke-width="1.5" fill="none"/><circle cx="16.5" cy="8.5" r="1.5" fill="currentColor" stroke="currentColor" stroke-width="1"/></svg></div>') +
                            '<div>' +
                                '<div class="prod-codigo">' + escapeHtml(producto.Codigo) + '</div>' +
                                '<div class="prod-desc" title="' + escapeHtml(producto.Descripcion) + '">' + escapeHtml(producto.Descripcion) + '</div>' +
                            '</div>' +
                        '</div>' +
                    '</td>' +
                    '<td><span class="cat-pill">' + escapeHtml(getCategoryName(producto)) + '</span></td>' +
                    '<td class="td-center"><span class="stock-badge ' + escapeHtml(producto.StockEstado) + '"><span class="stock-dot"></span>' + escapeHtml(producto.Existencia) + ' uds</span></td>' +
                    '<td class="td-center"><span class="tax-pill">' + escapeHtml(producto.Impuesto) + '%</span></td>' +
                    '<td><div class="price-val">' + formatMoney(producto.PrecioCompra) + '</div><div class="price-label">Costo</div></td>' +
                    '<td><div class="price-val">' + formatMoney(producto.PrecioVenta) + '</div><div class="price-label">Venta</div></td>' +
                    '<td class="td-center">' +
                        '<div class="action-wrap">' +
                            '<a class="btn-action edit" href="editarProducto.aspx?id=' + encodeURIComponent(producto.Codigo) + '" title="Editar producto ' + escapeHtml(producto.Codigo) + '" aria-label="Editar ' + escapeHtml(producto.Codigo) + '">' +
                                '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none" /></svg>' +
                            '</a>' +
                            '<button class="btn-action del js-delete-product" type="button" data-codigo="' + escapeHtml(producto.Codigo) + '" title="Eliminar producto ' + escapeHtml(producto.Codigo) + '" aria-label="Eliminar ' + escapeHtml(producto.Codigo) + '">' +
                                '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" /><path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" /><path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" /><path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none" /><path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none" /></svg>' +
                            '</button>' +
                        '</div>' +
                    '</td>';

                var card = document.createElement('div');
                card.className = 'prod-card';
                card.setAttribute('data-codigo', producto.Codigo);
                card.setAttribute('data-desc', producto.Descripcion || '');
                card.setAttribute('data-cat', getCategoryName(producto));
                card.setAttribute('data-stock', producto.StockEstado || '');
                card.innerHTML =
                    (fotoUrl
                        ? '<img class="prod-card-img" src="' + escapeHtml(fotoUrl) + '" alt="Fotografía de ' + escapeHtml(producto.Codigo) + '" loading="lazy" />'
                        : '<div class="prod-card-img-placeholder" aria-hidden="true"><svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="3" width="20" height="18" rx="2" stroke="currentColor" stroke-width="1.5" fill="none"/><path d="M9 11L6 16H18L15 13L12 15L9 11Z" stroke="currentColor" stroke-width="1.5" fill="none"/><circle cx="16.5" cy="8.5" r="1.5" fill="currentColor" stroke="currentColor" stroke-width="1"/></svg></div>') +
                    '<div class="prod-card-body">' +
                        '<div class="prod-card-row"><span class="prod-card-code">' + escapeHtml(producto.Codigo) + '</span><span class="cat-pill">' + escapeHtml(getCategoryName(producto)) + '</span></div>' +
                        '<div class="prod-card-desc" title="' + escapeHtml(producto.Descripcion) + '">' + escapeHtml(producto.Descripcion) + '</div>' +
                        '<div class="prod-card-meta">' +
                            '<div><div class="meta-item-label">P. Compra</div><div class="meta-item-val">' + formatMoney(producto.PrecioCompra) + '</div></div>' +
                            '<div><div class="meta-item-label">P. Venta</div><div class="meta-item-val">' + formatMoney(producto.PrecioVenta) + '</div></div>' +
                            '<div><div class="meta-item-label">ISV</div><div class="meta-item-val">' + escapeHtml(producto.Impuesto) + '%</div></div>' +
                            '<div><div class="meta-item-label">Existencia</div><div><span class="stock-badge ' + escapeHtml(producto.StockEstado) + '"><span class="stock-dot"></span>' + escapeHtml(producto.Existencia) + ' uds</span></div></div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="prod-card-footer">' +
                        '<a class="btn-card-edit" href="editarProducto.aspx?id=' + encodeURIComponent(producto.Codigo) + '" aria-label="Editar ' + escapeHtml(producto.Codigo) + '">' +
                            '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none" /></svg>' +
                            'Editar' +
                        '</a>' +
                        '<button class="btn-card-del js-delete-product" type="button" data-codigo="' + escapeHtml(producto.Codigo) + '" aria-label="Eliminar ' + escapeHtml(producto.Codigo) + '">' +
                            '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 7H20" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" /><path d="M10 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" /><path d="M14 11V16" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" /><path d="M5 7L6 19C6 20.1 6.9 21 8 21H16C17.1 21 18 20.1 18 19L19 7" stroke="currentColor" stroke-width="1.5" fill="none" /><path d="M9 7V4C9 3.4 9.4 3 10 3H14C14.6 3 15 3.4 15 4V7" stroke="currentColor" stroke-width="1.5" fill="none" /></svg>' +
                            'Eliminar' +
                        '</button>' +
                    '</div>';

                tableBody.appendChild(tableRow);
                cardView.appendChild(card);
            });

            if (emptyState) {
                emptyState.style.display = filteredProducts.length === 0 ? '' : 'none';
            }
        }

        function applyFilters() {
            var q = (searchInput && searchInput.value || '').toLowerCase().trim();
            var categoria = filterCategoria ? filterCategoria.value : '';
            var stock = filterStock ? filterStock.value : '';

            filteredProducts = productos.filter(function (producto) {
                var matchQ = !q ||
                    String(producto.Codigo).toLowerCase().indexOf(q) >= 0 ||
                    String(producto.Descripcion || '').toLowerCase().indexOf(q) >= 0 ||
                    String(getCategoryName(producto)).toLowerCase().indexOf(q) >= 0;

                var matchCategoria = !categoria || getCategoryName(producto) === categoria;
                var matchStock = !stock || producto.StockEstado === stock;
                return matchQ && matchCategoria && matchStock;
            });

            sortProducts(filteredProducts);
            renderProducts();

            if (resultsCount) {
                resultsCount.textContent = filteredProducts.length + ' producto' + (filteredProducts.length === 1 ? '' : 's');
            }

            if (footerInfo) {
                footerInfo.textContent = 'Mostrando ' + filteredProducts.length + ' de ' + productos.length + ' productos';
            }

            if (totalCountLabel) {
                totalCountLabel.textContent = String(productos.length);
            }
        }

        function syncSortHeaders() {
            document.querySelectorAll('th.sortable').forEach(function (th) {
                th.classList.remove('sort-asc', 'sort-desc');
                if (th.getAttribute('data-col') === currentSort.col) {
                    th.classList.add(currentSort.asc ? 'sort-asc' : 'sort-desc');
                }
            });
        }

        function openDeleteModal(producto) {
            currentDeleteItem = producto;

            var modal = document.getElementById('deleteModal');
            var modalName = document.getElementById('modalProductName');
            var modalCode = document.getElementById('modalProductCode');
            var modalImg = document.getElementById('modalProductImg');
            var modalImgPh = document.getElementById('modalImgPlaceholder');

            if (!modal || !modalName || !modalCode || !modalImg || !modalImgPh) {
                return;
            }

            modalName.textContent = producto.Descripcion;
            modalCode.textContent = 'Código: ' + producto.Codigo;

            var fotoUrl = resolvePhotoUrl(producto.Fotografia);
            if (fotoUrl) {
                modalImg.src = fotoUrl;
                modalImg.alt = 'Foto de ' + producto.Codigo;
                modalImg.style.display = '';
                modalImgPh.style.display = 'none';
            } else {
                modalImg.style.display = 'none';
                modalImgPh.style.display = '';
            }

            modal.classList.add('open');
        }

        function closeDeleteModal() {
            var modal = document.getElementById('deleteModal');
            if (modal) {
                modal.classList.remove('open');
            }
            currentDeleteItem = null;
        }

        async function eliminarProductoActual() {
            if (!currentDeleteItem) {
                return;
            }

            var btnDelete = document.getElementById('btnModalDelete');
            if (btnDelete) {
                btnDelete.disabled = true;
            }

            try {
                var result = await postJson(apiBase + '/EliminarProducto', {
                    codigo: currentDeleteItem.Codigo,
                    usuario: getUsuarioActual()
                });

                if (!result.Exitoso) {
                    throw new Error(result.Mensaje || 'No fue posible eliminar el producto.');
                }

                productos = productos.filter(function (item) {
                    return item.Codigo !== currentDeleteItem.Codigo;
                });

                closeDeleteModal();
                applyFilters();
                showToast(result.Mensaje || 'Producto eliminado correctamente.', 'success');
            } catch (error) {
                showToast(error.message || 'No fue posible eliminar el producto.', 'error');
            } finally {
                if (btnDelete) {
                    btnDelete.disabled = false;
                }
            }
        }

        async function cargarProductos() {
            try {
                var result = await postJson(apiBase + '/ListarProductos', {});
                if (!result.Exitoso) {
                    throw new Error(result.Mensaje || 'No fue posible cargar los productos.');
                }

                productos = result.Productos || [];
                filteredProducts = productos.slice();
                renderCategorias(result.Categorias || []);
                syncSortHeaders();
                applyFilters();
            } catch (error) {
                showToast(error.message || 'No fue posible cargar los productos.', 'error');
            }
        }

        if (btnTable && btnCard) {
            btnTable.addEventListener('click', function () {
                if (!mobileMq.matches) {
                    setView('table');
                }
            });

            btnCard.addEventListener('click', function () {
                if (!mobileMq.matches) {
                    setView('card');
                }
            });
        }

        setView(mobileMq.matches ? 'card' : 'table');

        if (typeof mobileMq.addEventListener === 'function') {
            mobileMq.addEventListener('change', function (event) {
                setView(event.matches ? 'card' : currentView);
            });
        }

        if (searchInput) {
            searchInput.addEventListener('input', applyFilters);
        }
        if (filterCategoria) {
            filterCategoria.addEventListener('change', applyFilters);
        }
        if (filterStock) {
            filterStock.addEventListener('change', applyFilters);
        }

        document.querySelectorAll('th.sortable').forEach(function (th) {
            th.addEventListener('click', function () {
                var col = th.getAttribute('data-col');
                if (currentSort.col === col) {
                    currentSort.asc = !currentSort.asc;
                } else {
                    currentSort.col = col;
                    currentSort.asc = true;
                }

                syncSortHeaders();
                applyFilters();
            });
        });

        document.addEventListener('click', function (event) {
            var deleteButton = event.target.closest('.js-delete-product');
            if (deleteButton) {
                var codigo = parseInt(deleteButton.getAttribute('data-codigo'), 10);
                var producto = productos.find(function (item) {
                    return item.Codigo === codigo;
                });

                if (producto) {
                    openDeleteModal(producto);
                }
            }
        });

        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                closeDeleteModal();
            }
        });

        var modal = document.getElementById('deleteModal');
        var btnCancel = document.getElementById('btnModalCancel');
        var btnDelete = document.getElementById('btnModalDelete');

        if (btnCancel) {
            btnCancel.addEventListener('click', closeDeleteModal);
        }

        if (modal) {
            modal.addEventListener('click', function (event) {
                if (event.target === modal) {
                    closeDeleteModal();
                }
            });
        }

        if (btnDelete) {
            btnDelete.addEventListener('click', eliminarProductoActual);
        }

        var qs = new URLSearchParams(window.location.search);
        if (qs.get('nuevo') === '1') showToast('Producto guardado correctamente.', 'success');
        if (qs.get('editado') === '1') showToast('Producto actualizado correctamente.', 'success');

        cargarProductos();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initProductosPage);
    } else {
        initProductosPage();
    }
})();
