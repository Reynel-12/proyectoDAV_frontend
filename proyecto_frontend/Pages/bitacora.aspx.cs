using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace proyecto_frontend.Pages
{
    public partial class bitacora : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarBitacora();
        }

        private void CargarBitacora()
        {
            DataTable dt = ObtenerMovimientos();

            // ── KPIs ──
            int total = dt.Rows.Count, creaciones = 0, ediciones = 0,
                eliminaciones = 0, entradas = 0, salidas = 0, ajustes = 0;
            var usuarios = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

            foreach (DataRow r in dt.Rows)
            {
                usuarios.Add(r["Usuario"].ToString());
                switch (r["OperacionCss"].ToString())
                {
                    case "creacion": creaciones++; break;
                    case "edicion": ediciones++; break;
                    case "eliminacion": eliminaciones++; break;
                    case "entrada": entradas++; break;
                    case "salida": salidas++; break;
                    case "ajuste": ajustes++; break;
                }
            }

            litTotalMovs.Text = total.ToString();
            litCreaciones.Text = creaciones.ToString();
            litEdiciones.Text = ediciones.ToString();
            litEliminaciones.Text = eliminaciones.ToString();
            litEntradas.Text = entradas.ToString();
            litSalidas.Text = salidas.ToString();
            litAjustes.Text = ajustes.ToString();
            litUsuariosActivos.Text = usuarios.Count.ToString();

            // ── Opciones de usuario en filtro ──
            var sbOpts = new StringBuilder();
            foreach (var u in usuarios)
                sbOpts.Append($"<option value=\"{u.ToLower()}\">{u}</option>");
            litUsuariosOpts.Text = sbOpts.ToString();

            // ── Repeaters ──
            bool hayDatos = total > 0;
            pnlEmpty.Visible = !hayDatos;

            rptBitacora.DataSource = dt;
            rptBitacora.DataBind();
            rptBitacoraCard.DataSource = dt;
            rptBitacoraCard.DataBind();

            // ── JSON para el modal JS ──
            var list = new List<Dictionary<string, object>>();
            foreach (DataRow r in dt.Rows)
            {
                list.Add(new Dictionary<string, object>
                {
                    ["Id"] = r["Id"],
                    ["Usuario"] = r["Usuario"],
                    ["FechaFormateada"] = r["FechaFormateada"],
                    ["FechaISO"] = r["FechaISO"],
                    ["OperacionCss"] = r["OperacionCss"],
                    ["OperacionLabel"] = r["OperacionLabel"],
                    ["EntidadTipo"] = r["EntidadTipo"],
                    ["EntidadNombre"] = r["EntidadNombre"],
                    ["Descripcion"] = r["Descripcion"],
                    ["IpAddress"] = r["IpAddress"],
                    ["ValoresAnterioresJson"] = r["ValoresAnterioresJson"],
                    ["ValoresNuevosJson"] = r["ValoresNuevosJson"],
                    ["ValorAnteriorResumen"] = r["ValorAnteriorResumen"],
                    ["ValorNuevoResumen"] = r["ValorNuevoResumen"],
                    ["Iniciales"] = r["Iniciales"],
                    ["AvatarColor"] = r["AvatarColor"]
                });
            }
            hfMovimientosJson.Value = new JavaScriptSerializer().Serialize(list);
        }

        // ── Métodos de ayuda para el Repeater ──────────────────────────

        /// <summary>Renderiza el panel de valores anteriores en el inline detail.</summary>
        protected string RenderDiffPanelAnterior(string json)
            => RenderDiffPanel(json, "prev");

        /// <summary>Renderiza el panel de valores nuevos en el inline detail.</summary>
        protected string RenderDiffPanelNuevo(string json)
            => RenderDiffPanel(json, "next");

        private string RenderDiffPanel(string json, string tipo)
        {
            if (string.IsNullOrWhiteSpace(json) || json == "{}" || json == "null")
                return "<div class=\"detail-no-data\">Sin datos registrados</div>";

            try
            {
                var js = new JavaScriptSerializer();
                var obj = js.Deserialize<Dictionary<string, object>>(json);
                var sb = new StringBuilder();
                foreach (var kv in obj)
                {
                    sb.Append($"<div class=\"diff-row\">"
                        + $"<span class=\"diff-key\">{kv.Key}</span>"
                        + $"<span class=\"diff-val changed-{tipo}\">{kv.Value}</span>"
                        + "</div>");
                }
                return sb.ToString();
            }
            catch { return "<div class=\"detail-no-data\">Error al leer datos</div>"; }
        }

        protected string GetOpIcon(string css)
        {
            switch (css)
            {
                case "creacion":
                    // Plus circle
                    return "<svg width=\"18\" height=\"18\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" aria-hidden=\"true\" focusable=\"false\"><circle cx=\"12\" cy=\"12\" r=\"10\"/><line x1=\"12\" y1=\"8\" x2=\"12\" y2=\"16\"/><line x1=\"8\" y1=\"12\" x2=\"16\" y2=\"12\"/></svg>";

                case "edicion":
                    // Pencil
                    return "<svg width=\"18\" height=\"18\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" aria-hidden=\"true\" focusable=\"false\"><path d=\"M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7\"/><path d=\"M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z\"/></svg>";

                case "eliminacion":
                    // Trash
                    return "<svg width=\"18\" height=\"18\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" aria-hidden=\"true\" focusable=\"false\"><polyline points=\"3 6 5 6 21 6\"/><path d=\"M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6\"/><path d=\"M10 11v6\"/><path d=\"M14 11v6\"/><path d=\"M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2\"/></svg>";

                case "entrada":
                    // Arrow down
                    return "<svg width=\"18\" height=\"18\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" aria-hidden=\"true\" focusable=\"false\"><line x1=\"12\" y1=\"5\" x2=\"12\" y2=\"19\"/><polyline points=\"19 12 12 19 5 12\"/></svg>";

                case "salida":
                    // Arrow up
                    return "<svg width=\"18\" height=\"18\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" aria-hidden=\"true\" focusable=\"false\"><line x1=\"12\" y1=\"19\" x2=\"12\" y2=\"5\"/><polyline points=\"5 12 12 5 19 12\"/></svg>";

                case "ajuste":
                    // Settings
                    return "<svg width=\"18\" height=\"18\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" aria-hidden=\"true\" focusable=\"false\"><circle cx=\"12\" cy=\"12\" r=\"3\"/><path d=\"M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z\"/></svg>";

                default:
                    // Clipboard
                    return "<svg width=\"18\" height=\"18\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" aria-hidden=\"true\" focusable=\"false\"><path d=\"M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2\"/><rect x=\"8\" y=\"2\" width=\"8\" height=\"4\" rx=\"1\" ry=\"1\"/></svg>";
            }
        }

        // ── Mock de datos ─────────────────────────────────────────────

        private void AddMovimiento(
        DataTable dt, int id, string user, string ini, string ava,
        DateTime fecha, string opCss, string opLabel,
        string eTipo, string eNombre, string desc, string ip,
        string jsPrev, string jsNext, string prevRes, string nextRes)
        {
            dt.Rows.Add(id, user, ini, ava,
                fecha.ToString("dd/MM/yyyy HH:mm"),
                fecha.ToString("o"),
                opCss, opLabel, eTipo, eNombre, desc, ip,
                jsPrev, jsNext, prevRes, nextRes);
        }

        private DataTable ObtenerMovimientos()
        {
            // TODO: reemplazar con consulta real a BD
            var dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("Usuario");
            dt.Columns.Add("Iniciales");
            dt.Columns.Add("AvatarColor");
            dt.Columns.Add("FechaFormateada");
            dt.Columns.Add("FechaISO");
            dt.Columns.Add("OperacionCss");
            dt.Columns.Add("OperacionLabel");
            dt.Columns.Add("EntidadTipo");
            dt.Columns.Add("EntidadNombre");
            dt.Columns.Add("Descripcion");
            dt.Columns.Add("IpAddress");
            dt.Columns.Add("ValoresAnterioresJson");
            dt.Columns.Add("ValoresNuevosJson");
            dt.Columns.Add("ValorAnteriorResumen");
            dt.Columns.Add("ValorNuevoResumen");

            // Registro helper
            //void Add(int id, string user, string ini, string ava,
            //         DateTime fecha, string opCss, string opLabel,
            //         string eTipo, string eNombre, string desc, string ip,
            //         string jsPrev, string jsNext, string prevRes, string nextRes)
            //{
            //    dt.Rows.Add(id, user, ini, ava,
            //        fecha.ToString("dd/MM/yyyy HH:mm"),
            //        fecha.ToString("o"),
            //        opCss, opLabel, eTipo, eNombre, desc, ip,
            //        jsPrev, jsNext, prevRes, nextRes);
            //}

            var now = DateTime.Now;

            AddMovimiento(dt, 1, "Carlos Alvarado", "CA", "ua-blue",
                now.AddMinutes(-15), "creacion", "Creación",
                "Producto", "Cable USB-C 2m",
                "Nuevo producto registrado en el sistema.",
                "192.168.1.10",
                "{}",
                "{\"Codigo\":\"ELEC-001\",\"Precio Venta\":\"L 95.00\",\"Existencia\":\"20\"}",
                "", "ELEC-001 / L 95.00 / 20 uds");

            AddMovimiento(dt, 2, "María Rodríguez", "MR", "ua-green",
                now.AddMinutes(-90), "edicion", "Edición",
                "Producto", "Papel bond A4 resma",
                "Actualización de precio de venta y existencia.",
                "192.168.1.22",
                "{\"Precio Venta\":\"L 110.00\",\"Existencia\":\"15\"}",
                "{\"Precio Venta\":\"L 120.00\",\"Existencia\":\"7\"}",
                "L 110.00 / 15 uds", "L 120.00 / 7 uds");

            AddMovimiento(dt, 3, "Juan Meza", "JM", "ua-purple",
                now.AddHours(-3), "eliminacion", "Eliminación",
                "Categoría", "Temporales",
                "Categoría eliminada por no contener productos activos.",
                "192.168.1.5",
                "{\"Nombre\":\"Temporales\",\"Productos\":\"0\",\"Estado\":\"Inactiva\"}",
                "{}",
                "Temporales / 0 productos", "");

            AddMovimiento(dt, 4, "Carlos Alvarado", "CA", "ua-blue",
                now.AddHours(-5), "entrada", "Entrada de stock",
                "Producto", "Cable USB-C 2m",
                "Reposición de inventario por compra a proveedor.",
                "192.168.1.10",
                "{\"Existencia\":\"5\"}",
                "{\"Existencia\":\"20\",\"Cant. ingresada\":\"15\"}",
                "5 uds", "+15 → 20 uds");

            AddMovimiento(dt, 5, "María Rodríguez", "MR", "ua-green",
                now.AddHours(-7), "salida", "Salida de stock",
                "Producto", "Tóner HP 85A",
                "Salida por uso interno en departamento de administración.",
                "192.168.1.22",
                "{\"Existencia\":\"3\"}",
                "{\"Existencia\":\"1\",\"Cant. salida\":\"2\"}",
                "3 uds", "-2 → 1 ud");

            AddMovimiento(dt, 6, "Carlos Alvarado", "CA", "ua-blue",
                now.AddDays(-1), "ajuste", "Ajuste de stock",
                "Producto", "Aceite motor 5W-30",
                "Ajuste por conteo físico de inventario.",
                "192.168.1.10",
                "{\"Existencia\":\"8\",\"Motivo\":\"—\"}",
                "{\"Existencia\":\"5\",\"Motivo\":\"Conteo físico\"}",
                "8 uds", "5 uds (conteo)");

            AddMovimiento(dt, 7, "Juan Meza", "JM", "ua-purple",
                now.AddDays(-1).AddHours(-2), "creacion", "Creación",
                "Categoría", "Lubricantes",
                "Nueva categoría registrada para aceites y grasas.",
                "192.168.1.5",
                "{}",
                "{\"Nombre\":\"Lubricantes\",\"Estado\":\"Activa\",\"Color\":\"Ámbar\"}",
                "", "Lubricantes / Activa");

            AddMovimiento(dt, 8, "María Rodríguez", "MR", "ua-green",
                now.AddDays(-2), "edicion", "Edición",
                "Producto", "Filtro de aire tipo A",
                "Corrección de precio de compra.",
                "192.168.1.22",
                "{\"Precio Compra\":\"L 70.00\",\"Precio Venta\":\"L 130.00\"}",
                "{\"Precio Compra\":\"L 90.00\",\"Precio Venta\":\"L 145.00\"}",
                "C:L70/V:L130", "C:L90/V:L145");

            AddMovimiento(dt, 9, "Carlos Alvarado", "CA", "ua-blue",
                now.AddDays(-3), "entrada", "Entrada de stock",
                "Producto", "Filtro de aire tipo A",
                "Compra a proveedor FA Solutions S.A.",
                "192.168.1.10",
                "{\"Existencia\":\"0\"}",
                "{\"Existencia\":\"10\",\"Cant. ingresada\":\"10\"}",
                "0 uds", "+10 → 10 uds");

            AddMovimiento(dt, 10, "Juan Meza", "JM", "ua-purple",
                now.AddDays(-5), "creacion", "Creación",
                "Producto", "Mouse inalámbrico 2.4GHz",
                "Nuevo producto electrónico agregado al catálogo.",
                "192.168.1.5",
                "{}",
                "{\"Codigo\":\"ELEC-002\",\"Precio Venta\":\"L 340.00\",\"Existencia\":\"15\"}",
                "", "ELEC-002 / L 340.00");

            return dt;
        }
    }
}