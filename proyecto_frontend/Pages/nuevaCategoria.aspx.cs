using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace proyecto_frontend.Pages
{
    public partial class nuevaCategoria : System.Web.UI.Page
    {

        private bool EsModoEdicion => Request.QueryString["id"] != null;

        protected void Page_Load(object sender, EventArgs e)
        {
            // if (Session["UserEmail"] == null) { Response.Redirect("~/Login.aspx"); return; }

            // if (!IsPostBack)
            // {
                if (EsModoEdicion)
                {
                    litPageTitle.Text = "Editar categoría";
                    CargarCategoria(int.Parse(Request.QueryString["id"]));
                }
            // }
        }

        private void CargarCategoria(int id)
        {
            // TODO: traer datos de BD por id
            // Ejemplo:
            // var cat = CategoriaService.ObtenerPorId(id);
            // txtNombre.Text      = cat.Nombre;
            // txtDescripcion.Text = cat.Descripcion;
            // chkActiva.Checked   = cat.Activa;
            // hfColorIdx.Value    = cat.ColorIdx.ToString();
            // hfIcono.Value       = cat.Icono;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string nombre = txtNombre.Text.Trim();
            string descripcion = txtDescripcion.Text.Trim();

            if (EsModoEdicion)
            {
                int id = int.Parse(Request.QueryString["id"]);
                // TODO: CategoriaService.Actualizar(id, nombre, descripcion, activa, colorIdx, icono);
                Response.Redirect("Categorias.aspx?editada=1");
            }
            else
            {
                // TODO: CategoriaService.Crear(nombre, descripcion, activa, colorIdx, icono);
                Response.Redirect("Categorias.aspx?nueva=1");
            }
        }
    }
}