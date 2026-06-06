(function () {
    function initCategoriasPage() {
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape' && typeof window.closeCategoriasModal === 'function') {
                window.closeCategoriasModal();
            }
        });

        var tabCards = document.getElementById('tabCards');
        var tabTable = document.getElementById('tabTable');
        var viewCards = document.getElementById('viewCards');
        var viewTable = document.getElementById('viewTable');
        var searchInput = document.getElementById('searchInput');
        var resultsCount = document.getElementById('resultsCount');

        function applySearch() {
            if (!searchInput || !resultsCount) {
                return;
            }

            var q = searchInput.value.toLowerCase().trim();
            var cards = Array.from(document.querySelectorAll('#catGrid .cat-card'));
            var rows = Array.from(document.querySelectorAll('#tableBody tr[data-nombre]'));
            var visible = 0;

            cards.forEach(function (c, i) {
                var nombre = (c.getAttribute('data-nombre') || '').toLowerCase();
                var show = !q || nombre.includes(q);
                c.style.display = show ? '' : 'none';
                if (rows[i]) rows[i].style.display = show ? '' : 'none';
                if (show) visible++;
            });

            resultsCount.textContent = visible + ' categoría' + (visible !== 1 ? 's' : '');

            var noRes = document.getElementById('noSearchResult');
            if (visible === 0 && cards.length > 0) {
                if (!noRes) {
                    var tr = document.createElement('tr');
                    tr.id = 'noSearchResult';
                    tr.innerHTML = '<td colspan="6" style="text-align:center;padding:40px;color:var(--clr-gray-400);font-size:13px">&#128269; Sin resultados para "' + searchInput.value + '".</td>';
                    document.getElementById('tableBody').appendChild(tr);
                }
            } else if (noRes) {
                noRes.remove();
            }
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
            applySearch();
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
            applySearch();
        }

        if (tabCards && tabTable) {
            tabCards.addEventListener('click', function (e) {
                e.preventDefault();
                showCardsView();
            });

            tabTable.addEventListener('click', function (e) {
                e.preventDefault();
                showTableView();
            });

            showCardsView();
        }

        if (searchInput) {
            searchInput.addEventListener('input', applySearch);
            applySearch();
        }

        window.openDeleteModal = function (id, nombre, cantProductos, icono, colorIdx) {
            var modal = document.getElementById('deleteModal');
            var modalName = document.getElementById('modalCatName');
            var modalCount = document.getElementById('modalCatCount');
            var modalIcon = document.getElementById('modalCatIcon');
            var btnDelete = document.getElementById('btnModalDelete');
            var hfDeleteId = document.getElementById('hfDeleteId');

            if (!modal || !modalName || !modalCount || !modalIcon || !btnDelete || !hfDeleteId) {
                return;
            }

            hfDeleteId.value = id;
            modalName.textContent = nombre;
            modalIcon.textContent = decodeURIComponent(icono);
            modalIcon.style.background = 'var(--cat-bg-' + colorIdx + ')';
            modalIcon.style.color = 'var(--cat-clr-' + colorIdx + ')';

            var c = parseInt(cantProductos, 10);
            modalCount.textContent = c > 0
                ? c + ' producto' + (c !== 1 ? 's' : '') + ' asignado' + (c !== 1 ? 's' : '')
                : 'Sin productos asignados';

            modal.classList.add('open');
            btnDelete.focus();
        };

        window.closeCategoriasModal = function () {
            var modal = document.getElementById('deleteModal');
            var hfDeleteId = document.getElementById('hfDeleteId');
            if (modal) modal.classList.remove('open');
            if (hfDeleteId) hfDeleteId.value = '';
        };

        var btnCancel = document.getElementById('btnModalCancel');
        var modal = document.getElementById('deleteModal');
        var btnDelete = document.getElementById('btnModalDelete');
        var btnConfirm = document.getElementById('btnDeleteConfirm');

        if (btnCancel) {
            btnCancel.addEventListener('click', window.closeCategoriasModal);
        }

        if (modal) {
            modal.addEventListener('click', function (e) {
                if (e.target === modal) window.closeCategoriasModal();
            });
        }

        if (btnDelete) {
            btnDelete.addEventListener('click', function () {
                window.closeCategoriasModal();
                if (btnConfirm) btnConfirm.click();
            });
        }

        function showToast(msg, type) {
            var t = document.getElementById('toast');
            var icon = document.getElementById('toastIcon');
            var msgEl = document.getElementById('toastMsg');
            if (!t || !icon || !msgEl) return;

            icon.textContent = type === 'error' ? '✖' : '✔';
            msgEl.textContent = msg;
            t.className = 'toast ' + (type || 'success');
            t.classList.add('show');
            setTimeout(function () { t.classList.remove('show'); }, 4000);
        }

        var qs = new URLSearchParams(window.location.search);
        if (qs.get('nueva') === '1') showToast('Categoría creada correctamente.', 'success');
        if (qs.get('editada') === '1') showToast('Categoría actualizada correctamente.', 'success');
        if (qs.get('eliminada') === '1') showToast('Categoría eliminada correctamente.', 'success');
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initCategoriasPage);
    } else {
        initCategoriasPage();
    }
})();
