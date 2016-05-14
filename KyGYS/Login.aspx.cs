using KyGYS.Controls.Caller;
using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UltraDbEntity;


namespace KyGYS
{
    public partial class Login : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                HttpCookie user = Request.Cookies["Login"];
                if (user != null)
                {
                    Response.Redirect("~/Index.aspx");
                }
                else
                {
                    this.txtusername.Text = string.Empty;
                    this.txtpwd.Text = string.Empty;
                }
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            string userName = this.txtusername.Text.Trim();
            string passWord = txtpwd.Text.Trim();
            if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(passWord))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "message", "alert('用户名或密码为空，请输入内容');", true);
                return;
            }
            List<T_ERP_SuppBatch> list = SerNoCaller.Calr_SuppBatch.Get(@" select SuppName from T_ERP_SuppBatch  where SuppName=@0
                    and not EXISTS(select 1 from T_ERP_User where UserName=@0 and IsDel = 0 )", userName);
            if (list.Count > 0 && list != null)
            {
                Session["SuppName"] = userName;
                Response.Redirect("~/Register.aspx");
            }
            List<T_ERP_SuppPurch> purchlist = SerNoCaller.Calr_SuppPurch.Get(@" select SuppName from T_ERP_SuppPurch  where SuppName=@0
                    and not EXISTS(select 1 from T_ERP_User where UserName=@0 and IsDel = 0 )", userName);
            if (purchlist.Count > 0 && purchlist != null)
            {
                Session["SuppName"] = userName;
                Response.Redirect("~/Register.aspx");
            }
            string pwdCode = KyGYS.Common.Security.GetMd5(passWord);
            var users = SerNoCaller.Calr_User.Get("where UserName=@0 and LoginPassword=@1 and IsDel = 0"
                , userName, pwdCode);
            if (users == null || users.Count < 1)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "message", "alert('用户帐号密码无效');", true);
                txtpwd.Text = string.Empty;
                return;
            }
            else
            {
                T_ERP_User user = users.FirstOrDefault();
                HttpCookie keepCookie = new HttpCookie("Login");
                keepCookie.Values.Add("UserName", HttpUtility.UrlEncode(user.UserName));
                keepCookie.Values.Add("isManager", user.IsManager.ToString());
                keepCookie.Values.Add("UserId", user.Guid.ToString());
                keepCookie.Expires = DateTime.Now.AddDays(1);
                Response.Cookies.Add(keepCookie);
                Response.Redirect("~/Index.aspx");
            }
        }
    }
}