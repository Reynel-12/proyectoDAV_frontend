(function () {
    var btnTogglePassword = document.getElementById('btnTogglePassword');
    var txtContrasena = document.getElementById('txtContrasena');

    if (!btnTogglePassword || !txtContrasena) {
        return;
    }

    btnTogglePassword.addEventListener('click', function () {
        var isPassword = txtContrasena.type === 'password';
        txtContrasena.type = isPassword ? 'text' : 'password';
        btnTogglePassword.setAttribute('aria-label', isPassword ? 'Ocultar contraseña' : 'Mostrar u ocultar contraseña');
    });
})();
