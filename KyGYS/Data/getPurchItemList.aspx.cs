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
    public partial class getPurchItemList : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            string SuppPurchGuid = Request.QueryString["SuppPurchGuid"];
            if (SuppPurchGuid != null && !string.IsNullOrEmpty(SuppPurchGuid))
            {
                GetItem(SuppPurchGuid);
            }
        }

        private void GetItem(string SuppPurchGuid)
        {
            List<T_ERP_SuppPurchItem> items = null;
            using (var db = new Database(SQLCONN.Conn))
            {
                if (!string.IsNullOrEmpty(UserName) && UserName != "admin")
                {
                    items = db.Fetch<T_ERP_SuppPurchItem>("select * from T_ERP_SuppPurchItem where SuppPurchGuid=@0  and SuppName =@1", SuppPurchGuid, UserName);
                }
                else
                {
                    items = db.Fetch<T_ERP_SuppPurchItem>("select * from T_ERP_SuppPurchItem where SuppPurchGuid=@0", SuppPurchGuid);
                }  
                items.ForEach(j =>
                {
                    j.Reserved2 = "http://101.251.96.120:30000/Item_Images/MSTest/" + KyGYS.Controls.CommonUtil.GetItemImgFileName(j.OuterIid + j.OuterSkuId + ".jpg");
                });
                var grd = new EasyGridData<T_ERP_SuppPurchItem>();
                grd.total = items.Count().ToString();
                grd.rows = items;
                string data = Newtonsoft.Json.JsonConvert.SerializeObject(grd);
                Response.Write(data);
                Response.End();
            }
        }
    }
}