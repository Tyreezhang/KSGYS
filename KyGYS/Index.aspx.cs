using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KyGYS
{
    public partial class Index : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            if (Session["UserName"] != null)
            {
                string username = Session["UserName"].ToString();
                this.lblusername.Text = username;
                this.ismanager.Value = Session["IsManager"].ToString();
            }

        }
    }
}