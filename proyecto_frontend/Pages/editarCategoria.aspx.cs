using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace proyecto_frontend.Pages
{
    public partial class editarCategoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string nombre = txtNombre.Text.Trim();
            string descripcion = txtDescripcion.Text.Trim();

            int id = int.Parse(Request.QueryString["id"]);
            // TODO: CategoriaService.Actualizar(id, nombre, descripcion, activa, colorIdx, icono);
            Response.Redirect("Categorias.aspx?editada=1");
            
        }
    }
}