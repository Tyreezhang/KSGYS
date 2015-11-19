using KyGYS.Controls.Caller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KyGYS.Data
{
    public partial class editPwd : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            string pwd = Request.QueryString["newpass"];
            string userid = Session["UserId"].ToString();
            EditPwd(pwd, userid);
        }

        private void EditPwd(string pwd, string userid)
        {
            string msg = string.Empty;
            if (string.IsNullOrEmpty(pwd))
            {
                Response.Write("输入密码");
                Response.End();
            }
            pwd = Common.Security.GetMd5(pwd);
            Ultra.Logic.ResultData rd = SerNoCaller.Calr_User.ExecSql("Update T_ERP_USER SET LOGINPASSWORD=@0 WHERE GUID=@1", pwd, userid);
            if (rd.QueryCount > 0)
            {
                msg = "修改成功";
            }
            else
            {
                msg = "修改失败";
            }
            Response.Write(msg);
            Response.End();
        }
    }
}