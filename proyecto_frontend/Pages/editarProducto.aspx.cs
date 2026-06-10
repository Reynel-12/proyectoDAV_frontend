using System;
using System.IO;
using System.Web.UI.WebControls;

namespace proyecto_frontend.Pages
{
    public partial class editarProducto : System.Web.UI.Page
    {
        private static readonly string[] ExtPermitidas = { ".jpg", ".jpeg", ".png" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCategorias();
            }
        }

        private void CargarCategorias()
        {
            ddlCategoria.Items.Clear();
            ddlCategoria.Items.Add(new ListItem("— Selecciona una categoría —", ""));

            foreach (string categoria in new[]
            {
                "Electrónica",
                "Papelería",
                "Lubricantes",
                "Repuestos",
                "Consumibles"
            })
            {
                ddlCategoria.Items.Add(new ListItem(categoria, categoria));
            }
        }

        protected void cvFoto_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!fuFoto.HasFile)
            {
                args.IsValid = true;
                return;
            }

            string ext = Path.GetExtension(fuFoto.FileName).ToLowerInvariant();
            args.IsValid = Array.IndexOf(ExtPermitidas, ext) >= 0;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
        }
    }
}
