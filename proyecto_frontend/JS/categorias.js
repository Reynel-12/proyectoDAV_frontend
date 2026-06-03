(function () {
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && typeof closeModal === 'function') { closeModal(); } });
    /* view tabs */
    var tabCards = document.getElementById('tabCards');
    var tabTable = document.getElementById('tabTable');
    var viewCards = document.getElementById('viewCards');
    var viewTable = document.getElementById('viewTable');

    tabCards.addEventListener('click', function () {
        tabCards.classList.add('active'); tabCards.setAttribute('aria-selected', 'true');
        tabTable.classList.remove('active'); tabTable.setAttribute('aria-selected', 'false');
        viewCards.style.display = ''; viewTable.classList.remove('visible');
        applySearch();
    });
    tabTable.addEventListener('click', function () {
        tabTable.classList.add('active'); tabTable.setAttribute('aria-selected', 'true');
        tabCards.classList.remove('active'); tabCards.setAttribute('aria-selected', 'false');
        viewTable.classList.add('visible'); viewCards.style.display = 'none';
        applySearch();
    });

    /* search */
    var searchInput = document.getElementById('searchInput');
    var resultsCount = document.getElementById('resultsCount');

    function applySearch() {
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

        /* no-result row */
        var noRes = document.getElementById('noSearchResult');
        if (visible === 0 && cards.length > 0) {
            if (!noRes) {
                var tr = document.createElement('tr');
                tr.id = 'noSearchResult';
                tr.innerHTML = '<td colspan="6" style="text-align:center;padding:40px;color:var(--clr-gray-400);font-size:13px">&#128269; Sin resultados para "' + searchInput.value + '".</td>';
                document.getElementById('tableBody').appendChild(tr);
            }
        } else { if (noRes) noRes.remove(); }
    }

    searchInput.addEventListener('input', applySearch);
    applySearch();

    /* delete modal */
    var modal = document.getElementById('deleteModal');
    var modalName = document.getElementById('modalCatName');
    var modalCount = document.getElementById('modalCatCount');
    var modalIcon = document.getElementById('modalCatIcon');
    var btnCancel = document.getElementById('btnModalCancel');
    var btnDelete = document.getElementById('btnModalDelete');
    var hfDeleteId = document.getElementById('<%= hfDeleteId.ClientID %>');
    var btnConfirm = document.getElementById('<%= btnDeleteConfirm.ClientID %>');

    window.openDeleteModal = function (id, nombre, cantProductos, icono, colorIdx) {
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
    function closeModal() { modal.classList.remove('open'); hfDeleteId.value = ''; }
    btnCancel.addEventListener('click', closeModal);
    modal.addEventListener('click', function (e) { if (e.target === modal) closeModal(); });
    btnDelete.addEventListener('click', function () { closeModal(); if (btnConfirm) btnConfirm.click(); });

    /* toast */
    function showToast(msg, type) {
        var t = document.getElementById('toast');
        document.getElementById('toastIcon').textContent = type === 'error' ? '✖' : '✔';
        document.getElementById('toastMsg').textContent = msg;
        t.className = 'toast ' + (type || 'success');
        t.classList.add('show');
        setTimeout(function () { t.classList.remove('show'); }, 4000);
    }
    var qs = new URLSearchParams(window.location.search);
    if (qs.get('nueva') === '1') showToast('Categoría creada correctamente.', 'success');
    if (qs.get('editada') === '1') showToast('Categoría actualizada correctamente.', 'success');
    if (qs.get('eliminada') === '1') showToast('Categoría eliminada correctamente.', 'success');
})();

