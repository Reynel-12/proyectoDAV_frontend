using System;
using System.Web.UI;

namespace proyecto_frontend.Pages
{
    public partial class restablecerContrasena : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlForm.Visible = true;
                pnlSuccess.Visible = false;
                pnlError.Visible = false;
            }
        }

        protected void btnGuardarContrasena_Click(object sender, EventArgs e)
        {
        }

        protected void btnIrAlLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/login.aspx");
        }
    }
}