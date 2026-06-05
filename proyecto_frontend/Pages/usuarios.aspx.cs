using System;
using System.Data;
using System.Linq;
using System.Text;
using System.Web.UI;

namespace proyecto_frontend.Pages
{
    public partial class usuarios : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarUsuarios();
        }

        private void CargarUsuarios()
        {
            DataTable dt = ObtenerUsuarios();
            int total = dt.Rows.Count;
            int activos = dt.AsEnumerable().Count(row => row.Field<string>("EstadoKey") == "activo");
            int administradores = dt.AsEnumerable().Count(row => row.Field<string>("RolKey") == "admin");
            int nuevosMes = dt.AsEnumerable().Count(row =>
            {
                DateTime fecha = row.Field<DateTime>("FechaRegistroValue");
                return fecha.Year == DateTime.Today.Year && fecha.Month == DateTime.Today.Month;
            });

            litTotalUsuarios.Text = total.ToString();
            litKpiTotal.Text = total.ToString();
            litKpiActivos.Text = activos.ToString();
            litKpiAdministradores.Text = administradores.ToString();
            litKpiNuevosMes.Text = nuevosMes.ToString();

            litRolOptions.Text = ConstruirOpciones(dt, "RolKey", "Rol");
            litEstadoOptions.Text = ConstruirOpciones(dt, "EstadoKey", "Estado");

            pnlEmpty.Visible = total == 0;

            rptUsuarios.DataSource = dt;
            rptUsuarios.DataBind();

            rptUsuariosCard.DataSource = dt;
            rptUsuariosCard.DataBind();
        }

        private string ConstruirOpciones(DataTable dt, string valueField, string textField)
        {
            var sb = new StringBuilder();
            var opciones = dt.AsEnumerable()
                .Select(row => new
                {
                    Value = row.Field<string>(valueField),
                    Text = row.Field<string>(textField)
                })
                .GroupBy(item => item.Value)
                .Select(group => group.First())
                .OrderBy(item => item.Text);

            foreach (var opcion in opciones)
            {
                sb.AppendFormat("<option value=\"{0}\">{1}</option>", opcion.Value, opcion.Text);
            }

            return sb.ToString();
        }

        private DataTable ObtenerUsuarios()
        {
            var dt = new DataTable();
            dt.Columns.Add("Id", typeof(int));
            dt.Columns.Add("NombreCompleto");
            dt.Columns.Add("Iniciales");
            dt.Columns.Add("Correo");
            dt.Columns.Add("Telefono");
            dt.Columns.Add("Ciudad");
            dt.Columns.Add("Rol");
            dt.Columns.Add("RolKey");
            dt.Columns.Add("Estado");
            dt.Columns.Add("EstadoKey");
            dt.Columns.Add("FechaRegistro");
            dt.Columns.Add("FechaRegistroOrden");
            dt.Columns.Add("FechaRegistroValue", typeof(DateTime));
            dt.Columns.Add("UltimoAcceso");
            dt.Columns.Add("UltimoAccesoOrden");
            dt.Columns.Add("Origen");
            dt.Columns.Add("Actividad");
            dt.Columns.Add("AvatarClase");

            AgregarUsuario(dt, 1, "Carlos Alvarado", "CA", "carlos.alvarado@invcontrol.com", "+504 9954-1021", "Tegucigalpa", "Administrador", "admin", "Activo", "activo", DateTime.Today.AddDays(-42), DateTime.Now.AddMinutes(-18), "Registro interno", "Sesión reciente", "ua-blue");
            AgregarUsuario(dt, 2, "María Rodríguez", "MR", "maria.rodriguez@invcontrol.com", "+504 9876-1142", "San Pedro Sula", "Operador", "operador", "Activo", "activo", DateTime.Today.AddDays(-30), DateTime.Now.AddHours(-2), "Formulario web", "Gestionando inventario", "ua-green");
            AgregarUsuario(dt, 3, "Juan Meza", "JM", "juan.meza@invcontrol.com", "+504 9733-2004", "La Ceiba", "Supervisor", "supervisor", "Activo", "activo", DateTime.Today.AddDays(-12), DateTime.Now.AddDays(-1), "Formulario web", "Actividad hace 1 día", "ua-purple");
            AgregarUsuario(dt, 4, "Ana Flores", "AF", "ana.flores@gmail.com", "+504 9721-4490", "Comayagua", "Cliente", "cliente", "Pendiente", "pendiente", DateTime.Today.AddDays(-5), DateTime.Today.AddDays(-2), "Google Login", "Pendiente de confirmación", "ua-amber");
            AgregarUsuario(dt, 5, "Pedro Castillo", "PC", "pedro.castillo@empresa.hn", "+504 9988-6781", "Choluteca", "Cliente", "cliente", "Bloqueado", "bloqueado", DateTime.Today.AddDays(-60), DateTime.Today.AddDays(-8), "Formulario web", "Bloqueo por intentos fallidos", "ua-red");
            AgregarUsuario(dt, 6, "Lucía Hernández", "LH", "lucia.hernandez@correo.com", "+504 9460-7775", "Tegucigalpa", "Cliente", "cliente", "Activo", "activo", DateTime.Today.AddDays(-3), DateTime.Now.AddMinutes(-55), "Facebook Login", "Compra reciente", "ua-cyan");
            AgregarUsuario(dt, 7, "José Martínez", "JM", "jose.martinez@correo.com", "+504 8872-3301", "El Progreso", "Operador", "operador", "Inactivo", "inactivo", DateTime.Today.AddDays(-95), DateTime.Today.AddDays(-18), "Registro interno", "Sin actividad reciente", "ua-slate");
            AgregarUsuario(dt, 8, "Sofía Pineda", "SP", "sofia.pineda@correo.com", "+504 9810-1550", "Danlí", "Cliente", "cliente", "Activo", "activo", DateTime.Today.AddDays(-1), DateTime.Now.AddHours(-4), "Formulario web", "Cuenta nueva", "ua-pink");

            return dt;
        }

        private void AgregarUsuario(
            DataTable dt,
            int id,
            string nombreCompleto,
            string iniciales,
            string correo,
            string telefono,
            string ciudad,
            string rol,
            string rolKey,
            string estado,
            string estadoKey,
            DateTime fechaRegistro,
            DateTime ultimoAcceso,
            string origen,
            string actividad,
            string avatarClase)
        {
            dt.Rows.Add(
                id,
                nombreCompleto,
                iniciales,
                correo,
                telefono,
                ciudad,
                rol,
                rolKey,
                estado,
                estadoKey,
                fechaRegistro.ToString("dd/MM/yyyy"),
                fechaRegistro.ToString("yyyyMMdd"),
                fechaRegistro,
                ultimoAcceso.ToString("dd/MM/yyyy HH:mm"),
                ultimoAcceso.ToString("yyyyMMddHHmm"),
                origen,
                actividad,
                avatarClase);
        }
    }
}
