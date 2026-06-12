document.addEventListener("DOMContentLoaded", () => {

    const usuario =
        sessionStorage.getItem("usuario") ||
        localStorage.getItem("usuario");

    if (usuario) {
        window.location.href = "dashboard.aspx";
        return;
    }

    const form = document.getElementById("form1");
    const emailInput = document.getElementById("txtEmail");
    const passwordInput = document.getElementById("txtPassword");
    const rememberInput = document.getElementById("chkRemember");
    const messageBox = document.getElementById("loginMessage");
    const btnLogin = document.getElementById("btnLogin");

    form.addEventListener("submit", async (event) => {
        event.preventDefault();

        const email = emailInput.value.trim();
        const password = passwordInput.value.trim();
        const remember = rememberInput.checked;

        hideMessage();

        if (!email) {
            showMessage("El correo electrónico es obligatorio.");
            return;
        }

        if (!validateEmail(email)) {
            showMessage("Ingresa un correo electrónico válido.");
            return;
        }

        if (!password) {
            showMessage("La contraseña es obligatoria.");
            return;
        }

        try {

            btnLogin.disabled = true;
            btnLogin.textContent = "Ingresando...";

            const response = await fetch(
                "https://localhost:44316/login.asmx/IniciarSesion",
                {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json; charset=utf-8"
                    },
                    body: JSON.stringify({
                        correo: email,
                        password: password
                    })
                }
            );

            console.log("Status HTTP:", response.status);

            const result = await response.json();

            console.log("Respuesta completa:", result);

            const data = result.d || result;

            console.log("Datos login:", data);

            if (
                data.Exitoso === false ||
                data.Exitoso === "false" ||
                data.Exitoso === 0 ||
                data.Exitoso === null ||
                data.Exitoso === undefined
            ) {
                showMessage(data.Mensaje || "Correo o contraseña incorrectos.");
                return;
            }

            if (remember) {
                localStorage.setItem("usuario", JSON.stringify(data));
            } else {
                sessionStorage.setItem("usuario", JSON.stringify(data));
            }

            window.location.href = "dashboard.aspx";

        } catch (error) {

            console.error("Error:", error);

            showMessage(
                "Ocurrió un error al conectar con el servidor."
            );

        } finally {

            btnLogin.disabled = false;
            btnLogin.textContent = "Ingresar al sistema";

        }
    });

    function showMessage(message) {
        messageBox.style.display = "block";
        messageBox.innerHTML = message;
    }

    function hideMessage() {
        messageBox.style.display = "none";
        messageBox.innerHTML = "";
    }

    function validateEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }

});