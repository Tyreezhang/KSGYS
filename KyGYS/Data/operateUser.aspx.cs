using KyGYS.Common;
using KyGYS.Controls.Caller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KyGYS.Data
{
    public partial class operateUser : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            string action = Request.QueryString["action"];
            string username = Request.QueryString["username"];
            string pwd = Request.QueryString["pwd"];
            string tel = Request.QueryString["tel"];
            string guid = Request.QueryString["guid"];
            OperateUser(action, username, pwd, tel,guid);
        }


        private void OperateUser(string action, string username, string pwd, string tel,string guid)
        {
            string msg = string.Empty;
            pwd = Security.GetMd5(pwd);
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "Add":
                        {
                            Ultra.Logic.ResultData rd = SerNoCaller.Calr_User.ExecSql("exec P_ERP_NewUser @0,@1,@2,@3", UserName, username, pwd, tel);
                            if (rd.QueryCount < 1)
                            {
                                msg = "帐号已存在,请重新输入";
                            }
                            else
                            {
                                msg = "操作成功";
                            }
                            Response.Write(msg);
                            Response.End();
                        }
                        break;
                    case "Edit":
                        {
                            Ultra.Logic.ResultData rd = SerNoCaller.Calr_User.ExecSql("Update T_ERP_User Set LoginPassword=@0,Tel=@1 Where Guid=@2", pwd, tel,guid);
                            if (rd.QueryCount < 1)
                            {
                                msg = "操作失败";
                            }
                            else
                            {
                                msg = "操作成功";
                            }
                            Response.Write(msg);
                            Response.End();
                        }
                        break;
                }
            }
        }
    }
}