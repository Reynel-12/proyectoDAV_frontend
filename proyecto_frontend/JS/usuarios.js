(function () {
    function initUsuariosPage() {
        if (!window.AppAuth || !window.AppAuth.requerirAdministrador) {
            window.location.href = 'dashboard.aspx';
            return;
        }

        var usuarioActual = window.AppAuth.requerirAdministrador({
            loginPath: 'login.aspx',
            redirectPath: 'dashboard.aspx'
        });
        if (!usuarioActual) {
            return;
        }

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
        var searchInput = document.getElementById('searchInput');
        var filterRol = document.getElementById('filterRol');
        var filterEstado = document.getElementById('filterEstado');
        var resultsCount = document.getElementById('resultsCount');
        var totalUsuariosEl = document.getElementById('litTotalUsuarios');
        var totalKpiEl = document.getElementById('litKpiTotal');
        var activosKpiEl = document.getElementById('litKpiActivos');
        var adminsKpiEl = document.getElementById('litKpiAdministradores');
        var nuevosMesEl = document.getElementById('litKpiNuevosMes');
        var tableBody = document.getElementById('tableBody');
        var modal = document.getElementById('deleteModal');
        var modalName = document.getElementById('modalUserName');
        var modalLogin = document.getElementById('modalUserLogin');
        var modalAvatar = document.getElementById('modalUserAvatar');
        var btnCancel = document.getElementById('btnModalCancel');
        var btnDelete = document.getElementById('btnModalDelete');
        var mobileMq = window.matchMedia('(max-width: 768px)');
        var currentView = mobileMq.matches ? 'card' : 'table';
        var usuarios = [];
        var filtrados = [];
        var actualToggle = null;
        var sortState = { col: '', asc: true };
        var avatarClasses = ['ua-blue', 'ua-green', 'ua-purple', 'ua-amber', 'ua-cyan', 'ua-pink', 'ua-slate', 'ua-red'];

        var SVG_DEACTIVATE =
            '<svg width="18" height="18" viewBox="0 0 24 24" fill="none">' +
                '<path d="M12 2V12" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>' +
                '<path d="M6.8 5.2A8 8 0 1 0 17.2 5.2" stroke="currentColor" stroke-width="1.5" fill="none" stroke-linecap="round"/>' +
            '</svg>';

        var SVG_ACTIVATE =
            '<svg width="18" height="18" viewBox="0 0 24 24" fill="none">' +
                '<circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.5" fill="none"/>' +
                '<path d="M8 12L11 15L16 9" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>' +
            '</svg>';

        function getUsuarioActual() {
            return usuarioActual.Usuario || usuarioActual.Nombre || 'Sistema web';
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
            if (!response.ok) {
                throw new Error(text || ('HTTP ' + response.status));
            }

            var result = JSON.parse(text);
            return result.d || result;
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

            var match = /\/Date\((\d+)\)\//.exec(String(value));
            var date = match ? new Date(parseInt(match[1], 10)) : new Date(value);
            if (isNaN(date.getTime())) {
                return '';
            }

            return date.toLocaleDateString('es-HN');
        }

        function getDateValue(value) {
            var match = /\/Date\((\d+)\)\//.exec(String(value || ''));
            var date = match ? new Date(parseInt(match[1], 10)) : new Date(value);
            return isNaN(date.getTime()) ? 0 : date.getTime();
        }

        function getNombreCompleto(usuario) {
            return (String(usuario.Nombre || '') + ' ' + String(usuario.Apellido || '')).trim();
        }

        function getCorreo(usuario) {
            return String(usuario.Correo || usuario.Usuario || '').trim();
        }

        function getIniciales(usuario) {
            var partes = getNombreCompleto(usuario).split(/\s+/).filter(Boolean);
            if (!partes.length) {
                return 'US';
            }

            return partes.slice(0, 2).map(function (parte) {
                return parte.charAt(0).toUpperCase();
            }).join('');
        }

        function getAvatarClass(usuario) {
            var base = (usuario.Usuario || getNombreCompleto(usuario) || 'usuario').length;
            return avatarClasses[base % avatarClasses.length];
        }

        function getRolKey(rol) {
            return String(rol || '').trim().toLowerCase();
        }

        function getEstadoKey(estado) {
            return estado ? 'activo' : 'inactivo';
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
            window.setTimeout(function () {
                toast.classList.remove('show');
            }, 4000);
        }

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

        function actualizarResumen() {
            var total = usuarios.length;
            var activos = usuarios.filter(function (usuario) { return !!usuario.Estado; }).length;
            var administradores = usuarios.filter(function (usuario) {
                return getRolKey(usuario.Rol) === 'administrador';
            }).length;
            var hoy = new Date();
            var nuevosMes = usuarios.filter(function (usuario) {
                var date = new Date(getDateValue(usuario.FechaRegistro));
                return !isNaN(date.getTime()) &&
                    date.getFullYear() === hoy.getFullYear() &&
                    date.getMonth() === hoy.getMonth();
            }).length;

            if (totalUsuariosEl) totalUsuariosEl.textContent = total;
            if (totalKpiEl) totalKpiEl.textContent = total;
            if (activosKpiEl) activosKpiEl.textContent = activos;
            if (adminsKpiEl) adminsKpiEl.textContent = administradores;
            if (nuevosMesEl) nuevosMesEl.textContent = nuevosMes;
        }

        function actualizarOpcionesRol() {
            if (!filterRol) {
                return;
            }

            var roles = usuarios
                .map(function (usuario) { return String(usuario.Rol || '').trim(); })
                .filter(Boolean)
                .filter(function (rol, index, arr) { return arr.indexOf(rol) === index; })
                .sort();

            filterRol.innerHTML = '<option value="">Todos los roles</option>' + roles.map(function (rol) {
                return '<option value="' + escapeHtml(getRolKey(rol)) + '">' + escapeHtml(rol) + '</option>';
            }).join('');
        }

        function renderEmptyState(message) {
            if (tableBody) {
                tableBody.innerHTML = '<tr><td colspan="6" style="text-align:center;padding:40px;color:var(--clr-gray-400);">' + escapeHtml(message) + '</td></tr>';
            }

            if (cardView) {
                cardView.innerHTML =
                    '<div class="empty-state">' +
                        '<div class="empty-icon" aria-hidden="true">' +
                            '<svg width="56" height="56" viewBox="0 0 24 24" fill="none">' +
                                '<path d="M20 21V19C20 17.3 18.7 16 17 16H7C5.3 16 4 17.3 4 19V21" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" />' +
                                '<circle cx="12" cy="8" r="4" stroke="currentColor" stroke-width="1.6" />' +
                            '</svg>' +
                        '</div>' +
                        '<div class="empty-title">Sin resultados</div>' +
                        '<div class="empty-desc">' + escapeHtml(message) + '</div>' +
                    '</div>';
            }
        }

        function buildToggleButton(usuario, small) {
            var activo = !!usuario.Estado;
            var cls = ['btn-action', activo ? 'del' : '', 'js-toggle-user', small ? '' : '']
                .filter(Boolean).join(' ');
            var iconStyle = activo ? '' : ' style="color:#16a34a"';
            var accion = activo ? 'Desactivar' : 'Activar';
            var svg = activo ? SVG_DEACTIVATE : SVG_ACTIVATE;

            return '<button class="' + cls + '" type="button"' +
                ' data-id="' + usuario.IdUsuario + '"' +
                ' data-estado="' + (activo ? 'true' : 'false') + '"' +
                ' title="' + accion + ' usuario ' + escapeHtml(getNombreCompleto(usuario)) + '"' +
                ' aria-label="' + accion + ' usuario ' + escapeHtml(getNombreCompleto(usuario)) + '"' +
                iconStyle + '>' +
                svg +
                '</button>';
        }

        function buildToggleCardButton(usuario) {
            var activo = !!usuario.Estado;
            var cls = ['btn-card-action', activo ? 'del' : '', 'js-toggle-user'].filter(Boolean).join(' ');
            var iconStyle = activo ? '' : ' style="color:#16a34a"';
            var accion = activo ? 'Desactivar' : 'Activar';
            var svg = activo ? SVG_DEACTIVATE : SVG_ACTIVATE;

            return '<button class="' + cls + '" type="button"' +
                ' data-id="' + usuario.IdUsuario + '"' +
                ' data-estado="' + (activo ? 'true' : 'false') + '"' +
                iconStyle + '>' +
                svg.replace('width="18" height="18"', 'width="16" height="16"') +
                accion +
                '</button>';
        }

        function renderUsuarios() {
            if (!tableBody || !cardView) {
                return;
            }

            if (!filtrados.length) {
                if (!usuarios.length) {
                    renderEmptyState('Aún no hay usuarios registrados.');
                } else {
                    renderEmptyState('No hay usuarios que coincidan con los filtros actuales.');
                }

                if (resultsCount) {
                    resultsCount.textContent = '0 usuarios';
                }

                return;
            }

            tableBody.innerHTML = '';
            cardView.innerHTML = '';

            filtrados.forEach(function (usuario) {
                var avatarClass = getAvatarClass(usuario);
                var iniciales = getIniciales(usuario);
                var nombreCompleto = getNombreCompleto(usuario);
                var rol = String(usuario.Rol || '');
                var rolKey = getRolKey(rol);
                var estadoTexto = usuario.Estado ? 'Activo' : 'Inactivo';
                var estadoKey = getEstadoKey(usuario.Estado);
                var fechaRegistro = formatDate(usuario.FechaRegistro);

                var row = document.createElement('tr');
                row.className = 'user-row';
                row.setAttribute('data-nombre', nombreCompleto.toLowerCase());
                row.setAttribute('data-correo', getCorreo(usuario).toLowerCase());
                row.setAttribute('data-rol', rolKey);
                row.setAttribute('data-estado', estadoKey);
                row.setAttribute('data-registro', String(getDateValue(usuario.FechaRegistro)));
                if (!usuario.Estado) {
                    row.style.opacity = '0.65';
                }
                row.innerHTML =
                    '<td>' +
                        '<div class="user-cell">' +
                            '<div class="user-avatar ' + avatarClass + '" aria-hidden="true">' + escapeHtml(iniciales) + '</div>' +
                            '<div>' +
                                '<div class="user-name">' + escapeHtml(nombreCompleto) + '</div>' +
                            '</div>' +
                        '</div>' +
                    '</td>' +
                    '<td><div class="text-strong">' + escapeHtml(getCorreo(usuario)) + '</div></td>' +
                    '<td><span class="role-pill ' + escapeHtml(rolKey) + '">' + escapeHtml(rol) + '</span></td>' +
                    '<td><span class="status-pill ' + estadoKey + '"><span class="status-dot"></span>' + estadoTexto + '</span></td>' +
                    '<td><div class="text-strong">' + escapeHtml(fechaRegistro) + '</div></td>' +
                    '<td class="td-actions">' +
                        '<div class="action-wrap">' +
                            '<a class="btn-action edit" href="nuevoUsuario.aspx?id=' + encodeURIComponent(usuario.IdUsuario) + '" title="Editar usuario ' + escapeHtml(nombreCompleto) + '" aria-label="Editar usuario ' + escapeHtml(nombreCompleto) + '">' +
                                '<svg width="18" height="18" viewBox="0 0 24 24" fill="none">' +
                                    '<path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none" />' +
                                '</svg>' +
                            '</a>' +
                            buildToggleButton(usuario) +
                        '</div>' +
                    '</td>';

                var card = document.createElement('article');
                card.className = 'user-card';
                card.setAttribute('data-nombre', nombreCompleto.toLowerCase());
                card.setAttribute('data-correo', getCorreo(usuario).toLowerCase());
                card.setAttribute('data-rol', rolKey);
                card.setAttribute('data-estado', estadoKey);
                card.setAttribute('data-registro', String(getDateValue(usuario.FechaRegistro)));
                if (!usuario.Estado) {
                    card.style.opacity = '0.65';
                }
                card.innerHTML =
                    '<div class="user-card-top">' +
                        '<div class="user-avatar lg ' + avatarClass + '" aria-hidden="true">' + escapeHtml(iniciales) + '</div>' +
                        '<div>' +
                            '<div class="user-name">' + escapeHtml(nombreCompleto) + '</div>' +
                            '<div class="text-muted">' + escapeHtml(getCorreo(usuario)) + '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="user-card-tags">' +
                        '<span class="role-pill ' + escapeHtml(rolKey) + '">' + escapeHtml(rol) + '</span>' +
                        '<span class="status-pill ' + estadoKey + '"><span class="status-dot"></span>' + estadoTexto + '</span>' +
                    '</div>' +
                    '<div class="user-card-grid">' +
                        '<div>' +
                            '<div class="meta-label">Registro</div>' +
                            '<div class="meta-value">' + escapeHtml(fechaRegistro) + '</div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="card-actions">' +
                        '<a class="btn-card-action edit" href="nuevoUsuario.aspx?id=' + encodeURIComponent(usuario.IdUsuario) + '">' +
                            '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" aria-hidden="true">' +
                                '<path d="M17 3L21 7L7 21H3V17L17 3Z" stroke="currentColor" stroke-width="1.5" fill="none" />' +
                            '</svg>' +
                            'Editar' +
                        '</a>' +
                        buildToggleCardButton(usuario) +
                    '</div>';

                tableBody.appendChild(row);
                cardView.appendChild(card);
            });

            if (resultsCount) {
                resultsCount.textContent = filtrados.length + ' usuario' + (filtrados.length === 1 ? '' : 's');
            }
        }

        function aplicarFiltros() {
            var query = ((searchInput && searchInput.value) || '').toLowerCase().trim();
            var rol = filterRol ? filterRol.value : '';
            var estado = filterEstado ? filterEstado.value : '';

            filtrados = usuarios.filter(function (usuario) {
                var nombre = getNombreCompleto(usuario).toLowerCase();
                var login = getCorreo(usuario).toLowerCase();
                var rolKey = getRolKey(usuario.Rol);
                var estadoKey = getEstadoKey(usuario.Estado);

                var coincideBusqueda = !query ||
                    nombre.indexOf(query) >= 0 ||
                    login.indexOf(query) >= 0 ||
                    rolKey.indexOf(query) >= 0;
                var coincideRol = !rol || rolKey === rol;
                var coincideEstado = !estado || estadoKey === estado;

                return coincideBusqueda && coincideRol && coincideEstado;
            });

            if (sortState.col) {
                ordenarFiltrados();
            }

            renderUsuarios();
        }

        function getSortValue(usuario, col) {
            switch (col) {
                case 'nombre':
                    return getNombreCompleto(usuario).toLowerCase();
                case 'correo':
                    return getCorreo(usuario).toLowerCase();
                case 'rol':
                    return getRolKey(usuario.Rol);
                case 'estado':
                    return getEstadoKey(usuario.Estado);
                case 'registro':
                    return getDateValue(usuario.FechaRegistro);
                default:
                    return '';
            }
        }

        function ordenarFiltrados() {
            filtrados.sort(function (a, b) {
                var aValue = getSortValue(a, sortState.col);
                var bValue = getSortValue(b, sortState.col);

                if (aValue < bValue) return sortState.asc ? -1 : 1;
                if (aValue > bValue) return sortState.asc ? 1 : -1;
                return 0;
            });
        }

        function closeModal() {
            actualToggle = null;
            if (modal) {
                modal.classList.remove('open');
            }
        }

        function openToggleModal(usuario) {
            actualToggle = usuario;
            if (!modal) {
                return;
            }

            var activo = !!usuario.Estado;
            var modalTitle = document.getElementById('deleteModalTitle');
            var modalSubtitle = document.getElementById('modalSubtitle');
            var modalWarningText = document.getElementById('modalWarningText');

            if (modalTitle) {
                modalTitle.textContent = activo ? 'Desactivar usuario' : 'Activar usuario';
            }
            if (modalSubtitle) {
                modalSubtitle.textContent = activo
                    ? 'El usuario quedará inactivo y no podrá iniciar sesión.'
                    : 'El usuario quedará activo y podrá iniciar sesión nuevamente.';
            }
            if (modalWarningText) {
                modalWarningText.textContent = activo
                    ? 'El usuario conservará su registro histórico. Podrás reactivarlo en cualquier momento.'
                    : 'El usuario recuperará acceso completo al sistema según su rol.';
            }
            if (btnDelete) {
                btnDelete.textContent = activo ? 'Sí, desactivar' : 'Sí, activar';
            }

            if (modalName) modalName.textContent = getNombreCompleto(usuario);
            if (modalLogin) modalLogin.textContent = getCorreo(usuario);
            if (modalAvatar) {
                modalAvatar.textContent = getIniciales(usuario);
                modalAvatar.className = 'modal-user-avatar ' + getAvatarClass(usuario);
            }

            modal.classList.add('open');
            if (btnDelete) {
                btnDelete.focus();
            }
        }

        async function toggleUsuario() {
            if (!actualToggle) {
                return;
            }

            var nuevoEstado = !actualToggle.Estado;

            try {
                var result = await postJson(apiBase + '/CambiarEstadoUsuario', {
                    idUsuario: actualToggle.IdUsuario,
                    estado: nuevoEstado,
                    usuarioSesion: getUsuarioActual()
                });

                if (!result.Exitoso) {
                    throw new Error(result.Mensaje || 'No fue posible cambiar el estado del usuario.');
                }

                var idActualizado = actualToggle.IdUsuario;
                usuarios = usuarios.map(function (u) {
                    if (u.IdUsuario === idActualizado) {
                        u.Estado = nuevoEstado;
                    }
                    return u;
                });

                actualizarResumen();
                aplicarFiltros();
                closeModal();
                showToast(result.Mensaje || 'Estado actualizado correctamente.', 'success');
            } catch (error) {
                closeModal();
                showToast(error.message || 'No fue posible cambiar el estado del usuario.', 'error');
            }
        }

        async function cargarUsuarios() {
            try {
                var result = await postJson(apiBase + '/ListarUsuarios', {});
                if (!result.Exitoso) {
                    throw new Error(result.Mensaje || 'No fue posible cargar los usuarios.');
                }

                usuarios = result.Usuarios || [];
                actualizarResumen();
                actualizarOpcionesRol();
                aplicarFiltros();
            } catch (error) {
                renderEmptyState(error.message || 'No fue posible cargar los usuarios.');
                showToast(error.message || 'No fue posible cargar los usuarios.', 'error');
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

        if (typeof mobileMq.addEventListener === 'function') {
            mobileMq.addEventListener('change', function (event) {
                setView(event.matches ? 'card' : currentView);
            });
        }

        if (searchInput) {
            searchInput.addEventListener('input', aplicarFiltros);
        }

        if (filterRol) {
            filterRol.addEventListener('change', aplicarFiltros);
        }

        if (filterEstado) {
            filterEstado.addEventListener('change', aplicarFiltros);
        }

        Array.prototype.forEach.call(document.querySelectorAll('.data-table th.sortable'), function (header) {
            header.addEventListener('click', function () {
                var col = header.getAttribute('data-col');
                sortState.asc = sortState.col === col ? !sortState.asc : true;
                sortState.col = col;

                Array.prototype.forEach.call(document.querySelectorAll('.data-table th.sortable'), function (item) {
                    item.classList.remove('sort-asc', 'sort-desc');
                    var icon = item.querySelector('.sort-icon');
                    if (icon) {
                        icon.textContent = '↕';
                    }
                });

                header.classList.add(sortState.asc ? 'sort-asc' : 'sort-desc');
                var headerIcon = header.querySelector('.sort-icon');
                if (headerIcon) {
                    headerIcon.textContent = sortState.asc ? '↑' : '↓';
                }

                aplicarFiltros();
            });
        });

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
            btnDelete.addEventListener('click', toggleUsuario);
        }

        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                closeModal();
            }
        });

        document.addEventListener('click', function (event) {
            var toggleButton = event.target.closest('.js-toggle-user');
            if (!toggleButton) {
                return;
            }

            var id = parseInt(toggleButton.getAttribute('data-id') || '0', 10);
            var usuario = usuarios.find(function (item) {
                return item.IdUsuario === id;
            });

            if (usuario) {
                openToggleModal(usuario);
            }
        });

        var mensaje = sessionStorage.getItem('mensajeUsuario');
        var tipo = sessionStorage.getItem('tipoMensajeUsuario');
        if (mensaje) {
            showToast(mensaje, tipo || 'success');
            sessionStorage.removeItem('mensajeUsuario');
            sessionStorage.removeItem('tipoMensajeUsuario');
        }

        setView(currentView);
        cargarUsuarios();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initUsuariosPage);
    } else {
        initUsuariosPage();
    }
})();
