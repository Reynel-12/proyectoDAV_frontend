using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace proyecto_frontend.Pages
{
    public partial class editarProducto : System.Web.UI.Page
    {

        // Extensiones permitidas
        private static readonly string[] ExtPermitidas =
            { ".jpg", ".jpeg", ".png" };

        protected void Page_Load(object sender, EventArgs e)
        {
            CargarCategorias();
        }

        private void CargarCategorias()
        {
            // TODO: reemplazar con consulta a BD
            ddlCategoria.Items.Clear();
            ddlCategoria.Items.Add(new ListItem("— Selecciona una categoría —", ""));
            ddlCategoria.Items.Add(new ListItem("Electrónica", "1"));
            ddlCategoria.Items.Add(new ListItem("Papelería", "2"));
            ddlCategoria.Items.Add(new ListItem("Lubricantes", "3"));
            ddlCategoria.Items.Add(new ListItem("Repuestos", "4"));
            ddlCategoria.Items.Add(new ListItem("Consumibles", "5"));
        }

        // ── Validación server-side de la fotografía ──
        protected void cvFoto_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // La foto es opcional: si no se cargó nada, pasa OK
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
            if (!Page.IsValid) return;

            // ── Recolectar valores ──
            string codigo = txtCodigo.Text.Trim().ToUpper();
            string descripcion = txtDescripcion.Text.Trim();
            decimal precioCompra = decimal.Parse(txtPrecioCompra.Text.Trim());
            decimal precioVenta = decimal.Parse(txtPrecioVenta.Text.Trim());
            int impuesto = int.Parse(ddlImpuesto.SelectedValue);
            int existencia = int.Parse(txtExistencia.Text.Trim());
            int categoriaId = int.Parse(ddlCategoria.SelectedValue);

            // ── Guardar fotografía (si se subió) ──
            string rutaFoto = null;
            if (fuFoto.HasFile)
            {
                string ext = Path.GetExtension(fuFoto.FileName).ToLowerInvariant();
                string nombreFoto = $"{codigo}_{DateTime.Now:yyyyMMddHHmmss}{ext}";
                string carpeta = Server.MapPath("~/Uploads/Productos/");

                if (!Directory.Exists(carpeta))
                    Directory.CreateDirectory(carpeta);

                fuFoto.SaveAs(Path.Combine(carpeta, nombreFoto));
                rutaFoto = $"~/Uploads/Productos/{nombreFoto}";
            }

            // TODO: insertar en BD los valores:
            // codigo, descripcion, precioCompra, precioVenta,
            // impuesto, existencia, categoriaId, rutaFoto

            // Redirigir con mensaje de éxito
            Response.Redirect("Productos.aspx?nuevo=1");
        }
    }
}