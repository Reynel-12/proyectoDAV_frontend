(function () {
    /* preview live */
    var txtNombre = document.getElementById('<%= txtNombre.ClientID %>');
    var previewName = document.getElementById('previewName');
    var previewIcon = document.getElementById('previewIcon');
    var hfColorIdx = document.getElementById('<%= hfColorIdx.ClientID %>');
    var hfIcono = document.getElementById('<%= hfIcono.ClientID %>');

    txtNombre.addEventListener('input', function () {
        previewName.textContent = this.value.trim() || 'Nueva categoría';
    });

    /* char counter */
    var txtDesc = document.getElementById('<%= txtDescripcion.ClientID %>');
    var counter = document.getElementById('charCounter');
    var MAX_CHARS = 200;
    function updateCounter() {
        var len = txtDesc ? txtDesc.value.length : 0;
        counter.textContent = len + ' / ' + MAX_CHARS;
        counter.className = 'char-counter' + (len >= MAX_CHARS ? ' at-limit' : len >= MAX_CHARS * .85 ? ' near-limit' : '');
    }
    if (txtDesc) { txtDesc.addEventListener('input', updateCounter); updateCounter(); }

    /* color picker */
    var selectedColorIdx = 1;
    document.getElementById('colorGrid').addEventListener('click', function (e) {
        var swatch = e.target.closest('.color-swatch');
        if (!swatch) return;
        document.querySelectorAll('.color-swatch').forEach(function (s) {
            s.classList.remove('selected'); s.setAttribute('aria-checked', 'false'); s.tabIndex = -1;
        });
        swatch.classList.add('selected'); swatch.setAttribute('aria-checked', 'true'); swatch.tabIndex = 0;
        selectedColorIdx = swatch.getAttribute('data-idx');
        hfColorIdx.value = selectedColorIdx;
        applyPreviewColor();
    });

    function applyPreviewColor() {
        var idx = selectedColorIdx;
        previewIcon.style.background = 'var(--cat-bg-' + idx + ')';
        previewIcon.style.color = 'var(--cat-clr-' + idx + ')';
    }

    /* icon picker */
    document.getElementById('iconGrid').addEventListener('click', function (e) {
        var btn = e.target.closest('.icon-btn');
        if (!btn) return;
        document.querySelectorAll('.icon-btn').forEach(function (b) {
            b.classList.remove('selected'); b.setAttribute('aria-pressed', 'false');
        });
        btn.classList.add('selected'); btn.setAttribute('aria-pressed', 'true');
        var icon = btn.getAttribute('data-icon');
        previewIcon.innerHTML = icon;
        hfIcono.value = icon;
    });

    /* keyboard nav for color swatches */
    document.getElementById('colorGrid').addEventListener('keydown', function (e) {
        var swatches = Array.from(document.querySelectorAll('.color-swatch'));
        var idx = swatches.indexOf(document.activeElement);
        if (idx === -1) return;
        if (e.key === 'ArrowRight' || e.key === 'ArrowDown') { e.preventDefault(); swatches[(idx + 1) % swatches.length].focus(); }
        if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') { e.preventDefault(); swatches[(idx - 1 + swatches.length) % swatches.length].focus(); }
        if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); document.activeElement.click(); }
    });
})();
