using KyGYS.Controls;
using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UltraDbEntity;
using System.Web.Script.Services;
using KyGYS.Controls.Caller;

namespace KyGYS.Data
{
    public partial class getSendList : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            string page = Request.QueryString["page"];
            string rows = Request.QueryString["rows"];
            if (!string.IsNullOrEmpty(page) && !string.IsNullOrEmpty(rows))
            {
                try
                {
                    int rs = int.Parse(rows);
                }
                catch (Exception ex)
                {
                    rows = "10";
                }
                Refreash(int.Parse(page), int.Parse(rows));
                Response.End();
            }
        }

        private void Refreash(int page, int rows)
        {
            string[] list = null;
            var objs = new List<object>();
            string whr = " where  IsSendGoods=1 ";
            string prefixWhr = string.Empty;
            var idx = 0;
            if (Session["queryStr"] != null)
            {
                string queryStr = Session["queryStr"].ToString();
                list = queryStr.Split(',');
            }
            if (IsManager != null && UserName != "")
            {
                if (IsManager != "True" && UserName != "admin")
                {
                    whr += "  and SuppName in (select UserName from T_ERP_MapUser where SuppName = @" + (idx++).ToString() + ")";
                    objs.Add(UserName);
                    prefixWhr = "select * from V_ERP_SuppXBatch ";
                }
                else
                {
                    prefixWhr = "select * from V_ERP_SuppXBatch ";
                }

                if (list != null && list.Count() > 0)
                {
                    if (!string.IsNullOrEmpty(list[0]))
                    {
                        whr += " and BuyerNick=@" + (idx++).ToString();
                        objs.Add(list[0].ToString());
                    }
                    //if (!string.IsNullOrEmpty(list[1]))
                    //{
                    //    whr += " and OrderFrom=@" + (idx++).ToString();
                    //    objs.Add(list[1].ToString());
                    //}
                    if (!string.IsNullOrEmpty(list[1]))
                    {
                        whr += " and SellerNick=@" + (idx++).ToString();
                        objs.Add(list[1].ToString());
                    }
                    if (!string.IsNullOrEmpty(list[2]))
                    {
                        whr += " and ReceiverName=@" + (idx++).ToString();
                        objs.Add(list[2].ToString());
                    }
                    if (!string.IsNullOrEmpty(list[3]))
                    {
                        whr += " and ReceiverMobile=@" + (idx++).ToString();
                        objs.Add(list[3].ToString());
                    }
                    if (!string.IsNullOrEmpty(list[4]))
                    {
                        whr += " and ReceiverAddress like @" + (idx++).ToString();
                        objs.Add("%" + list[4].ToString() + "%");
                    }
                }
                using (var db = new Database(SQLCONN.Conn))
                {
                    whr += " order by OrderTime desc";
                    var pages = db.Page<V_ERP_SuppXBatch>(page, rows, prefixWhr + whr, objs.ToArray());
                    var grd = new EasyGridData<V_ERP_SuppXBatch>();
                    grd.Init(pages);
                    string data = Newtonsoft.Json.JsonConvert.SerializeObject(grd);
                    Response.Write(data);
                }
            }
            else
            {
                string data = "{\"IsError\":\"true\",\"ErrMsg\":\"登录超时,请刷新页面重新登录\"}";
                Response.Write(data);
            }
        }

        [System.Web.Services.WebMethod]
        public static string UpdateLogis(string guid, string logisNo, string logisName, string logisCost, string logisMobile)
        {
            //BasicSecurity basic = new BasicSecurity();
            string userName =  HttpUtility.UrlDecode(HttpContext.Current.Request.Cookies["Login"]["UserName"].ToString());
            string msg = string.Empty;
            if (string.IsNullOrEmpty(guid) || string.IsNullOrEmpty(logisNo) || string.IsNullOrEmpty(logisName) || string.IsNullOrEmpty(logisCost)) return "操作失败,请刷新页面重新操作!";
            if (HttpContext.Current.Request.Cookies["Login"]["UserName"] == "") return "登陆超时";
            Ultra.Logic.ResultData rd = SerNoCaller.Calr_SuppBatch.ExecSql("Update T_ERP_SuppBatch Set LogisNo = @0, LogisName =@1,LogisCost =@2,LogisMobile=@3 Where Guid = @4", logisNo, logisName, logisCost, logisMobile, guid);
            if (rd.QueryCount > 0)
            {
                msg = "修改成功";
            }
            else
            {
                msg = rd.ErrMsg;
            }
            return msg;
        }
    }
}