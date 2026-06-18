(function () {

    function getAppAuth() {
        return window.AppAuth || null;
    }

    function validarSesion() {
        const auth = getAppAuth();

        if (!auth || typeof auth.requerirAutenticacion !== "function") {
            window.location.href = "login.aspx";
            return null;
        }

        return auth.requerirAutenticacion({
            loginPath: "login.aspx"
        });
    }

    function cargarDatosUsuario(usuario) {
        if (!usuario) return;

        const avatar = document.querySelector(".tb-avatar");
        if (avatar) {
            let iniciales = "";
            if (usuario.Nombre) iniciales += usuario.Nombre.charAt(0);
            if (usuario.Apellido) iniciales += usuario.Apellido.charAt(0);

            avatar.textContent = iniciales.toUpperCase();
            avatar.title = usuario.Nombre + " " + usuario.Apellido;
            avatar.setAttribute("aria-label", "Usuario: " + usuario.Nombre + " " + usuario.Apellido);

            const colores = ["#3b82f6", "#22c55e", "#a855f7", "#f59e0b", "#ef4444", "#06b6d4"];
            const correo = usuario.Usuario || usuario.Correo || "";
            let hash = 0;
            for (let i = 0; i < correo.length; i++) hash += correo.charCodeAt(i);
            avatar.style.background = colores[hash % colores.length];
        }
    }

    function aplicarVisibilidadSegunRol(usuario) {
        const auth = getAppAuth();
        if (auth && typeof auth.aplicarVisibilidadPorRol === "function") {
            auth.aplicarVisibilidadPorRol(document, usuario);
        }
    }

    function cerrarSesion() {
        const auth = getAppAuth();
        if (auth && typeof auth.cerrarSesion === "function") {
            auth.cerrarSesion();
            return;
        }

        window.location.href = "login.aspx";
    }

    function initAppShell() {

        const menuBtn = document.getElementById("menuBtn");
        const sidebar = document.getElementById("sidebar");
        const overlay = document.getElementById("sidebarOverlay");

        if (!menuBtn || !sidebar || !overlay) {
            return;
        }

        function isCompactLayout() {
            return window.getComputedStyle(menuBtn).display !== "none";
        }

        function setOpenState(isOpen) {

            const shouldOpen =
                isOpen && isCompactLayout();

            sidebar.classList.toggle(
                "open",
                shouldOpen
            );

            overlay.classList.toggle(
                "active",
                shouldOpen
            );

            overlay.setAttribute(
                "aria-hidden",
                shouldOpen ? "false" : "true"
            );

            menuBtn.setAttribute(
                "aria-expanded",
                shouldOpen ? "true" : "false"
            );

            document.body.classList.toggle(
                "app-shell-open",
                shouldOpen
            );
        }

        function openSidebar() {
            setOpenState(true);
        }

        function closeSidebar() {
            setOpenState(false);
        }

        menuBtn.addEventListener("click", function () {

            if (!isCompactLayout()) {
                return;
            }

            setOpenState(
                !sidebar.classList.contains("open")
            );
        });

        overlay.addEventListener(
            "click",
            closeSidebar
        );

        sidebar.addEventListener(
            "click",
            function (event) {

                if (
                    isCompactLayout() &&
                    event.target.closest("a")
                ) {
                    closeSidebar();
                }
            }
        );

        document.addEventListener(
            "keydown",
            function (event) {

                if (event.key === "Escape") {
                    closeSidebar();
                }
            }
        );

        window.addEventListener(
            "resize",
            function () {

                if (!isCompactLayout()) {
                    closeSidebar();
                }
            }
        );

        window.appShell = {
            openSidebar,
            closeSidebar
        };
    }

    window.cerrarSesion = cerrarSesion;

    if (document.readyState === "loading") {

        document.addEventListener(
            "DOMContentLoaded",
            function () {
                const usuario = validarSesion();
                cargarDatosUsuario(usuario);
                aplicarVisibilidadSegunRol(usuario);
                initAppShell();
            }
        );

    } else {

        const usuario = validarSesion();
        cargarDatosUsuario(usuario);
        aplicarVisibilidadSegunRol(usuario);
        initAppShell();
    }

})();
