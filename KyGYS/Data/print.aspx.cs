using KyGYS.Controls.Caller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UltraDbEntity;
using MoreLinq;
using KyGYS.Controls;
using System.Data;
using Ultra.Web.Core.Common;
namespace KyGYS.Data
{
    public partial class print : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }
        [System.Web.Services.WebMethod]
        public static string Print(string guid)
        {
            if (HttpContext.Current.Session["UserName"] == null)
            {
                return "操作失败";
            }
            string userName = HttpContext.Current.Session["UserName"].ToString();
            if (string.IsNullOrEmpty(userName))
            {
                return "操作失败";
            }
            string msg = string.Empty;
            if (string.IsNullOrEmpty(guid)) return msg = "操作失败,请联系客易技术";

            SerNoCaller.Calr_SuppBatch.ExecSql("Update T_ERP_SuppBatch set Reserved1 = 1 where guid =@0 and SuppName = @1", guid, userName);
            var bch = SerNoCaller.Calr_SuppBatch.Get("Where Guid = @0", guid).FirstOrDefault();
            List<T_ERP_SuppOrder> ords = null;
            if (userName != "admin")
            {
                 ords = SerNoCaller.Calr_SuppOrder.Get("select * from V_ERP_SuppOrder Where SuppBatchGuid = @0 and SuppName =@1", guid, userName);
            }
            else
            {
                 ords = SerNoCaller.Calr_SuppOrder.Get("select * from V_ERP_SuppOrder Where SuppBatchGuid = @0", guid);
            }
            #region 凯森
            List<UltraDbEntity.T_ERP_SuppOrder> lstSum = new List<T_ERP_SuppOrder>();
            ords.ForEach(j =>
            {
                j.Num = j.Num * (j.PackageCount == null ? 1 : j.PackageCount.Value == 0 ? 1 : j.PackageCount.Value);
                while (j.Num > 0)
                {
                    var net = j.Copy(); net.Num = 1;
                    lstSum.Add(net);
                    j.Num = j.Num - 1;
                }
            });
            #endregion

            StringBuilder sb = new StringBuilder();
            //sb.Append("<div id=\"printdiv\" style=\"width: 720px; height: 500px;\">\n");
            //sb.Append("<span style=\"float: right;\">\n");
            //sb.Append("No:" + "12111");
            //sb.Append("</span >\n");

       
            #region 凯森
            sb.Append("<div id=\"printdiv\" style=\"width: 720px; \">\n");
            for (int i = 0; i < lstSum.Count; i++)
            {
                sb.Append("<div style='width: 747px; height: 522px; page-break-after:always'>\n");
                sb.Append("<table style='width: 747px; margin-left: 50px; font-size: 22px; font-family:'微软雅黑';border='0' ;cellspacing='0'; cellpadding='0'>\n");
                sb.Append(" <tr style='height: 800px;'></tr>\n");
                sb.Append(" <tr style='height: 110px;'></tr>\n");
                sb.Append(" <tr style='height: 65px;'></tr>\n");
                sb.Append("<tr style='height: 105px;'><td>" + bch.ReceiverState + bch.ReceiverCity + bch.ReceiverDistrict + "</td></tr>\n");
                sb.Append(" <tr style='height: 70px;'></tr>\n");
                sb.Append("<tr style='height: 80px;'><td style='width: 270px;'>" + bch.ReceiverName + "</td> <td style='width: 330px;'>" + lstSum[i].OuterSkuId + "</td></tr>\n");
                sb.Append("<tr style='height: 120px;'><td>" + lstSum[i].OuterIid + "</td> <td>" + lstSum[i].Color + "</td></tr>\n");
                sb.Append("</table>\n");
                sb.Append("</div>\n");
            }
            #endregion

            #region 原先标准
            //sb.Append("<table style=\"width: 720px; font-size:12px; font-weight:bold;  padding: 4px;\"  border=\"2\" cellspacing=\"0\" cellpadding=\"0\">\n");
            //sb.Append("<tr><td style=\"width: 90px;\">客户名称</td><td>" + bch.ReceiverName.ToString() + "</td><td>客户ID</td><td colspan=\"2\">" + bch.BuyerNick + "</td><td style=\"width: 70px;\">出货时间</td><td colspan=\"3\">" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "</td></tr>\n");
            //sb.Append("<tr><td style=\"width: 90px;\">订单编号</td><td colspan=\"4\">" + bch.Tid + "</td><td>店铺</td><td colspan=\"3\">" + bch.SellerNick + "</td></tr>\n");
            //sb.Append("<tr><td style=\"width: 90px;\">联系电话</td><td colspan=\"4\">" + bch.ReceiverMobile + "</td><td style=\"width: 90px;\">公司名称</td><td colspan=\"3\">" + bch.CorpName + "</td></tr>\n");
            //sb.Append("<tr><td style=\"width: 90px;\">收货地址</td><td colspan=\"4\">" + bch.ReceiverAddress + "</td><td style=\"width: 90px;\">公司地址</td><td colspan=\"3\">" + bch.CorpAddress + "</td></tr>\n");
            //sb.Append("<tr><td style=\"width: 90px;\">物流信息</td><td colspan=\"4\">" + bch.LogisName +" "+bch.ThirdPackType+ " "+bch.LogisMobile+"</td><td style=\"width: 90px;\">公司电话</td><td colspan=\"3\">" + bch.CorpMobile + "</td></tr>\n");
            //sb.Append("<tr><td style=\"width: 90px;\">序号</td><td style=\"width: 100px;\">产品型号</td><td style=\"width: 100px;\">产品名称</td><td style=\"width: 100px;\">产品规格</td><td style=\"width: 100px;\">家具结构</td><td style=\"width: 70px;\">皮布号</td><td style=\"width: 100px;\">数量</td><td style=\"width: 100px;\">包件数</td><td style=\"width: 100px;\">备注</td></tr>\n");
            //int j = 1;
            //string batchcount = ords.Count.ToString();
            //int packcount = 0;
            //for (int i = 0; i < ords.Count; i++)
            //{
            //    sb.Append("<tr><td style=\"width: 90px;\">" + j.ToString() + "</td><td style=\"width: 100px;\">" + ords[i].OuterIid + "</td><td style=\"width: 100px;\">" + ords[i].ItemName + "</td><td style=\"width: 100px;\">" + ords[i].OuterSkuId + "</td><td style=\"width: 100px;\">" + ords[i].Func + "</td><td style=\"width: 70px;\">" + ords[i].ClothNums + "</td><td style=\"width: 100px;\">" + ords[i].Num.ToString() + "</td><td style=\"width: 100px;\">" + ords[i].PackageCount.ToString() + "</td><td style=\"width: 100px;\">" + ords[i].Remark + "</td></tr>\n");
            //    j++;
            //    packcount += ords[i].PackageCount == null ? 0 : int.Parse(ords[i].PackageCount.ToString());
            //}
            //sb.Append("<tr><td style=\"width: 90px;\"></td><td style=\"width: 100px;\"></td><td style=\"width: 100px;\"></td><td style=\"width: 100px;\"></td><td style=\"width: 100px;\"></td><td style=\"width: 70px;\">合计</td><td style=\"width: 100px;\">" + batchcount + "</td><td style=\"width: 100px;\">" + packcount + "</td><td style=\"width: 100px;\"></td></tr>\n");
            //sb.Append("<tr><td style=\"width: 90px;\">客服</td><td style=\"width: 100px;\" colspan=\"2\">" + bch.UserName + "</td><td style=\"width: 100px;\">经办人</td><td style=\"width: 100px;\" colspan=\"3\">" + userName + "</td><td style=\"width: 100px;\">收货人</td><td style=\"width: 100px;\">" + bch.ReceiverName + "</td></tr>\n");
            //sb.Append("<tr><td style=\"width: 90px;\">备注</td><td  colspan=\"8\">" + "1、货物签收时请仔细核对件数、外包装有无明显的破损，若有问题，请及时联系！<br/> 2、收货后，请尽快拆封检查并通风透气，若有问题，请及时拍照并与我们及时联系！" + "</td></tr>\n");
            //sb.Append("</table></div>\n");
            #endregion
            sb.Append("</div>\n");
            return sb.ToString();
        }
    }
}