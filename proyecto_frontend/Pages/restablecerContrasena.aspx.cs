using System;
using System.Web.UI;

namespace proyecto_frontend.Pages
{
    public partial class restablecerContrasena : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlForm.Visible = true;
                pnlSuccess.Visible = false;
                pnlError.Visible = false;
            }
        }

        protected void btnGuardarContrasena_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string correo = txtCorreo.Text.Trim().ToLowerInvariant();
            string nuevaContrasena = txtNuevaContrasena.Text;

            bool existe = !string.IsNullOrWhiteSpace(correo);

            if (!existe)
            {
                pnlError.Visible = true;
                litError.Text = "No encontramos una cuenta asociada a ese correo.";
                pnlForm.Visible = true;
                pnlSuccess.Visible = false;
                return;
            }

            pnlError.Visible = false;

            // TODO: Buscar el usuario por correo, hashear la nueva contraseña y actualizarla en la base de datos.
            // TODO: Invalidar sesiones activas del usuario si tu implementación lo requiere.
            System.Diagnostics.Debug.WriteLine("[RESET] Contraseña actualizada para: " + correo);

            txtCorreo.Text = string.Empty;
            txtNuevaContrasena.Text = string.Empty;

            pnlForm.Visible = false;
            pnlSuccess.Visible = true;
        }

        protected void btnIrAlLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/login.aspx");
        }
    }
}
