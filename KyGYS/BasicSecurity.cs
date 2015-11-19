using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KyGYS
{
    public class BasicSecurity : System.Web.UI.Page
    {

        public  string UserName
        {
            get
            {
                if (Session["UserName"] != null)
                {
                    return Session["UserName"].ToString();
                }
                else
                {
                    return string.Empty;
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Write("<script>alert('登录超时,请重新登录！'); if (window == top){window.location.href='../Login.aspx';} else{top.location.href='../Login.aspx';}</script>");
                    Response.End();
                    return;
                }
                Session.Timeout = 1200;
            }
        }
    }
}