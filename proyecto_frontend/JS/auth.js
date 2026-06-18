function leerUsuarioGuardado() {
    const usuarioGuardado =
        sessionStorage.getItem("usuario") ||
        localStorage.getItem("usuario");

    if (!usuarioGuardado) {
        return null;
    }

    try {
        return JSON.parse(usuarioGuardado);
    } catch (error) {
        sessionStorage.removeItem("usuario");
        localStorage.removeItem("usuario");
        return null;
    }
}

function normalizarRol(rol) {
    return String(rol || "")
        .trim()
        .toLowerCase();
}

function esAdministrador(usuario) {
    return normalizarRol(usuario && usuario.Rol) === "administrador";
}

function limpiarSesionFrontend() {
    sessionStorage.removeItem("usuario");
    localStorage.removeItem("usuario");
}

function redirigirA(ruta) {
    window.location.href = ruta || "login.aspx";
}

function obtenerUsuarioAutenticado() {
    const usuario = leerUsuarioGuardado();

    if (!usuario) {
        redirigirA("login.aspx");
        return null;
    }

    return usuario;
}

function requerirAutenticacion(opciones) {
    const config = opciones || {};
    const usuario = leerUsuarioGuardado();

    if (!usuario) {
        redirigirA(config.loginPath || "login.aspx");
        return null;
    }

    return usuario;
}

function requerirAdministrador(opciones) {
    const config = opciones || {};
    const usuario = requerirAutenticacion(config);

    if (!usuario) {
        return null;
    }

    if (!esAdministrador(usuario)) {
        redirigirA(config.redirectPath || "dashboard.aspx");
        return null;
    }

    return usuario;
}

function aplicarVisibilidadPorRol(root, usuario) {
    const scope = root || document;
    const usuarioActual = usuario || leerUsuarioGuardado();
    const adminOnlyElements = scope.querySelectorAll("[data-admin-only='true']");
    const canViewAdminSections = esAdministrador(usuarioActual);

    adminOnlyElements.forEach((element) => {
        element.hidden = !canViewAdminSections;
        element.setAttribute("aria-hidden", canViewAdminSections ? "false" : "true");
    });
}

function cerrarSesion() {
    limpiarSesionFrontend();
    redirigirA("login.aspx");
}

window.AppAuth = {
    leerUsuarioGuardado,
    normalizarRol,
    esAdministrador,
    limpiarSesionFrontend,
    redirigirA,
    obtenerUsuarioAutenticado,
    requerirAutenticacion,
    requerirAdministrador,
    aplicarVisibilidadPorRol,
    cerrarSesion
};
