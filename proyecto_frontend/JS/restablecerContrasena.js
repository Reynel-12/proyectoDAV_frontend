(function () {
    var toggleBtn = document.getElementById('togglePw1');
    var passwordInput = document.getElementById('txtNuevaContrasena');

    if (toggleBtn && passwordInput) {
        toggleBtn.addEventListener('click', function () {
            var isPassword = passwordInput.type === 'password';
            passwordInput.type = isPassword ? 'text' : 'password';
            document.getElementById('eyeOpen1').style.display = isPassword ? 'none' : '';
            document.getElementById('eyeClosed1').style.display = isPassword ? '' : 'none';
            toggleBtn.setAttribute('aria-pressed', String(isPassword));
            toggleBtn.setAttribute('aria-label', isPassword ? 'Ocultar contraseña' : 'Mostrar contraseña');
        });
    }

    var bars = [
        document.getElementById('sb1'),
        document.getElementById('sb2'),
        document.getElementById('sb3'),
        document.getElementById('sb4')
    ];
    var strengthLabel = document.getElementById('strengthLabel');

    var requirements = {
        'req-len': function (value) { return value.length >= 8; },
        'req-upper': function (value) { return /[A-Z]/.test(value); },
        'req-lower': function (value) { return /[a-z]/.test(value); },
        'req-num': function (value) { return /\d/.test(value); },
        'req-special': function (value) { return /[\W_]/.test(value); }
    };

    var labels = ['', 'Débil', 'Regular', 'Buena', 'Fuerte'];
    var labelClasses = ['', 's1', 's2', 's3', 's4'];
    var fills = ['', 'filled-1', 'filled-2', 'filled-3', 'filled-4'];

    function updateStrength() {
        if (!passwordInput) {
            return;
        }

        var value = passwordInput.value;
        var score = 0;

        Object.keys(requirements).forEach(function (id) {
            var element = document.getElementById(id);
            var matched = requirements[id](value);
            if (matched) {
                score++;
            }
            if (element) {
                element.classList.toggle('met', matched);
            }
        });

        bars.forEach(function (bar, index) {
            if (!bar) {
                return;
            }
            bar.className = 'strength-bar' + (index < score ? ' ' + fills[score] : '');
        });

        if (strengthLabel) {
            strengthLabel.textContent = value.length ? labels[score] : '';
            strengthLabel.className = 'strength-label' + (value.length ? ' ' + labelClasses[score] : '');
            strengthLabel.setAttribute('aria-label', 'Fortaleza de la contraseña: ' + (labels[score] || 'Sin evaluar'));
        }
    }

    if (passwordInput) {
        passwordInput.addEventListener('input', updateStrength);
        updateStrength();
    }
})();
