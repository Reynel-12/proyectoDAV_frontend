document.addEventListener("DOMContentLoaded", () => {

    const boton = document.getElementById("btnGuardarContrasena");
    const passwordInput = document.getElementById("txtNuevaContrasena");
    const passwordToggles = document.querySelectorAll(".btn-pw-toggle");

    if (!boton) {
        return;
    }

    passwordToggles.forEach(setupPasswordToggle);

    // Mostrar requisitos en verde
    if (passwordInput) {

        const requirements = {
            "req-len": value => value.length >= 8,
            "req-upper": value => /[A-Z]/.test(value),
            "req-lower": value => /[a-z]/.test(value),
            "req-num": value => /\d/.test(value),
            "req-special": value => /[\W_]/.test(value)
        };

        function actualizarRequisitos() {

            const value = passwordInput.value;

            Object.keys(requirements).forEach(id => {

                const elemento = document.getElementById(id);

                if (!elemento) return;

                const cumple = requirements[id](value);

                elemento.classList.toggle("met", cumple);
            });
        }

        passwordInput.addEventListener("input", actualizarRequisitos);
        actualizarRequisitos();
    }

    // Restablecer contraseÃ±a
    boton.addEventListener("click", async function (e) {

        e.preventDefault();

        const correo = document.getElementById("txtCorreo").value.trim();
        const nuevaContrasena = document.getElementById("txtNuevaContrasena").value.trim();

        if (!correo) {
            alert("Debe ingresar un correo.");
            return;
        }

        if (!nuevaContrasena) {
            alert("Debe ingresar una contraseÃ±a.");
            return;
        }

        try {

            const response = await fetch(
                "https://localhost:44316/usuarios.asmx/RestablecerContrasena",
                {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json; charset=utf-8"
                    },
                    body: JSON.stringify({
                        correo: correo,
                        nuevaContrasena: nuevaContrasena
                    })
                }
            );

            const result = await response.json();
            const data = result.d || result;

            if (!data.Exitoso) {
                alert(data.Mensaje || "No fue posible actualizar la contraseÃ±a.");
                return;
            }

            alert("ContraseÃ±a actualizada correctamente.");
            window.location.href = "login.aspx";

        } catch (error) {

            console.error(error);
            alert("Error al conectar con el servidor.");
        }
    });

    function setupPasswordToggle(toggleButton) {
        if (!toggleButton) {
            return;
        }

        const targetId = toggleButton.getAttribute("data-target");
        const targetInput = document.getElementById(targetId);
        const openIcon = toggleButton.querySelector("#eyeOpen1, .pw-icon-open");
        const closedIcon = toggleButton.querySelector("#eyeClosed1, .pw-icon-closed");

        if (!targetInput) {
            return;
        }

        toggleButton.addEventListener("click", () => {
            const shouldShowPassword = targetInput.type === "password";

            targetInput.type = shouldShowPassword ? "text" : "password";
            toggleButton.setAttribute("aria-pressed", shouldShowPassword ? "true" : "false");
            toggleButton.setAttribute("aria-label", shouldShowPassword ? "Ocultar contraseña" : "Mostrar contraseña");

            if (openIcon) {
                openIcon.style.display = shouldShowPassword ? "none" : "";
            }

            if (closedIcon) {
                closedIcon.style.display = shouldShowPassword ? "" : "none";
            }
        });
    }
});
