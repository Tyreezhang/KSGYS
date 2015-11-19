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
    public partial class getUnSendList : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            string page = Request.QueryString["page"];
            string rows = Request.QueryString["rows"];
            if (!string.IsNullOrEmpty(page) && !string.IsNullOrEmpty(rows))
            {
                Refreash(int.Parse(page), int.Parse(rows));
                Response.End();
            }
        }

        private void Refreash(int page, int rows)
        {
            string[] list = null;
            var objs = new List<object>();
            string whr = " where  IsSendGoods=0";
            string prefixWhr = string.Empty;
            var idx = 0;
            if (Session["queryStr"] != null)
            {
                string queryStr = Session["queryStr"].ToString();
                list = queryStr.Split(',');
            }
            if (Session["IsManager"] != null && UserName != "")
            {
                if (Session["IsManager"].ToString() != "true" && UserName != "admin")
                {
                    whr += "  and SuppName in (select UserName from T_ERP_MapUser where SuppName = @" + (idx++).ToString() + ")";
                    objs.Add(UserName);
                    prefixWhr = "select * from V_ERP_SuppNBatch ";
                }
                else
                {
                    prefixWhr = "select * from V_ERP_SuppNBatch ";
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
                    var pages = db.Page<V_ERP_SuppNBatch>(page, rows, prefixWhr + whr + " order by OrderTime desc", objs.ToArray());
                    var grd = new EasyGridData<V_ERP_SuppNBatch>();
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
        public static string SendGoods(string guids, string logisNo, string logisName, string logisCost, string logisMobile)
        {
            BasicSecurity basic = new BasicSecurity();
            string msg = string.Empty;
            //if (string.IsNullOrEmpty(guid) || string.IsNullOrEmpty(logisNo) || string.IsNullOrEmpty(logisName) || string.IsNullOrEmpty(logisCost)) return "";

            if (string.IsNullOrEmpty(guids) || basic.UserName == "") return "登陆超时";
            guids = guids.TrimEnd(',');
            Guid groupid = Guid.NewGuid();
            List<T_ERP_BatchOrder> bch = new List<T_ERP_BatchOrder>();
            T_ERP_BatchOrder bo = null;
            string[] newlist = guids.Split(',');
            foreach (string str in newlist)
            {
                bo = new T_ERP_BatchOrder();
                bo.Creator = bo.Updator = basic.UserName;
                bo.IsDel = bo.Reserved3 = true;
                bo.Reserved2 = bo.Remark = "";
                bo.Reserved1 = 0;
                bo.Guid = Guid.Parse(str);
                bo.GroupId = groupid;
                bch.Add(bo);
            }
            SerNoCaller.Calr_BatchOrder.Add(bch);
            Ultra.Logic.ResultData rd = SerNoCaller.Calr_SuppBatch.ExecSql("exec P_ERP_SendGoods @0,@1,@2,@3,@4,@5,@6", guids, groupid, logisNo, logisName, logisCost, logisMobile, basic.UserName);
            if (rd.QueryCount > 0)
            {
                msg = "发货成功";
            }
            else
            {
                msg = rd.ErrMsg;
            }
            return msg;
        }

        [System.Web.Services.WebMethod]
        public static string SetIsDel(string guid)
        {
            string msg = string.Empty;
            if (string.IsNullOrEmpty(guid)) return "";
            Ultra.Logic.ResultData rd = SerNoCaller.Calr_SuppBatch.ExecSql(" Update T_ERP_User Set IsDel = 1 Where Guid =@0", guid);
            if (rd.QueryCount > 0)
            {
                msg = "作废成功";
            }
            else
            {
                msg = rd.ErrMsg;
            }
            return msg;
        }
    }
}