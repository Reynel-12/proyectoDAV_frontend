(function () {
    function initCategoriaForm() {
        var main = document.getElementById('main-content');
        if (!main) return;

        var apiBase = main.getAttribute('data-api-base') || '';
        var mode = main.getAttribute('data-mode') || 'create';
        var categoryId = parseInt(main.getAttribute('data-category-id') || '0', 10);

        var txtNombre = document.getElementById('txtNombre');
        var txtDescripcion = document.getElementById('txtDescripcion');
        var chkEstado = document.getElementById('chkEstado');
        var btnGuardar = document.getElementById('btnGuardar');
        var charCounter = document.getElementById('charCounter');
        var titleEl = document.getElementById('litPageTitle');
        var summaryEl = document.querySelector('.validation-summary');

        if (!apiBase || !txtNombre || !txtDescripcion || !btnGuardar) {
            console.error('Faltan elementos:', {
                apiBase,
                txtNombre,
                txtDescripcion,
                btnGuardar
            });
            alert('Faltan elementos en el formulario. Revisa la consola.');
            return;
        }

        function getUsuarioActual() {
            try {
                var raw = sessionStorage.getItem('usuario') || localStorage.getItem('usuario');
                if (!raw) return 'Sistema web';

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
            console.log('URL:', url);
            console.log('Status:', response.status);
            console.log('Respuesta cruda:', text);

            if (!response.ok) {
                throw new Error('HTTP ' + response.status + ': ' + text);
            }

            var result;
            try {
                result = JSON.parse(text);
            } catch (error) {
                throw new Error('La API no devolvió JSON válido: ' + text);
            }

            console.log('Respuesta procesada:', result);

            return result.d || result;
        }

        function updateCounter() {
            if (!charCounter) return;

            var len = txtDescripcion.value.length;
            charCounter.textContent = len + ' / 255';
            charCounter.className = 'char-counter' +
                (len >= 255 ? ' at-limit' : len >= 220 ? ' near-limit' : '');
        }

        function showMessage(message, type) {
            console.log('Mensaje en pantalla:', message);

            if (!summaryEl) {
                alert(message);
                return;
            }

            summaryEl.style.display = 'block';
            summaryEl.className = 'validation-summary ' + (type === 'success' ? 'success' : 'error');
            summaryEl.textContent = message;
        }

        function clearMessage() {
            if (!summaryEl) return;

            summaryEl.style.display = 'none';
            summaryEl.textContent = '';
            summaryEl.className = 'validation-summary';
        }

        function validatePayload(payload) {
            if (!payload.nombre) {
                return 'El nombre de la categoría es obligatorio.';
            }

            if (payload.nombre.length < 2 || payload.nombre.length > 100) {
                return 'El nombre debe tener entre 2 y 100 caracteres.';
            }

            if (payload.descripcion.length > 255) {
                return 'La descripción no puede exceder 255 caracteres.';
            }

            return '';
        }

        async function cargarCategoria() {
            if (mode !== 'edit' || !categoryId) return;

            try {
                var result = await postJson(apiBase + '/ObtenerCategoria', { id: categoryId });

                if (!result.Exitoso || !result.Categoria) {
                    throw new Error(result.Mensaje || 'No fue posible cargar la categoría.');
                }

                var categoria = result.Categoria;

                if (titleEl) {
                    titleEl.textContent = 'Editar categoría';
                }

                txtNombre.value = categoria.Nombre || '';
                txtDescripcion.value = categoria.Descripcion || '';

                if (chkEstado) {
                    chkEstado.checked = !!categoria.Estado;
                }

                updateCounter();
            } catch (error) {
                console.error('Error al cargar categoría:', error);
                showMessage(error.message || 'No fue posible cargar la categoría.', 'error');
            }
        }

        async function guardarCategoria(event) {
            event.preventDefault();
            clearMessage();

            var payload = {
                id: categoryId,
                nombre: (txtNombre.value || '').trim(),
                descripcion: (txtDescripcion.value || '').trim(),
                estado: chkEstado ? chkEstado.checked : true,
                usuario: getUsuarioActual()
            };

            var validationError = validatePayload(payload);
            if (validationError) {
                showMessage(validationError, 'error');
                return;
            }

            btnGuardar.disabled = true;

            var textoOriginal = btnGuardar.value || btnGuardar.textContent || 'Guardar categoría';

            if ('value' in btnGuardar) {
                btnGuardar.value = mode === 'edit' ? 'Guardando...' : 'Creando...';
            } else {
                btnGuardar.textContent = mode === 'edit' ? 'Guardando...' : 'Creando...';
            }

            try {
                var endpoint = mode === 'edit' ? '/ActualizarCategoria' : '/GuardarCategoria';
                var result = await postJson(apiBase + endpoint, payload);

                if (!result.Exitoso) {
                    throw new Error(result.Mensaje || 'No fue posible guardar la categoría.');
                }

                var mensajeExito = result.Mensaje || 'Categoría guardada correctamente.';

                showMessage(mensajeExito, 'success');

                sessionStorage.setItem('mensajeCategoria', mensajeExito);
                sessionStorage.setItem('tipoMensajeCategoria', 'success');

                window.setTimeout(function () {
                    window.location.href = 'categorias.aspx?' + (mode === 'edit' ? 'editada=1' : 'nueva=1');
                }, 1200);

            } catch (error) {
                console.error('Error al guardar categoría:', error);
                showMessage(error.message || 'No fue posible guardar la categoría.', 'error');
            } finally {
                btnGuardar.disabled = false;

                if ('value' in btnGuardar) {
                    btnGuardar.value = textoOriginal;
                } else {
                    btnGuardar.textContent = textoOriginal;
                }
            }
        }

        txtDescripcion.addEventListener('input', updateCounter);
        btnGuardar.addEventListener('click', guardarCategoria);

        clearMessage();
        updateCounter();
        cargarCategoria();
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initCategoriaForm);
    } else {
        initCategoriaForm();
    }
})();