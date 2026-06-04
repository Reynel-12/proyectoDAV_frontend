using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace proyecto_frontend.Pages
{
    public partial class restablecerContraseña : System.Web.UI.Page
    {

        // Expone el paso actual al JS del stepper
        public int StepActual { get; private set; } = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarPaso(1);
            }
        }

        /* ═══════════════════════════════════════
           PASO 1 — Enviar código al correo
        ═══════════════════════════════════════ */
        protected void btnEnviarCodigo_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string correo = txtCorreo.Text.Trim().ToLower();

            // TODO: verificar si el correo existe en la BD
            // bool existe = UsuarioService.ExisteCorreo(correo);
            bool existe = true; // mock

            if (!existe)
            {
                pnlError1.Visible = true;
                litError1.Text = "No encontramos una cuenta asociada a ese correo. Verifica e intenta de nuevo.";
                return;
            }

            // Generar código OTP de 6 dígitos
            string codigo = GenerarCodigo6Digitos();

            // Guardar en sesión con expiración
            Session["Reset_Correo"] = correo;
            Session["Reset_Codigo"] = codigo;
            Session["Reset_Expira"] = DateTime.Now.AddMinutes(10);
            Session["Reset_Intentos"] = 0;

            // TODO: enviar email con el código
            // EmailService.EnviarCodigoReset(correo, codigo);
            // En desarrollo puedes mostrarlo en consola:
            System.Diagnostics.Debug.WriteLine($"[RESET] Código para {correo}: {codigo}");

            // Mostrar correo parcialmente enmascarado
            litCorreoMasked.Text = MascararCorreo(correo);

            MostrarPaso(2);
        }

        /* ═══════════════════════════════════════
           PASO 2 — Verificar código OTP
        ═══════════════════════════════════════ */
        protected void btnVerificarCodigo_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string codigoIngresado = hfCodigo.Value.Trim();
            string codigoEsperado = Session["Reset_Codigo"]?.ToString();
            DateTime? expira = Session["Reset_Expira"] as DateTime?;
            int intentos = (int)(Session["Reset_Intentos"] ?? 0);

            // Control de intentos (máx. 5)
            if (intentos >= 5)
            {
                pnlError2.Visible = true;
                litError2.Text = "Superaste el límite de intentos. Por favor solicita un nuevo código.";
                LimpiarSesionReset();
                MostrarPaso(1);
                return;
            }

            // Verificar expiración
            if (!expira.HasValue || DateTime.Now > expira.Value)
            {
                pnlError2.Visible = true;
                litError2.Text = "El código ha expirado. Por favor solicita uno nuevo.";
                LimpiarSesionReset();
                return;
            }

            // Comparar código (timing-safe)
            if (!CodigosIguales(codigoIngresado, codigoEsperado))
            {
                Session["Reset_Intentos"] = intentos + 1;
                int restantes = 5 - (intentos + 1);
                pnlError2.Visible = true;
                litError2.Text = restantes > 0
                    ? $"Código incorrecto. Te quedan {restantes} intento(s)."
                    : "Código incorrecto. Has superado el límite de intentos.";
                return;
            }

            // ✔ Código correcto — marcar como verificado
            Session["Reset_Verificado"] = true;
            Session.Remove("Reset_Codigo"); // invalidar código ya usado
            MostrarPaso(3);
        }

        protected void btnReenviarCodigo_Click(object sender, EventArgs e)
        {
            string correo = Session["Reset_Correo"]?.ToString();
            if (string.IsNullOrEmpty(correo)) { MostrarPaso(1); return; }

            string codigo = GenerarCodigo6Digitos();
            Session["Reset_Codigo"] = codigo;
            Session["Reset_Expira"] = DateTime.Now.AddMinutes(10);
            Session["Reset_Intentos"] = 0;

            // TODO: EmailService.EnviarCodigoReset(correo, codigo);
            System.Diagnostics.Debug.WriteLine($"[RESET] Reenvío para {correo}: {codigo}");

            litCorreoMasked.Text = MascararCorreo(correo);
            pnlInfoCode.Visible = true;
            litInfoCode.Text = "Se reenvió el código correctamente. Revisa tu correo.";
            pnlError2.Visible = false;
            MostrarPaso(2);
        }

        protected void btnVolverPaso1_Click(object sender, EventArgs e)
        {
            LimpiarSesionReset();
            MostrarPaso(1);
        }

        /* ═══════════════════════════════════════
           PASO 3 — Guardar nueva contraseña
        ═══════════════════════════════════════ */
        protected void btnGuardarContrasena_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // Validar que el flujo pasó por verificación
            if (Session["Reset_Verificado"] == null || !(bool)Session["Reset_Verificado"])
            {
                pnlError3.Visible = true;
                litError3.Text = "Sesión inválida. Por favor inicia el proceso de nuevo.";
                LimpiarSesionReset();
                MostrarPaso(1);
                return;
            }

            string correo = Session["Reset_Correo"]?.ToString();
            string nuevaContrasena = txtNuevaContrasena.Text;
            string confirmacion = txtConfirmarContrasena.Text;

            if (nuevaContrasena != confirmacion)
            {
                pnlError3.Visible = true;
                litError3.Text = "Las contraseñas no coinciden. Por favor verifica.";
                return;
            }

            if (string.IsNullOrEmpty(correo))
            {
                pnlError3.Visible = true;
                litError3.Text = "Sesión expirada. Por favor inicia el proceso nuevamente.";
                MostrarPaso(1);
                return;
            }

            // TODO: hashear y actualizar en BD
            // string hash = PasswordHasher.Hash(nuevaContrasena);
            // UsuarioService.ActualizarContrasena(correo, hash);
            // UsuarioService.InvalidarTodasLasSesiones(correo);

            LimpiarSesionReset();
            MostrarPaso(4);
        }

        protected void btnIrAlLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/login.aspx");
        }

        /* ═══════════════════════════════════════
           HELPERS
        ═══════════════════════════════════════ */

        private void MostrarPaso(int paso)
        {
            StepActual = paso;
            pnlStep1.Visible = paso == 1;
            pnlStep2.Visible = paso == 2;
            pnlStep3.Visible = paso == 3;
            pnlSuccess.Visible = paso == 4;
        }

        private static string GenerarCodigo6Digitos()
        {
            var rng = RandomNumberGenerator.Create();
            var bytes = new byte[4];
            rng.GetBytes(bytes);
            uint num = BitConverter.ToUInt32(bytes, 0) % 1_000_000;
            return num.ToString("D6");
        }

        /// <summary>Comparación de strings en tiempo constante para evitar timing attacks.</summary>
        private static bool CodigosIguales(string a, string b)
        {
            if (a == null || b == null || a.Length != b.Length) return false;
            int diff = 0;
            for (int i = 0; i < a.Length; i++)
                diff |= a[i] ^ b[i];
            return diff == 0;
        }

        private static string MascararCorreo(string correo)
        {
            if (string.IsNullOrEmpty(correo)) return correo;
            int at = correo.IndexOf('@');
            if (at < 2) return correo;
            return correo[0] + new string('*', Math.Min(at - 1, 4)) + correo.Substring(at);
        }

        private void LimpiarSesionReset()
        {
            Session.Remove("Reset_Correo");
            Session.Remove("Reset_Codigo");
            Session.Remove("Reset_Expira");
            Session.Remove("Reset_Intentos");
            Session.Remove("Reset_Verificado");
        }
    }
}