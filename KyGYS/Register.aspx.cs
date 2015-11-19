using KyGYS.Common;
using KyGYS.Controls.Caller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UltraDbEntity;

namespace KyGYS
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["SuppName"] != null)
                {
                    string suppName = Session["SuppName"].ToString();
                    this.txtUserName.Text = suppName;
                    this.txtUserName.ReadOnly = true;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string msg = string.Empty;
            string pwd = Security.GetMd5(txtPwd.Text.Trim());
            Ultra.Logic.ResultData rd = SerNoCaller.Calr_User.ExecSql("exec P_ERP_NewUser @0,@1,@2,@3", this.txtUserName.Text.Trim(), this.txtUserName.Text.Trim(), pwd, txtTel.Text.Trim());
            if (rd.QueryCount < 1)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "message", " msgShow('系统提示', '注册失败', 'info');", true);
            }
            else
            {
                var users = SerNoCaller.Calr_User.Get("where UserName=@0 and LoginPassword=@1", this.txtUserName.Text.Trim(), pwd);
                if (users == null || users.Count < 1)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "message", "alert('用户帐号密码无效');", true);
                    pwd = string.Empty;
                    return;
                }
                else
                {
                    T_ERP_User user = users.FirstOrDefault();
                    Session["IsManager"] = user.IsManager;
                    Session["UserId"] = user.Guid;
                    Session["UserName"] = user.UserName;
                    Response.Redirect("~/Index.aspx");
                }
            }
        }
    }
}