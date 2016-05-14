using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KyGYS
{
    public partial class LoginOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie login = new HttpCookie("Login");
            login.Expires = DateTime.Now.AddHours(-24);
            Response.Cookies.Add(login);
            Response.Write("<script>window.location.href='../Login.aspx'</script>"); 
        }
    }
}