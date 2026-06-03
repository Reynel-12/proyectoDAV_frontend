using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace proyecto_frontend.Pages
{
    public partial class categorias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarCategorias();
        }

        private void CargarCategorias()
        {
            DataTable dt = ObtenerCategorias();
            int total = dt.Rows.Count;
            int activas = 0, productos = 0;
            foreach (DataRow r in dt.Rows)
            {
                if ((bool)r["Activa"]) activas++;
                productos += (int)r["CantProductos"];
            }

            litTotal.Text = total.ToString();
            litTotalKpi.Text = total.ToString();
            litActivasKpi.Text = activas.ToString();
            litProductosKpi.Text = productos.ToString();

            bool hayDatos = total > 0;
            pnlEmpty.Visible = !hayDatos;

            rptCategorias.DataSource = dt;
            rptCategorias.DataBind();
            rptCategoriasTable.DataSource = dt;
            rptCategoriasTable.DataBind();
        }

        private DataTable ObtenerCategorias()
        {
            // TODO: reemplazar con consulta real a BD
            var dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Nombre");
            dt.Columns.Add("Descripcion");
            dt.Columns.Add("Activa", typeof(bool));
            dt.Columns.Add("CantProductos", typeof(int));
            dt.Columns.Add("FechaCreacion", typeof(DateTime));
            dt.Columns.Add("Icono");
            dt.Columns.Add("ColorIdx");

            dt.Rows.Add(1, "Electrónica", "Equipos, cables y accesorios electrónicos.", true, 35, DateTime.Today.AddMonths(-6), "&#128187;", "1");
            dt.Rows.Add(2, "Papelería", "Artículos de oficina y escritorio.", true, 18, DateTime.Today.AddMonths(-5), "&#128203;", "2");
            dt.Rows.Add(3, "Lubricantes", "Aceites, grasas y fluidos industriales.", true, 12, DateTime.Today.AddMonths(-4), "&#9881;", "4");
            dt.Rows.Add(4, "Repuestos", "Piezas y componentes para mantenimiento.", true, 27, DateTime.Today.AddMonths(-3), "&#9978;", "7");
            dt.Rows.Add(5, "Consumibles", "Tóneres, cintas y suministros de impresión.", false, 6, DateTime.Today.AddMonths(-2), "&#128218;", "5");

            return dt;
        }

        protected void btnDeleteConfirm_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(hfDeleteId.Value, out int id)) return;

            // TODO: verificar que no tenga productos asignados antes de eliminar
            // TODO: ProductoService.EliminarCategoria(id);

            Response.Redirect("Categorias.aspx?eliminada=1");
        }
    }
}