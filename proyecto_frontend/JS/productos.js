(function () {
    function initProductosPage() {
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape' && typeof window.closeProductosModal === 'function') {
                window.closeProductosModal();
            }
        });

        var btnTable = document.getElementById('btnTableView');
        var btnCard = document.getElementById('btnCardView');
        var tableView = document.getElementById('tableView');
        var cardView = document.getElementById('cardView');
        var tableFooterEl = document.getElementById('tableFooterEl');
        var mobileMq = window.matchMedia('(max-width: 768px)');
        var currentView = mobileMq.matches ? 'card' : 'table';

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

        if (btnTable && btnCard) {
            btnTable.addEventListener('click', function () {
                if (mobileMq.matches) return;
                setView('table');
            });

            btnCard.addEventListener('click', function () {
                if (mobileMq.matches) return;
                setView('card');
            });

            setView(mobileMq.matches ? 'card' : 'table');

            if (typeof mobileMq.addEventListener === 'function') {
                mobileMq.addEventListener('change', function (event) {
                    setView(event.matches ? 'card' : currentView);
                });
            }
        }

        var searchInput = document.getElementById('searchInput');
        var filterCategoria = document.getElementById('filterCategoria');
        var filterStock = document.getElementById('filterStock');
        var resultsCount = document.getElementById('resultsCount');
        var footerInfo = document.getElementById('footerInfo');

        function getRows() { return Array.from(document.querySelectorAll('#tableBody tr[data-codigo]')); }
        function getCards() { return Array.from(document.querySelectorAll('#cardView .prod-card')); }


        function applyFilters() {
            if (!searchInput || !filterCategoria || !filterStock || !resultsCount || !footerInfo) {
                return;
            }

            var q = searchInput.value.toLowerCase().trim();
            var cat = filterCategoria.value;
            var stk = filterStock.value;
            var rows = getRows();
            var cards = getCards();
            var visible = 0;

            rows.forEach(function (row, i) {
                var codigo = (row.getAttribute('data-codigo') || '').toLowerCase();
                var desc = (row.getAttribute('data-desc') || '').toLowerCase();
                var c = row.getAttribute('data-cat') || '';
                var s = row.getAttribute('data-stock') || '';
                var matchQ = !q || codigo.includes(q) || desc.includes(q);
                var matchCat = !cat || c === cat;
                var matchStk = !stk || s === stk;
                var show = matchQ && matchCat && matchStk;

                row.style.display = show ? '' : 'none';
                if (cards[i]) cards[i].style.display = show ? '' : 'none';
                if (show) visible++;
            });

            var noResult = document.getElementById('noSearchResult');
            if (visible === 0 && rows.length > 0) {
                if (!noResult) {
                    var tr = document.createElement('tr');
                    tr.id = 'noSearchResult';
                    tr.innerHTML = '<td colspan="7" style="text-align:center;padding:48px 24px;color:var(--clr-gray-400);font-size:13px">&#128269; No se encontraron productos con los filtros aplicados.</td>';
                    document.getElementById('tableBody').appendChild(tr);
                }
            } else if (noResult) {
                noResult.remove();
            }

            resultsCount.textContent = visible + ' producto' + (visible !== 1 ? 's' : '');
            footerInfo.textContent = 'Mostrando ' + visible + ' de ' + rows.length + ' productos';
        }

        if (searchInput && filterCategoria && filterStock) {
            searchInput.addEventListener('input', applyFilters);
            filterCategoria.addEventListener('change', applyFilters);
            filterStock.addEventListener('change', applyFilters);
            applyFilters();
        }

        document.querySelectorAll('th.sortable').forEach(function (th) {
            th.addEventListener('click', function () {
                var col = th.getAttribute('data-col');
                var tbody = document.getElementById('tableBody');
                if (!tbody) return;

                var currentSort = {
                    col: th.dataset.sortCol || null,
                    asc: th.dataset.sortAsc !== 'false'
                };

                if (currentSort.col === col) {
                    currentSort.asc = !currentSort.asc;
                } else {
                    currentSort.col = col;
                    currentSort.asc = true;
                }

                document.querySelectorAll('th.sortable').forEach(function (h) {
                    h.classList.remove('sort-asc', 'sort-desc');
                    var icon = h.querySelector('.sort-icon');
                    if (icon) icon.textContent = '⇕';
                    delete h.dataset.sortCol;
                    delete h.dataset.sortAsc;
                });

                th.classList.add(currentSort.asc ? 'sort-asc' : 'sort-desc');
                th.dataset.sortCol = currentSort.col;
                th.dataset.sortAsc = String(currentSort.asc);
                var currentIcon = th.querySelector('.sort-icon');
                if (currentIcon) currentIcon.textContent = currentSort.asc ? '↑' : '↓';

                var rows = Array.from(tbody.querySelectorAll('tr[data-codigo]'));
                rows.sort(function (a, b) {
                    var va = a.getAttribute('data-' + col) || '';
                    var vb = b.getAttribute('data-' + col) || '';
                    var na = parseFloat(va);
                    var nb = parseFloat(vb);
                    var cmp = isNaN(na) ? va.localeCompare(vb) : na - nb;
                    return currentSort.asc ? cmp : -cmp;
                });
                rows.forEach(function (r) { tbody.appendChild(r); });
            });
        });

        window.openDeleteModal = function (id, codigo, descripcion, foto) {
            var modal = document.getElementById('deleteModal');
            var modalName = document.getElementById('modalProductName');
            var modalCode = document.getElementById('modalProductCode');
            var modalImg = document.getElementById('modalProductImg');
            var modalImgPh = document.getElementById('modalImgPlaceholder');
            var btnDelete = document.getElementById('btnModalDelete');
            // fallback selector: ASP.NET may prefix client IDs, try to locate by id or name ending with hfDeleteId
            var hfDeleteId = document.getElementById('hfDeleteId') || document.querySelector('[id$="hfDeleteId"], [name$="hfDeleteId"]');

            if (!modal || !modalName || !modalCode || !modalImg || !modalImgPh || !btnDelete || !hfDeleteId) {
                return;
            }

            hfDeleteId.value = id;
            modalName.textContent = descripcion;
            modalCode.textContent = 'Código: ' + codigo;


            if (foto && foto.trim() !== '') {
                modalImg.src = foto;
                modalImg.alt = 'Foto de ' + codigo;
                modalImg.style.display = '';
                modalImgPh.style.display = 'none';
            } else {
                modalImg.style.display = 'none';
                modalImgPh.style.display = '';
            }

            modal.classList.add('open');
            btnDelete.focus();
        };

        window.closeProductosModal = function () {
            var modal = document.getElementById('deleteModal');
            var hfDeleteId = document.getElementById('hfDeleteId') || document.querySelector('[id$="hfDeleteId"], [name$="hfDeleteId"]');
            if (modal) modal.classList.remove('open');
            if (hfDeleteId) hfDeleteId.value = '';
        };

        var btnCancel = document.getElementById('btnModalCancel');
        var modal = document.getElementById('deleteModal');
        var btnDelete = document.getElementById('btnModalDelete');
        // fallback for btnDeleteConfirm in case ASP.NET prefixes the client id
        var btnDeleteConfirm = document.getElementById('btnDeleteConfirm') || document.querySelector('[id$="btnDeleteConfirm"], [name$="btnDeleteConfirm"]');


        if (btnCancel) {
            btnCancel.addEventListener('click', window.closeProductosModal);
        }

        if (modal) {
            modal.addEventListener('click', function (e) {
                if (e.target === modal) window.closeProductosModal();
            });
        }

        if (btnDelete) {
            btnDelete.addEventListener('click', function () {
                window.closeProductosModal();
                if (btnDeleteConfirm) btnDeleteConfirm.click();
            });
        }

        function showToast(msg, type) {
            var toast = document.getElementById('toast');
            var toastMsg = document.getElementById('toastMsg');
            var toastIcon = document.getElementById('toastIcon');
            if (!toast || !toastMsg || !toastIcon) return;

            toast.className = 'toast ' + (type || 'success');
            toastIcon.textContent = type === 'error' ? '✖' : '✔';
            toastMsg.textContent = msg;
            toast.classList.add('show');
            setTimeout(function () { toast.classList.remove('show'); }, 4000);
        }


        var qs = new URLSearchParams(window.location.search);
        if (qs.get('nuevo') === '1') showToast('Producto guardado correctamente.', 'success');
        if (qs.get('editado') === '1') showToast('Producto actualizado correctamente.', 'success');
        if (qs.get('eliminado') === '1') showToast('Producto eliminado correctamente.', 'success');
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initProductosPage);
    } else {
        initProductosPage();
    }
})();
