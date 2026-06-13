(function () {
    function initUsuarioForm() {
        var main = document.getElementById('main-content');
        if (!main) {
            return;
        }

        var apiBase = main.getAttribute('data-api-base') || '';
        var mode = main.getAttribute('data-mode') || 'create';
        var userId = parseInt(main.getAttribute('data-user-id') || '0', 10);

        var txtNombre = document.getElementById('txtNombre');
        var txtApellido = document.getElementById('txtApellido');
        var txtCorreo = document.getElementById('txtCorreo');
        var ddlRol = document.getElementById('ddlRol');
        var txtContrasena = document.getElementById('txtContrasena');
        var chkEstado = document.getElementById('chkEstado');
        var btnGuardar = document.getElementById('btnGuardar');
        var btnTogglePassword = document.getElementById('btnTogglePassword');
        var summaryEl = document.getElementById('validationSummary');
        var titleEl = document.getElementById('litPageTitle');
        var subtitleEl = document.getElementById('litPageSubtitle');
        var passwordHintEl = document.getElementById('litPasswordHint');

        if (!apiBase || !txtNombre || !txtApellido || !txtCorreo || !ddlRol || !txtContrasena || !btnGuardar) {
            return;
        }

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

        function showMessage(message, type) {
            if (!summaryEl) {
                alert(message);
                return;
            }

            summaryEl.style.display = 'block';
            summaryEl.className = 'validation-summary' + (type === 'success' ? ' success' : '');
            summaryEl.textContent = message;
        }

        function clearMessage() {
            if (!summaryEl) {
                return;
            }

            summaryEl.style.display = 'none';
            summaryEl.textContent = '';
            summaryEl.className = 'validation-summary';
        }

        function validatePayload(payload) {
            if (!payload.nombre || payload.nombre.length < 2 || payload.nombre.length > 100) {
                return 'El nombre debe tener entre 2 y 100 caracteres.';
            }

            if (!payload.apellido || payload.apellido.length < 2 || payload.apellido.length > 100) {
                return 'El apellido debe tener entre 2 y 100 caracteres.';
            }

            if (!payload.correo || payload.correo.length > 50) {
                return 'El correo es obligatorio y no puede exceder 50 caracteres.';
            }

            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(payload.correo)) {
                return 'Debes ingresar un correo electrónico válido.';
            }

            if (!payload.rol) {
                return 'Debes seleccionar un rol.';
            }

            if (mode === 'create' && !payload.password) {
                return 'La contraseña es obligatoria.';
            }

            if (payload.password && (payload.password.length < 8 || payload.password.length > 40)) {
                return 'La contraseña debe tener entre 8 y 40 caracteres.';
            }

            return '';
        }

        function configurarModoEdicion() {
            if (mode !== 'edit') {
                return;
            }

            if (titleEl) titleEl.textContent = 'Editar usuario';
            if (subtitleEl) subtitleEl.textContent = 'Actualiza la información principal de la cuenta';
            if (passwordHintEl) passwordHintEl.textContent = 'Si no deseas cambiar la contraseña, deja este campo vacío.';
            if (txtContrasena) txtContrasena.placeholder = 'Dejar en blanco para conservar la actual';
            if (btnGuardar) btnGuardar.textContent = 'Guardar cambios';
        }

        async function cargarUsuario() {
            if (mode !== 'edit' || !userId) {
                return;
            }

            try {
                var result = await postJson(apiBase + '/ObtenerUsuario', { idUsuario: userId });
                if (!result.Exitoso || !result.UsuarioData) {
                    throw new Error(result.Mensaje || 'No fue posible cargar el usuario.');
                }

                var usuario = result.UsuarioData;
                txtNombre.value = usuario.Nombre || '';
                txtApellido.value = usuario.Apellido || '';
                txtCorreo.value = usuario.Correo || usuario.Usuario || '';
                ddlRol.value = usuario.Rol || '';

                if (chkEstado) {
                    chkEstado.checked = !!usuario.Estado;
                }
            } catch (error) {
                showMessage(error.message || 'No fue posible cargar el usuario.', 'error');
            }
        }

        async function guardarUsuario(event) {
            event.preventDefault();
            clearMessage();

            var payload = {
                idUsuario: userId,
                nombre: (txtNombre.value || '').trim(),
                apellido: (txtApellido.value || '').trim(),
                correo: (txtCorreo.value || '').trim(),
                password: (txtContrasena.value || '').trim(),
                rol: ddlRol.value || '',
                estado: chkEstado ? chkEstado.checked : true,
                usuarioSesion: getUsuarioActual()
            };

            var validationError = validatePayload(payload);
            if (validationError) {
                showMessage(validationError, 'error');
                return;
            }

            btnGuardar.disabled = true;
            var textoOriginal = btnGuardar.textContent || 'Guardar usuario';
            btnGuardar.textContent = mode === 'edit' ? 'Guardando...' : 'Creando...';

            try {
                var endpoint = mode === 'edit' ? '/ActualizarUsuario' : '/GuardarUsuario';
                var result = await postJson(apiBase + endpoint, {
                    idUsuario: payload.idUsuario,
                    nombre: payload.nombre,
                    apellido: payload.apellido,
                    usuario: payload.correo,
                    password: payload.password,
                    rol: payload.rol,
                    estado: payload.estado,
                    usuarioSesion: payload.usuarioSesion
                });
                if (!result.Exitoso) {
                    throw new Error(result.Mensaje || 'No fue posible guardar el usuario.');
                }

                sessionStorage.setItem('mensajeUsuario', result.Mensaje || 'Usuario guardado correctamente.');
                sessionStorage.setItem('tipoMensajeUsuario', 'success');

                showMessage(result.Mensaje || 'Usuario guardado correctamente.', 'success');

                window.setTimeout(function () {
                    window.location.href = 'usuarios.aspx';
                }, 900);
            } catch (error) {
                showMessage(error.message || 'No fue posible guardar el usuario.', 'error');
            } finally {
                btnGuardar.disabled = false;
                btnGuardar.textContent = textoOriginal;
            }
        }

        if (btnTogglePassword) {
            btnTogglePassword.addEventListener('click', function () {
                var isPassword = txtContrasena.type === 'password';
                txtContrasena.type = isPassword ? 'text' : 'password';
                btnTogglePassword.setAttribute('aria-label', isPassword ? 'Ocultar contraseña' : 'Mostrar u ocultar contraseña');
            });
        }

        btnGuardar.addEventListener('click', guardarUsuario);
        configurarModoEdicion();
        cargarUsuario();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initUsuarioForm);
    } else {
        initUsuarioForm();
    }
})();
