(function () {

    /* ══════════════════════════════════
       STEPPER: actualiza los círculos
       según la variable expuesta por el
       code-behind vía Literal en el body
    ══════════════════════════════════ */
    var currentStep = parseInt(
        document.body.getAttribute('data-step') || '1', 10
    );

    function updateStepper(step) {
        for (var i = 1; i <= 3; i++) {
            var circle = document.getElementById('scStep' + i);
            var label  = document.getElementById('slStep' + i);
            var conn   = document.getElementById('conn' + i);

            circle.classList.remove('active','done');
            label.classList.remove('active','done');

            if (i < step) {
                circle.classList.add('done');
                circle.textContent = '✔';
                label.classList.add('done');
            } else if (i === step) {
                circle.classList.add('active');
                label.classList.add('active');
            }
            if (conn && i < step) conn.classList.add('done');
            else if (conn) conn.classList.remove('done');
        }
    }
    updateStepper(currentStep);

    /* ══════════════════════════════════
       OTP — code digit inputs
    ══════════════════════════════════ */
    var digits  = Array.from(document.querySelectorAll('.code-digit'));
    var hfCode  = document.getElementById('<%= hfCodigo.ClientID %>');

    if (digits.length) {
        digits.forEach(function (inp, idx) {
            inp.addEventListener('input', function () {
                /* keep only last digit typed */
                this.value = this.value.replace(/\D/g,'').slice(-1);
                this.classList.toggle('filled', this.value.length > 0);
                /* advance focus */
                if (this.value && idx < digits.length - 1) digits[idx + 1].focus();
                assembleCode();
            });

            inp.addEventListener('keydown', function (e) {
                if (e.key === 'Backspace' && !this.value && idx > 0) {
                    digits[idx - 1].focus();
                    digits[idx - 1].value = '';
                    digits[idx - 1].classList.remove('filled');
                    assembleCode();
                }
                /* paste handling */
                if (e.key === 'v' && (e.ctrlKey || e.metaKey)) return;
            });

            inp.addEventListener('paste', function (e) {
                e.preventDefault();
                var pasted = (e.clipboardData || window.clipboardData)
                    .getData('text').replace(/\D/g,'').slice(0, 6);
                pasted.split('').forEach(function (ch, i) {
                    if (digits[i]) {
                        digits[i].value = ch;
                        digits[i].classList.add('filled');
                    }
                });
                assembleCode();
                var nextEmpty = digits.find(function (d) { return !d.value; });
                if (nextEmpty) nextEmpty.focus();
                else digits[digits.length - 1].focus();
            });
        });

        function assembleCode() {
            var code = digits.map(function (d) { return d.value; }).join('');
            if (hfCode) hfCode.value = code;
            var hint = document.getElementById('codeHint');
            if (hint) {
                var filled = code.replace(/\s/g,'').length;
                hint.textContent = filled === 6
                    ? 'Código completo — haz clic en Verificar'
                    : filled + ' de 6 dígitos ingresados';
            }
        }
    }

    /* ══════════════════════════════════
       RESEND TIMER (60 s countdown)
    ══════════════════════════════════ */
    var btnResend  = document.getElementById('btnResend');
    var timerEl    = document.getElementById('resendTimer');
    var btnHidden  = document.getElementById('<%= btnReenviarCodigo.ClientID %>');

    if (btnResend && timerEl) {
        var secs = 60;
        var interval = setInterval(function () {
            secs--;
            timerEl.textContent = secs;
            if (secs <= 0) {
                clearInterval(interval);
                btnResend.disabled = false;
                btnResend.textContent = 'Reenviar código';
            }
        }, 1000);

        btnResend.addEventListener('click', function () {
            if (btnHidden) btnHidden.click();
        });
    }

    /* ══════════════════════════════════
       PASSWORD TOGGLE (show / hide)
    ══════════════════════════════════ */
    [
        { btn: 'togglePw1', open: 'eyeOpen1', closed: 'eyeClosed1' },
        { btn: 'togglePw2', open: 'eyeOpen2', closed: 'eyeClosed2' }
    ].forEach(function (cfg) {
        var btn = document.getElementById(cfg.btn);
        if (!btn) return;
        btn.addEventListener('click', function () {
            var targetId = btn.getAttribute('data-target');
            var input    = document.getElementById(targetId);
            if (!input) return;
            var isPassword = input.type === 'password';
            input.type = isPassword ? 'text' : 'password';
            document.getElementById(cfg.open).style.display   = isPassword ? 'none' : '';
            document.getElementById(cfg.closed).style.display = isPassword ? ''     : 'none';
            btn.setAttribute('aria-pressed',  String(isPassword));
            btn.setAttribute('aria-label', isPassword ? 'Ocultar contraseña' : 'Mostrar contraseña');
        });
    });

    /* ══════════════════════════════════
       PASSWORD STRENGTH METER
    ══════════════════════════════════ */
    var pwInput  = document.getElementById('<%= txtNuevaContrasena.ClientID %>');
    var bars     = [
        document.getElementById('sb1'), document.getElementById('sb2'),
        document.getElementById('sb3'), document.getElementById('sb4')
    ];
    var slLabel  = document.getElementById('strengthLabel');

    var reqs = {
        'req-len':     function (v) { return v.length >= 8; },
        'req-upper':   function (v) { return /[A-Z]/.test(v); },
        'req-lower':   function (v) { return /[a-z]/.test(v); },
        'req-num':     function (v) { return /\d/.test(v); },
        'req-special': function (v) { return /[\W_]/.test(v); }
    };

    var labels = ['', 'Débil', 'Regular', 'Buena', 'Fuerte'];
    var lCss   = ['', 's1',    's2',      's3',    's4'];
    var fills  = ['', 'filled-1', 'filled-2', 'filled-3', 'filled-4'];

    if (pwInput) {
        pwInput.addEventListener('input', function () {
            var v = this.value;
            var score = 0;

            Object.keys(reqs).forEach(function (id) {
                var el = document.getElementById(id);
                var ok = reqs[id](v);
                if (ok) score++;
                if (el) el.classList.toggle('met', ok);
            });

            bars.forEach(function (b, i) {
                b.className = 'strength-bar' + (i < score ? ' ' + fills[score] : '');
            });
            if (slLabel) {
                slLabel.textContent  = v.length ? labels[score] : '';
                slLabel.className    = 'strength-label' + (v.length ? ' ' + lCss[score] : '');
                slLabel.setAttribute('aria-label', 'Fortaleza de la contraseña: ' + (labels[score] || 'Sin evaluar'));
            }
        });
    }

    /* ══════════════════════════════════
       CONFIRM PASSWORD MATCH (client)
    ══════════════════════════════════ */
    var pwConfirm = document.getElementById('<%= txtConfirmarContrasena.ClientID %>');
    var matchDiv  = document.getElementById('matchFeedback');

    function checkMatch() {
        if (!pwInput || !pwConfirm || !matchDiv) return;
        var v1 = pwInput.value, v2 = pwConfirm.value;
        if (!v2) { matchDiv.style.display = 'none'; return; }
        matchDiv.style.display = '';
        if (v1 === v2) {
            matchDiv.innerHTML = '<div class="alert success" style="margin:0;padding:8px 12px;font-size:12px"><span>&#10003; Las contraseñas coinciden.</span></div>';
        } else {
            matchDiv.innerHTML = '<div class="alert error" style="margin:0;padding:8px 12px;font-size:12px"><span>&#10005; Las contraseñas no coinciden.</span></div>';
        }
    }
    if (pwConfirm) {
        pwConfirm.addEventListener('input', checkMatch);
        if (pwInput) pwInput.addEventListener('input', checkMatch);
    }

    /* ══════════════════════════════════
       SUBMIT BUTTON LOADING STATE
    ══════════════════════════════════ */
    document.querySelectorAll('.btn-primary').forEach(function (btn) {
        if (btn.tagName === 'INPUT') {
            btn.addEventListener('click', function () {
                if (btn.form && !btn.form.checkValidity()) return;
                /* wrap text in label span for loading swap */
            });
        }
    });

})();