using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace proyecto_frontend
{
    public partial class productos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarCategoriasFiltro();
            CargarProductos();
        }

        // ── Carga las opciones del filtro de categorías ──
        private void CargarCategoriasFiltro()
        {
            // TODO: reemplazar con consulta real a BD
            var categorias = new[]
            {
                new { Id = "1", Nombre = "Electrónica" },
                new { Id = "2", Nombre = "Papelería" },
                new { Id = "3", Nombre = "Lubricantes" },
                new { Id = "4", Nombre = "Repuestos" },
                new { Id = "5", Nombre = "Consumibles" },
            };

            var sb = new System.Text.StringBuilder();
            foreach (var c in categorias)
                sb.Append($"<option value=\"{c.Id}\">{c.Nombre}</option>");

            litCatOptions.Text = sb.ToString();
        }

        // ── Carga y vincula la lista de productos ──
        private void CargarProductos()
        {
            DataTable dt = ObtenerProductos();

            litTotalCount.Text = dt.Rows.Count.ToString();

            bool hayProductos = dt.Rows.Count > 0;
            pnlEmpty.Visible = !hayProductos;

            rptProductos.DataSource = dt;
            rptProductos.DataBind();

            rptProductosCard.DataSource = dt;
            rptProductosCard.DataBind();
        }

        // ── Mock de datos — reemplazar con consulta a BD ──
        private DataTable ObtenerProductos()
        {
            var dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Codigo");
            dt.Columns.Add("Descripcion");
            dt.Columns.Add("PrecioCompra", typeof(decimal));
            dt.Columns.Add("PrecioVenta", typeof(decimal));
            dt.Columns.Add("Impuesto", typeof(int));
            dt.Columns.Add("Existencia", typeof(int));
            dt.Columns.Add("CategoriaId");
            dt.Columns.Add("CategoriaNombre");
            dt.Columns.Add("Foto");
            dt.Columns.Add("StockEstado");    // "ok" | "low" | "critical"

            // Datos de ejemplo:
            dt.Rows.Add(1, "ELEC-001", "Cable USB-C 2m trenzado nylon", 45.00m, 95.00m, 0, 20, "1", "Electrónica", "", "ok");
            dt.Rows.Add(2, "PAP-002", "Papel bond A4 resma 500 hojas", 85.00m, 120.00m, 0, 7, "2", "Papelería", "", "low");
            dt.Rows.Add(3, "LUB-001", "Aceite de motor sintético 5W-30 1L", 180.00m, 250.00m, 15, 2, "3", "Lubricantes", "", "critical");
            dt.Rows.Add(4, "REP-003", "Filtro de aire tipo A referencia FA-450", 90.00m, 145.00m, 15, 5, "4", "Repuestos", "", "low");
            dt.Rows.Add(5, "CON-004", "Tóner HP 85A original negro", 350.00m, 480.00m, 15, 1, "5", "Consumibles", "", "critical");
            dt.Rows.Add(6, "ELEC-002", "Mouse inalámbrico ergonómico 2.4GHz", 220.00m, 340.00m, 0, 15, "1", "Electrónica", "", "ok");

            return dt;
        }

        private int ContarBajaExistencia(DataTable dt)
        {
            int count = 0;
            foreach (DataRow row in dt.Rows)
                if (row["StockEstado"].ToString() == "low" || row["StockEstado"].ToString() == "critical")
                    count++;
            return count;
        }

        // ── Eliminar producto ──
        protected void btnDeleteConfirm_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(hfDeleteId.Value, out int id)) return;

            // TODO: eliminar de BD, eliminar foto del servidor
            // Ejemplo:
            // string fotoPath = ProductoService.ObtenerFoto(id);
            // ProductoService.Eliminar(id);
            // if (!string.IsNullOrEmpty(fotoPath))
            // {
            //     string fullPath = Server.MapPath(fotoPath);
            //     if (File.Exists(fullPath)) File.Delete(fullPath);
            // }

            Response.Redirect("Productos.aspx?eliminado=1");
        }

        // ── ItemCommand del Repeater (no usado aquí, pero disponible) ──
        protected void rptProductos_ItemCommand(object source, RepeaterCommandEventArgs e) { }
    }
}