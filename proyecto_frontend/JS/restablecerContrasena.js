document.addEventListener("DOMContentLoaded", () => {

    const boton = document.getElementById("btnGuardarContrasena");
    const passwordInput = document.getElementById("txtNuevaContrasena");

    if (!boton) {
        return;
    }

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

    // Restablecer contraseña
    boton.addEventListener("click", async function (e) {

        e.preventDefault();

        const correo = document.getElementById("txtCorreo").value.trim();
        const nuevaContrasena = document.getElementById("txtNuevaContrasena").value.trim();

        if (!correo) {
            alert("Debe ingresar un correo.");
            return;
        }

        if (!nuevaContrasena) {
            alert("Debe ingresar una contraseña.");
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
                alert(data.Mensaje || "No fue posible actualizar la contraseña.");
                return;
            }

            alert("Contraseña actualizada correctamente.");
            window.location.href = "login.aspx";

        } catch (error) {

            console.error(error);
            alert("Error al conectar con el servidor.");
        }
    });
});