using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace proyecto_frontend.Pages
{
    public partial class nuevoUsuario : Page
    {
        private bool EsModoEdicion => !string.IsNullOrWhiteSpace(Request.QueryString["id"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarRoles();

                if (EsModoEdicion)
                {
                    ConfigurarModoEdicion();
                }
            }
        }

        private void CargarRoles()
        {
            ddlRol.Items.Clear();
            ddlRol.Items.Add(new ListItem("— Selecciona un rol —", ""));
            ddlRol.Items.Add(new ListItem("Administrador", "admin"));
            ddlRol.Items.Add(new ListItem("Supervisor", "supervisor"));
            ddlRol.Items.Add(new ListItem("Operador", "operador"));
            ddlRol.Items.Add(new ListItem("Cliente", "cliente"));
        }

        private void ConfigurarModoEdicion()
        {
            litPageTitle.Text = "Editar usuario";
            litPageSubtitle.Text = "Actualiza la información principal de la cuenta";
            litPasswordHint.Text = "Si no deseas cambiar la contraseña, puedes dejar este campo vacío.";
            btnGuardar.Text = "Guardar cambios";
            rfvContrasena.Enabled = false;
            revContrasena.Enabled = false;
            txtContrasena.Attributes["placeholder"] = "Dejar en blanco para conservar la actual";

            int id;
            if (!int.TryParse(Request.QueryString["id"], out id))
            {
                return;
            }

            switch (id)
            {
                case 1:
                    txtNombre.Text = "Carlos";
                    txtApellido.Text = "Alvarado";
                    txtCorreo.Text = "carlos.alvarado@invcontrol.com";
                    ddlRol.SelectedValue = "admin";
                    break;
                case 2:
                    txtNombre.Text = "María";
                    txtApellido.Text = "Rodríguez";
                    txtCorreo.Text = "maria.rodriguez@invcontrol.com";
                    ddlRol.SelectedValue = "operador";
                    break;
                default:
                    txtNombre.Text = "Usuario";
                    txtApellido.Text = "Demo";
                    txtCorreo.Text = "usuario.demo@invcontrol.com";
                    ddlRol.SelectedValue = "cliente";
                    break;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string nombre = txtNombre.Text.Trim();
            string apellido = txtApellido.Text.Trim();
            string rol = ddlRol.SelectedValue;
            string correo = txtCorreo.Text.Trim();
            string contrasena = txtContrasena.Text.Trim();

            if (!EsModoEdicion && string.IsNullOrWhiteSpace(contrasena))
            {
                return;
            }

            if (EsModoEdicion)
            {
                int id = int.Parse(Request.QueryString["id"]);
                Response.Redirect("usuarios.aspx?editado=1");
                return;
            }

            Response.Redirect("usuarios.aspx?nuevo=1");
        }
    }
}
