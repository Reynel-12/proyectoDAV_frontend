(function () {

    /* ── sidebar toggle ── */
    var menuBtn = document.getElementById('menuBtn');
    var sidebar = document.getElementById('sidebar');
    var overlay = document.getElementById('sidebarOverlay');

    function openSidebar() { sidebar.classList.add('open'); overlay.classList.add('active'); menuBtn.setAttribute('aria-expanded', 'true'); }
    function closeSidebar() { sidebar.classList.remove('open'); overlay.classList.remove('active'); menuBtn.setAttribute('aria-expanded', 'false'); }

    menuBtn.addEventListener('click', function () { sidebar.classList.contains('open') ? closeSidebar() : openSidebar(); });
    overlay.addEventListener('click', closeSidebar);
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') closeSidebar(); });

    /* ── char counter ── */
    var txtDesc = document.getElementById('<%= txtDescripcion.ClientID %>');
    var counter = document.getElementById('charCounter');
    var MAX_CHARS = 300;

    function updateCounter() {
        var len = txtDesc ? txtDesc.value.length : 0;
        counter.textContent = len + ' / ' + MAX_CHARS;
        counter.className = 'char-counter' +
            (len >= MAX_CHARS ? ' at-limit' :
                len >= MAX_CHARS * .85 ? ' near-limit' : '');
    }
    if (txtDesc) {
        txtDesc.addEventListener('input', updateCounter);
        updateCounter();
    }

    /* ── photo upload ── */
    var ALLOWED_EXTS = ['jpg', 'jpeg', 'png'];
    var ALLOWED_TYPES = ['image/jpeg', 'image/png'];

    var dropZone = document.getElementById('dropZone');
    var fileInput = document.getElementById('<%= fuFoto.ClientID %>');
    var previewWrap = document.getElementById('photoPreview');
    var previewImg = document.getElementById('previewImg');
    var previewName = document.getElementById('previewName');
    var previewSize = document.getElementById('previewSize');
    var removeBtn = document.getElementById('btnRemovePhoto');
    var errorMsg = document.getElementById('photoErrorMsg');
    var uploadIcon = document.getElementById('uploadIcon');

    function formatBytes(bytes) {
        if (bytes < 1024) return bytes + ' B';
        if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB';
        return (bytes / 1048576).toFixed(2) + ' MB';
    }

    function getExt(filename) {
        return filename.split('.').pop().toLowerCase();
    }

    function isValidFile(file) {
        return ALLOWED_EXTS.includes(getExt(file.name)) &&
            ALLOWED_TYPES.includes(file.type);
    }

    function showPreview(file) {
        var reader = new FileReader();
        reader.onload = function (e) {
            previewImg.src = e.target.result;
            previewName.textContent = file.name;
            previewSize.textContent = formatBytes(file.size);
            previewWrap.classList.add('visible');
        };
        reader.readAsDataURL(file);

        dropZone.classList.remove('has-error');
        dropZone.classList.add('has-file');
        uploadIcon.textContent = '✔';
        errorMsg.classList.remove('visible');
    }

    function clearPhoto() {
        previewImg.src = '#';
        previewName.textContent = '';
        previewSize.textContent = '';
        previewWrap.classList.remove('visible');
        dropZone.classList.remove('has-file', 'has-error');
        uploadIcon.textContent = '📷';
        errorMsg.classList.remove('visible');
        /* reset the file input */
        try { fileInput.value = ''; } catch (ex) { fileInput.type = 'text'; fileInput.type = 'file'; }
    }

    function showError() {
        dropZone.classList.remove('has-file');
        dropZone.classList.add('has-error');
        uploadIcon.textContent = '⚠';
        errorMsg.classList.add('visible');
        previewWrap.classList.remove('visible');
        try { fileInput.value = ''; } catch (ex) { fileInput.type = 'text'; fileInput.type = 'file'; }
    }

    function handleFile(file) {
        if (!file) return;
        if (isValidFile(file)) {
            showPreview(file);
        } else {
            showError();
        }
    }

    /* native file input change */
    if (fileInput) {
        fileInput.addEventListener('change', function () {
            handleFile(this.files[0]);
        });
    }

    /* drag & drop */
    dropZone.addEventListener('dragover', function (e) {
        e.preventDefault();
        dropZone.classList.add('drag-over');
    });
    dropZone.addEventListener('dragleave', function () {
        dropZone.classList.remove('drag-over');
    });
    dropZone.addEventListener('drop', function (e) {
        e.preventDefault();
        dropZone.classList.remove('drag-over');
        var file = e.dataTransfer.files[0];
        if (file) {
            /* assign to input so the server can read fuFoto.HasFile */
            try {
                var dt = new DataTransfer();
                dt.items.add(file);
                fileInput.files = dt.files;
            } catch (_) { }
            handleFile(file);
        }
    });

    /* keyboard: Enter/Space abre el picker */
    dropZone.addEventListener('keydown', function (e) {
        if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            fileInput.click();
        }
    });

    /* remove button */
    if (removeBtn) {
        removeBtn.addEventListener('click', function (e) {
            e.stopPropagation();
            clearPhoto();
        });
    }

})();