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

            if (show) {
                visible++;
            }
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
                if (icon) {
                    icon.textContent = '⇕';
                }
            });

            header.classList.add(sortState.asc ? 'sort-asc' : 'sort-desc');
            var headerIcon = header.querySelector('.sort-icon');
            if (headerIcon) {
                headerIcon.textContent = sortState.asc ? '↑' : '↓';
            }

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

    var modal = document.getElementById('deleteModal');
    var modalName = document.getElementById('modalUserName');
    var modalEmail = document.getElementById('modalUserEmail');
    var modalAvatar = document.getElementById('modalUserAvatar');
    var btnCancel = document.getElementById('btnModalCancel');
    var btnDelete = document.getElementById('btnModalDelete');
    var hfDeleteId = document.getElementById('hfDeleteId');
    var btnDeleteConfirm = document.getElementById('btnDeleteConfirm');

    window.openDeleteModal = function (id, nombre, correo, iniciales, avatarClase) {
        if (!modal || !hfDeleteId) {
            return;
        }

        hfDeleteId.value = id;
        if (modalName) modalName.textContent = nombre;
        if (modalEmail) modalEmail.textContent = correo;
        if (modalAvatar) {
            modalAvatar.textContent = iniciales;
            modalAvatar.className = 'modal-user-avatar ' + avatarClase;
        }

        modal.classList.add('open');
        if (btnDelete) {
            btnDelete.focus();
        }
    };

    function closeModal() {
        if (!modal) {
            return;
        }

        modal.classList.remove('open');
        if (hfDeleteId) {
            hfDeleteId.value = '';
        }
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

    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            closeModal();
        }
    });

    if (btnDelete) {
        btnDelete.addEventListener('click', function () {
            closeModal();
            if (btnDeleteConfirm) {
                btnDeleteConfirm.click();
            }
        });
    }

    function showToast(msg, type) {
        var toast = document.getElementById('toast');
        var toastMsg = document.getElementById('toastMsg');
        var toastIcon = document.getElementById('toastIcon');

        if (!toast || !toastMsg || !toastIcon) {
            return;
        }

        toast.className = 'toast ' + (type || 'success');
        toastIcon.textContent = type === 'error' ? '✖' : '✔';
        toastMsg.textContent = msg;
        toast.classList.add('show');
        setTimeout(function () {
            toast.classList.remove('show');
        }, 4000);
    }

    var qs = new URLSearchParams(window.location.search);
    if (qs.get('nuevo') === '1') showToast('Usuario creado correctamente.', 'success');
    if (qs.get('editado') === '1') showToast('Usuario actualizado correctamente.', 'success');
    if (qs.get('eliminado') === '1') showToast('Usuario eliminado correctamente.', 'success');
})();
