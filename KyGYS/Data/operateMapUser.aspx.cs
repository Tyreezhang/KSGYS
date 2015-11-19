using KyGYS.Controls.Caller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KyGYS.Data
{
    public partial class operateMapUser : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            string action = Request.QueryString["action"];
            string suppname = Request.QueryString["suppname"];
            string othername = Request.QueryString["othername"];
            string guid = Request.QueryString["guid"];
            OperateMapUser(action, suppname, othername, guid);
        }

        private void OperateMapUser(string action, string suppname, string othername, string guid)
        {
            string msg = string.Empty;
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "Add":
                        {
                            Ultra.Logic.ResultData rd = SerNoCaller.Calr_MapUser.ExecSql("exec P_ERP_NewMapUser @0,@1,@2", UserName, suppname,othername);
                            if (rd.QueryCount < 1)
                            {
                                msg = "可能别名已存在或供应商名称不存在,请重新输入";
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
                            Ultra.Logic.ResultData rd = SerNoCaller.Calr_User.ExecSql("Update T_ERP_MapUser Set UserName=@0 Where not exists(select 1 from T_ERP_MapUser where  guid <> @2 and UserName=@0 and SuppName=@1)  and  Guid=@2 ", othername, suppname, guid);
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