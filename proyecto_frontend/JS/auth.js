function obtenerUsuarioAutenticado() {
    const usuarioGuardado =
        sessionStorage.getItem("usuario") ||
        localStorage.getItem("usuario");

    if (!usuarioGuardado) {
        window.location.href = "login.aspx";
        return null;
    }

    return JSON.parse(usuarioGuardado);
}

function cerrarSesion() {
    sessionStorage.removeItem("usuario");
    localStorage.removeItem("usuario");
    window.location.href = "login.aspx";
}