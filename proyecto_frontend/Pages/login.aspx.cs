using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace proyecto_frontend
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            //string email = txtEmail.Text.Trim();
            //string password = txtPassword.Text;

            //Response.Redirect("~/Pages/dashboard.aspx");

            // TODO: validar contra tu base de datos / servicio de auth
            // Ejemplo:
            // bool ok = AuthService.ValidateUser(email, password);
            // if (ok)
            // {
            //     if (chkRemember.Checked) { /* setear cookie persistente */ }
            //     Session["UserEmail"] = email;
            //     Response.Redirect("~/Dashboard.aspx");
            // }
            // else
            // {
            //     vsSummary.Visible = true;  // mostrar error genérico
            // }
        }
    }
}