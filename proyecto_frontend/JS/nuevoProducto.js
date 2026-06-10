(function () {
    function initProductoForm() {
        var main = document.getElementById('main-content');
        if (!main) {
            return;
        }

        var apiBase = main.getAttribute('data-api-base') || '';
        var mode = main.getAttribute('data-mode') || 'create';
        var productId = parseInt(main.getAttribute('data-product-id') || '0', 10);

        var form = document.getElementById('appForm');
        var txtCodigo = document.getElementById('txtCodigo');
        var ddlCategoria = document.getElementById('ddlCategoria');
        var txtDescripcion = document.getElementById('txtDescripcion');
        var txtPrecioCompra = document.getElementById('txtPrecioCompra');
        var txtPrecioVenta = document.getElementById('txtPrecioVenta');
        var ddlImpuesto = document.getElementById('ddlImpuesto');
        var txtExistencia = document.getElementById('txtExistencia');
        var fileInput = document.getElementById('fuFoto');
        var btnGuardar = document.getElementById('btnGuardar');
        var messageBox = document.getElementById('formMessage');
        var counter = document.getElementById('charCounter');
        var dropZone = document.getElementById('dropZone');
        var previewWrap = document.getElementById('photoPreview');
        var previewImg = document.getElementById('previewImg');
        var previewName = document.getElementById('previewName');
        var previewSize = document.getElementById('previewSize');
        var removeBtn = document.getElementById('btnRemovePhoto');
        var errorMsg = document.getElementById('photoErrorMsg');
        var uploadIcon = document.getElementById('uploadIcon');

        if (!apiBase || !form || !btnGuardar) {
            return;
        }

        var ALLOWED_EXTS = ['jpg', 'jpeg', 'png'];
        var ALLOWED_TYPES = ['image/jpeg', 'image/png'];
        var MAX_CHARS = 300;
        var fotoBase64 = '';
        var fotoNombre = '';
        var fotoActual = '';
        var fotoEliminada = false;

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

        function showMessage(message, type) {
            if (!messageBox) {
                return;
            }

            messageBox.style.display = 'block';
            messageBox.className = 'validation-summary ' + (type === 'success' ? 'success' : 'error');
            messageBox.textContent = message;
        }

        function hideMessage() {
            if (!messageBox) {
                return;
            }

            messageBox.style.display = 'none';
            messageBox.textContent = '';
            messageBox.className = 'validation-summary';
        }

        function formatBytes(bytes) {
            if (bytes < 1024) return bytes + ' B';
            if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB';
            return (bytes / 1048576).toFixed(2) + ' MB';
        }

        function getExt(filename) {
            var parts = String(filename || '').split('.');
            return parts.length > 1 ? parts.pop().toLowerCase() : '';
        }

        function isValidFile(file) {
            return !!file &&
                ALLOWED_EXTS.indexOf(getExt(file.name)) >= 0 &&
                ALLOWED_TYPES.indexOf(file.type) >= 0;
        }

        function updateCounter() {
            if (!counter || !txtDescripcion) {
                return;
            }

            var len = txtDescripcion.value.length;
            counter.textContent = len + ' / ' + MAX_CHARS;
            counter.className = 'char-counter' +
                (len >= MAX_CHARS ? ' at-limit' : len >= MAX_CHARS * 0.85 ? ' near-limit' : '');
        }

        function resetPreviewStyles() {
            if (dropZone) {
                dropZone.classList.remove('has-error');
                dropZone.classList.add('has-file');
            }
            if (errorMsg) {
                errorMsg.classList.remove('visible');
            }
            if (uploadIcon) {
                uploadIcon.innerHTML = '✔';
            }
        }

        function showExistingPreview(url, name) {
            if (!previewWrap || !previewImg || !previewName || !previewSize) {
                return;
            }

            previewImg.src = url;
            previewName.textContent = name || 'Fotografia actual';
            previewSize.textContent = 'Imagen cargada';
            previewWrap.classList.add('visible');
            resetPreviewStyles();
        }

        function showPreview(file, base64) {
            if (!previewWrap || !previewImg || !previewName || !previewSize) {
                return;
            }

            previewImg.src = base64;
            previewName.textContent = file.name;
            previewSize.textContent = formatBytes(file.size);
            previewWrap.classList.add('visible');
            resetPreviewStyles();
        }

        function clearPhoto() {
            fotoBase64 = '';
            fotoNombre = '';
            fotoEliminada = !!fotoActual;

            if (previewImg) previewImg.src = '#';
            if (previewName) previewName.textContent = '';
            if (previewSize) previewSize.textContent = '';
            if (previewWrap) previewWrap.classList.remove('visible');
            if (dropZone) dropZone.classList.remove('has-file', 'has-error');
            if (uploadIcon) {
                uploadIcon.innerHTML =
                    '<svg width="48" height="48" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">' +
                    '<rect x="2" y="3" width="20" height="18" rx="2" stroke="currentColor" stroke-width="1.5" fill="none" />' +
                    '<path d="M9 11L6 16H18L15 13L12 15L9 11Z" stroke="currentColor" stroke-width="1.5" fill="none" />' +
                    '<circle cx="16.5" cy="8.5" r="1.5" fill="currentColor" stroke="currentColor" stroke-width="1" />' +
                    '</svg>';
            }
            if (errorMsg) errorMsg.classList.remove('visible');
            if (fileInput) fileInput.value = '';
        }

        function showError(message) {
            if (dropZone) {
                dropZone.classList.remove('has-file');
                dropZone.classList.add('has-error');
            }
            if (uploadIcon) uploadIcon.innerHTML = '⚠';
            if (errorMsg) {
                errorMsg.classList.add('visible');
                errorMsg.lastChild.textContent = message ? ' ' + message : '';
            }
        }

        function fileToBase64(file) {
            return new Promise(function (resolve, reject) {
                var reader = new FileReader();
                reader.onload = function (event) {
                    resolve(event.target.result);
                };
                reader.onerror = reject;
                reader.readAsDataURL(file);
            });
        }

        async function handleFile(file) {
            if (!file) {
                return;
            }

            if (!isValidFile(file)) {
                showError('Solo se aceptan imagenes JPG, JPEG o PNG.');
                return;
            }

            hideMessage();
            fotoBase64 = await fileToBase64(file);
            fotoNombre = file.name;
            fotoEliminada = false;
            showPreview(file, fotoBase64);
        }

        function collectPayload() {
            return {
                codigo: parseInt((txtCodigo.value || "").trim(), 10),
                descripcion: (txtDescripcion.value || '').trim(),
                precioCompra: Number(txtPrecioCompra.value || 0),
                precioVenta: Number(txtPrecioVenta.value || 0),
                impuesto: Number(ddlImpuesto.value || 0),
                existencia: parseInt((txtExistencia.value || "0").trim(), 10),
                categoria: ddlCategoria.value || '',
                fotografiaBase64: fotoBase64 || '',
                fotografiaNombre: fotoNombre || '',
                fotografiaActual: fotoActual || '',
                eliminarFotografia: fotoEliminada && !fotoBase64,
                usuario: getUsuarioActual()
            };
        }

        function validatePayload(payload) {
            if (!txtCodigo.value.trim()) {
                return 'El código del producto es obligatorio.';
            }

            if (!Number.isInteger(payload.codigo) || payload.codigo <= 0) {
                return 'El código debe ser un número entero positivo.';
            }

            if (!payload.descripcion) {
                return 'La descripción es obligatoria.';
            }

            if (!payload.categoria) {
                return 'La categoría es obligatoria.';
            }

            if (!txtPrecioCompra.value.trim()) {
                return 'El precio de compra es obligatorio.';
            }

            if (!txtPrecioVenta.value.trim()) {
                return 'El precio de venta es obligatorio.';
            }

            if (payload.precioCompra < 0 || payload.precioVenta < 0) {
                return 'Los precios deben ser mayores o iguales a cero.';
            }

            if (!ddlImpuesto.value && ddlImpuesto.value !== '0') {
                return 'El impuesto es obligatorio.';
            }

            if (!txtExistencia.value.trim()) {
                return 'La existencia es obligatoria.';
            }

            if (!Number.isInteger(payload.existencia) || payload.existencia < 0) {
                return 'La existencia debe ser un número entero válido.';
            }

            return '';
        }

        async function postJson(url, payload) {
            const response = await fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=utf-8'
                },
                body: JSON.stringify(payload || {})
            });

            const text = await response.text();

            console.log('URL:', url);
            console.log('Payload enviado:', payload);
            console.log('Status:', response.status);
            console.log('Respuesta cruda:', text);

            if (!response.ok) {
                throw new Error(
                    'Error HTTP ' + response.status + '. Revisa la consola para ver la respuesta del servidor.'
                );
            }

            try {
                const result = JSON.parse(text);
                return result.d || result;
            } catch (error) {
                throw new Error('El servidor no devolvió JSON válido. Respuesta: ' + text.substring(0, 300));
            }
        }

        async function cargarCategoriasDesdeApi() {
            try {
                var result = await postJson(apiBase + '/ListarProductos', {});
                var categorias = result.Categorias || [];
                var actual = ddlCategoria.value;
                ddlCategoria.innerHTML = '<option value="">— Selecciona una categoria —</option>';

                categorias.forEach(function (categoria) {
                    var option = document.createElement('option');
                    option.value = categoria;
                    option.textContent = categoria;
                    ddlCategoria.appendChild(option);
                });

                if (actual) {
                    ddlCategoria.value = actual;
                }
            } catch (error) {
            }
        }

        async function cargarProducto() {
            if (mode !== 'edit' || !productId) {
                return;
            }

            try {
                var result = await postJson(apiBase + '/ObtenerProducto', { codigo: productId });
                if (!result.Exitoso || !result.Producto) {
                    throw new Error(result.Mensaje || 'No fue posible cargar el producto.');
                }

                var producto = result.Producto;
                if (txtCodigo) txtCodigo.value = producto.Codigo;
                if (txtDescripcion) txtDescripcion.value = producto.Descripcion || '';
                if (txtPrecioCompra) txtPrecioCompra.value = producto.PrecioCompra;
                if (txtPrecioVenta) txtPrecioVenta.value = producto.PrecioVenta;
                if (ddlImpuesto) ddlImpuesto.value = String(producto.Impuesto);
                if (txtExistencia) txtExistencia.value = producto.Existencia;

                if (ddlCategoria) {
                    var found = Array.prototype.some.call(ddlCategoria.options, function (option) {
                        return option.value === producto.Categoria;
                    });

                    if (!found) {
                        var extraOption = document.createElement('option');
                        extraOption.value = producto.Categoria;
                        extraOption.textContent = producto.Categoria;
                        ddlCategoria.appendChild(extraOption);
                    }

                    ddlCategoria.value = producto.Categoria;
                }

                fotoActual = producto.Fotografia || '';
                fotoEliminada = false;

                if (fotoActual) {
                    showExistingPreview(resolvePhotoUrl(fotoActual), 'Fotografia actual');
                }

                updateCounter();
            } catch (error) {
                showMessage(error.message || 'No fue posible cargar el producto.', 'error');
            }
        }

        async function guardarProducto(event) {
            event.preventDefault();
            hideMessage();

            var payload = collectPayload();
            var validationMessage = validatePayload(payload);

            if (validationMessage) {
                showMessage(validationMessage, 'error');
                return;
            }

            btnGuardar.disabled = true;
            var textoOriginal = btnGuardar.value || btnGuardar.textContent || 'Guardar producto';
            if ('value' in btnGuardar) {
                btnGuardar.value = mode === 'edit' ? 'Guardando...' : 'Creando...';
            }

            try {
                var endpoint = mode === 'edit' ? '/ActualizarProducto' : '/GuardarProducto';
                var result = await postJson(apiBase + endpoint, payload);

                if (!result.Exitoso) {
                    throw new Error(result.Mensaje || 'No fue posible guardar el producto.');
                }

                showMessage(result.Mensaje || 'Producto guardado correctamente.', 'success');
                window.setTimeout(function () {
                    window.location.href = 'productos.aspx?' + (mode === 'edit' ? 'editado=1' : 'nuevo=1');
                }, 600);
            } catch (error) {
                showMessage(error.message || 'No fue posible guardar el producto.', 'error');
            } finally {
                btnGuardar.disabled = false;
                if ('value' in btnGuardar) {
                    btnGuardar.value = textoOriginal;
                }
            }
        }

        if (txtDescripcion) {
            txtDescripcion.addEventListener('input', updateCounter);
            updateCounter();
        }

        if (fileInput) {
            fileInput.addEventListener('change', function () {
                handleFile(this.files[0]).catch(function () {
                    showError('No se pudo leer la imagen seleccionada.');
                });
            });
        }

        if (dropZone) {
            dropZone.addEventListener('dragover', function (event) {
                event.preventDefault();
                dropZone.classList.add('drag-over');
            });

            dropZone.addEventListener('dragleave', function () {
                dropZone.classList.remove('drag-over');
            });

            dropZone.addEventListener('drop', function (event) {
                event.preventDefault();
                dropZone.classList.remove('drag-over');

                var file = event.dataTransfer.files[0];
                if (!file) {
                    return;
                }

                try {
                    var dt = new DataTransfer();
                    dt.items.add(file);
                    fileInput.files = dt.files;
                } catch (error) {
                }

                handleFile(file).catch(function () {
                    showError('No se pudo leer la imagen seleccionada.');
                });
            });

            dropZone.addEventListener('keydown', function (event) {
                if (event.key === 'Enter' || event.key === ' ') {
                    event.preventDefault();
                    fileInput.click();
                }
            });
        }

        if (removeBtn) {
            removeBtn.addEventListener('click', function (event) {
                event.preventDefault();
                clearPhoto();
            });
        }

        form.addEventListener('submit', guardarProducto);

        cargarCategoriasDesdeApi().then(cargarProducto);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initProductoForm);
    } else {
        initProductoForm();
    }
})();
