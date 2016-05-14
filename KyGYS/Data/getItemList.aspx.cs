using KyGYS.Controls;
using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UltraDbEntity;

namespace KyGYS.Data
{
    public partial class getItemList : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            string SuppBatchGuid = Request.QueryString["SuppBatchGuid"];
            if (SuppBatchGuid != null && !string.IsNullOrEmpty(SuppBatchGuid))
            {
                GetItem(SuppBatchGuid);
            }
        }

        private void GetItem(string SuppBatchGuid)
        {
            List<V_ERP_SuppOrder> items = null;
            using (var db = new Database(SQLCONN.Conn))
            {
                if (!string.IsNullOrEmpty(UserName) && UserName != "admin")
                {
                    items = db.Fetch<V_ERP_SuppOrder>("select * from V_ERP_SuppOrder where SuppBatchGuid=@0  and SuppName =@1", SuppBatchGuid, UserName);
                }
                else
                {
                    items = db.Fetch<V_ERP_SuppOrder>("select * from V_ERP_SuppOrder where SuppBatchGuid=@0", SuppBatchGuid);
                }  
                items.ForEach(j =>
                {
                    j.Reserved2 = KyGYS.Controls.CommonUtil.GetItemImgFileName(j.Reserved2);
                });
                var grd = new EasyGridData<V_ERP_SuppOrder>();
                grd.total = items.Count().ToString();
                grd.rows = items;
                string data = Newtonsoft.Json.JsonConvert.SerializeObject(grd);
                Response.Write(data);
                Response.End();
            }
        }
    }
}