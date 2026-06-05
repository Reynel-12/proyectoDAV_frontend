(function () {
    var btnTable = document.getElementById('btnTableView');
    var btnCard = document.getElementById('btnCardView');
    var tableView = document.getElementById('tableView');
    var cardView = document.getElementById('cardView');
    var mobileMq = window.matchMedia('(max-width: 768px)');
    var currentView = mobileMq.matches ? 'card' : 'table';

    function setView(view) {
        currentView = view;
        if (!tableView || !cardView || !btnTable || !btnCard) {
            return;
        }

        if (view === 'card') {
            tableView.classList.add('hidden');
            cardView.classList.add('visible');
            btnCard.classList.add('active');
            btnCard.setAttribute('aria-pressed', 'true');
            btnTable.classList.remove('active');
            btnTable.setAttribute('aria-pressed', 'false');
        } else {
            tableView.classList.remove('hidden');
            cardView.classList.remove('visible');
            btnTable.classList.add('active');
            btnTable.setAttribute('aria-pressed', 'true');
            btnCard.classList.remove('active');
            btnCard.setAttribute('aria-pressed', 'false');
        }
    }

    if (btnTable && btnCard) {
        btnTable.addEventListener('click', function () {
            if (!mobileMq.matches) setView('table');
        });

        btnCard.addEventListener('click', function () {
            if (!mobileMq.matches) setView('card');
        });
    }

    setView(currentView);

    if (typeof mobileMq.addEventListener === 'function') {
        mobileMq.addEventListener('change', function (event) {
            setView(event.matches ? 'card' : currentView);
        });
    }

    var searchInput = document.getElementById('searchInput');
    var filterRol = document.getElementById('filterRol');
    var filterEstado = document.getElementById('filterEstado');
    var resultsCount = document.getElementById('resultsCount');

    function getRows() { return Array.from(document.querySelectorAll('#tableBody .user-row')); }
    function getCards() { return Array.from(document.querySelectorAll('#cardView .user-card')); }

    function applyFilters() {
        var query = ((searchInput && searchInput.value) || '').toLowerCase().trim();
        var rol = filterRol ? filterRol.value : '';
        var estado = filterEstado ? filterEstado.value : '';
        var rows = getRows();
        var cards = getCards();
        var visible = 0;

        rows.forEach(function (row, index) {
            var nombre = (row.getAttribute('data-nombre') || '').toLowerCase();
            var correo = (row.getAttribute('data-correo') || '').toLowerCase();
            var telefono = (row.getAttribute('data-telefono') || '').toLowerCase();
            var rowRol = row.getAttribute('data-rol') || '';
            var rowEstado = row.getAttribute('data-estado') || '';

            var matchesQuery = !query || nombre.indexOf(query) >= 0 || correo.indexOf(query) >= 0 || telefono.indexOf(query) >= 0;
            var matchesRol = !rol || rowRol === rol;
            var matchesEstado = !estado || rowEstado === estado;
            var show = matchesQuery && matchesRol && matchesEstado;

            row.style.display = show ? '' : 'none';
            if (cards[index]) {
                cards[index].style.display = show ? '' : 'none';
            }

            if (show) visible++;
        });

        if (resultsCount) {
            resultsCount.textContent = visible + ' usuario' + (visible === 1 ? '' : 's');
        }
    }

    if (searchInput) {
        searchInput.addEventListener('input', applyFilters);
    }

    if (filterRol) {
        filterRol.addEventListener('change', applyFilters);
    }

    if (filterEstado) {
        filterEstado.addEventListener('change', applyFilters);
    }

    applyFilters();

    var sortState = { col: '', asc: true };
    Array.from(document.querySelectorAll('.data-table th.sortable')).forEach(function (header) {
        header.addEventListener('click', function () {
            var col = header.getAttribute('data-col');
            sortState.asc = sortState.col === col ? !sortState.asc : true;
            sortState.col = col;

            document.querySelectorAll('.data-table th.sortable').forEach(function (item) {
                item.classList.remove('sort-asc', 'sort-desc');
                var icon = item.querySelector('.sort-icon');
                if (icon) icon.textContent = '⇕';
            });

            header.classList.add(sortState.asc ? 'sort-asc' : 'sort-desc');
            var headerIcon = header.querySelector('.sort-icon');
            if (headerIcon) headerIcon.textContent = sortState.asc ? '↑' : '↓';

            var tbody = document.getElementById('tableBody');
            var rows = getRows();

            rows.sort(function (a, b) {
                var aValue = (a.getAttribute('data-' + col) || '').toLowerCase();
                var bValue = (b.getAttribute('data-' + col) || '').toLowerCase();
                if (aValue < bValue) return sortState.asc ? -1 : 1;
                if (aValue > bValue) return sortState.asc ? 1 : -1;
                return 0;
            });

            rows.forEach(function (row) {
                tbody.appendChild(row);
            });

            applyFilters();
        });
    });
})();
