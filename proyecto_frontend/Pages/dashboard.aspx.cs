using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace proyecto_frontend
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarKPIs();
            CargarBajaExistencia();
            CargarBitacora();
        }


        private void CargarKPIs()
        {
            // TODO: reemplazar con consultas reales a tu BD
            litTotalProductos.Text = "1,248";
            litBajaExistenciaCount.Text = "5";
            litEnStock.Text = "1,190";
            litPorcentajeStock.Text = "95.3% del total";
            litSinStock.Text = "53";
        }

        private void CargarBajaExistencia()
        {
            // TODO: traer de BD los productos con stock <= umbral
            var dt = new DataTable();
            dt.Columns.Add("Nombre");
            dt.Columns.Add("Stock", typeof(int));

            dt.Rows.Add("Aceite de motor 5W-30", 2);
            dt.Rows.Add("Filtro de aire tipo A", 5);
            dt.Rows.Add("Cable USB-C 2m", 3);
            dt.Rows.Add("Papel bond A4 resma", 7);
            dt.Rows.Add("Tóner HP 85A", 1);

            rptBajaExistencia.DataSource = dt;
            rptBajaExistencia.DataBind();
        }

        private void CargarBitacora()
        {
            // TODO: traer de BD los últimos N movimientos
            var dt = new DataTable();
            dt.Columns.Add("Fecha", typeof(DateTime));
            dt.Columns.Add("Producto");
            dt.Columns.Add("TipoMovimiento");
            dt.Columns.Add("Cantidad");
            dt.Columns.Add("Usuario");

            dt.Rows.Add(DateTime.Now.AddMinutes(-28), "Cable USB-C 2m", "Entrada", "+20", "Carlos A.");
            dt.Rows.Add(DateTime.Now.AddMinutes(-105), "Tóner HP 85A", "Salida", "-1", "María R.");
            dt.Rows.Add(DateTime.Now.AddMinutes(-190), "Papel bond A4 resma", "Ajuste", "±5", "Carlos A.");
            dt.Rows.Add(DateTime.Now.AddDays(-1).AddHours(-7), "Aceite motor 5W-30", "Salida", "-3", "Juan M.");
            dt.Rows.Add(DateTime.Now.AddDays(-1).AddHours(-14), "Filtro de aire tipo A", "Entrada", "+10", "María R.");
        }
    }
}