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
using System.IO;
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
            if (HttpContext.Current.Request.Cookies["Login"] == null)
            {
                return "操作失败";
            }
            string userName = HttpUtility.UrlDecode(HttpContext.Current.Request.Cookies["Login"]["UserName"].ToString());
            if (string.IsNullOrEmpty(userName))
            {
                return "操作失败";
            }
            string msg = string.Empty;
            if (string.IsNullOrEmpty(guid)) return msg = "操作失败,请联系客易技术";
            var bch = SerNoCaller.Calr_SuppBatch.Get("Where Guid = @0", guid).FirstOrDefault();


            var batchlist = SerNoCaller.Calr_V_ERP_NPrintBatch.GetByProc("exec P_ERP_GetNPrintBatch @0,@1", bch.MergerSysNo, bch.BatchGuid).FirstOrDefault();
            var nitemlist = SerNoCaller.Calr_V_ERP_NPrintItem.GetByProc("exec P_ERP_NPrintItem @0,@1", bch.MergerSysNo, bch.BatchGuid);
            if (batchlist == null || nitemlist == null) return msg = "未财审";
            List<V_ERP_NPrintItem> itemlist = null;
            if (userName != "admin")
            {
                itemlist = nitemlist.Where(j => j.SuppName == userName).ToList();
            }
            else
            {
                itemlist = nitemlist;
            }
            if (batchlist == null || itemlist == null || itemlist.Count < 1) return "";
            int count = itemlist.Count;
            count = count + 1;
            StringBuilder sb = new StringBuilder();
            sb.Append("<div id=\"printdiv\" style=\"width: 740px; \">\n");

            sb.Append("<div style=\"margin-top: 0px; margin-left: 180px; width: 767px;\"><span style=\"font-family: '新宋体'; font-size: 23px; font-weight: bold;\">佛 山 市 美 森 家 具 有 限 公 司</span></div>");
            sb.Append("<div style=\"margin-top: 8px; margin-left: 320px; width: 767px;\"><span style=\"font-family: '新宋体'; font-size: 22px; font-weight: bold;\">发 货 单</span></div>");
            sb.Append(@"<style type='text/css'>.itemlist td {border: solid #000 1px;} .itemlist {width: 767px; margin-left: 2px; margin-top: 5px; font-size: 12px; border-collapse: collapse; border: none;}  
                    .list {width: 767px; margin-left: 2px; margin-top: 5px; font-size: 12px; border-collapse: collapse; border: none;} .tdFirst {width: 65px; height: 17px; line-height: 17px; text-align: left; font-family: '微软雅黑'; font-size: 13px;} 
                    .tdSecond {width: 400px; height: 17px; line-height: 17px; text-align: left; vertical-align: middle; padding-left: 1px; font-family: '微软雅黑'; font-size: 13px;} 
                    .tdThree {width: 65px; height: 17px; line-height: 17px; text-align: left; vertical-align: middle; padding-left: 1px; font-family: '微软雅黑'; font-size: 13px;} 
                    .tdFour {height: 17px; line-height: 17px; text-align: left; vertical-align: middle; padding-left: 1px; font-family: '微软雅黑'; font-size: 13px;} 
                    .tdFive {height: 15px; line-height: 15px; text-align: left; vertical-align: middle;  font-family: '微软雅黑'; font-size: 13px;} 
                    .tdSix {height: 32px; line-height: 32px; text-align: center; vertical-align: middle; padding-left: 1px; font-family: '微软雅黑'; font-size: 14px;}</style>");
            sb.Append("<table class=\"list\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
            sb.Append("<tr><td class=\"tdFirst\">客户名称 </td><td class=\"tdSecond\" colspan=\"3\">" + batchlist.ReceiverName + "</td><td class=\"tdThree\">公司地址</td><td class=\"tdFour\">广东省佛山市顺德区龙江镇高窖工业区</td></tr>");
            sb.Append("<tr><td class=\"tdFirst\">客户电话 </td><td class=\"tdSecond\" colspan=\"3\">" + batchlist.ReceiverMobile + "</td><td class=\"tdThree\">联系电话</td><td class=\"tdFour\">0757-268856523</td></tr>");
            sb.Append("<tr><td class=\"tdFirst\">地址 </td><td class=\"tdSecond\" colspan=\"3\">" + batchlist.ReceiverAddress + "</td><td class=\"tdThree\">业务员</td><td class=\"tdFour\">" + batchlist.UserName + "</td></tr>");
            sb.Append("<tr><td class=\"tdFirst\">订单编号 </td><td class=\"tdSecond\" colspan=\"3\">" + batchlist.Tids + "</td><td class=\"tdThree\">物流公司</td><td class=\"tdFour\">" + batchlist.LogisName + "</td></tr>");
            sb.Append("<tr><td class=\"tdFirst\">运费类型 </td><td class=\"tdSecond\" style=\"font-size: 17px;\" colspan=\"3\"><b>" + batchlist.PostFeeType + "</b></td><td class=\"tdThree\">三包方式</td><td  class=\"tdFour\" style=\"font-size: 17px;\"><b>" + batchlist.ThirdPackType + "</b></td></tr>");
            sb.Append("<tr><td class=\"tdFive\" style=\"width: 65px;\">订单日期 </td><td class=\"tdFive\" style=\"width: 155px; padding-left: 1px;\">" + batchlist.PayTime + "</td><td class=\"tdFive\" style=\"width: 65px; padding-left: 1px; \">出货日期</td><td class=\"tdFive\" style=\"width: 155px; padding-left: 1px; \"><b>" + batchlist.ProDelTime.Value.ToString("yyyy-MM-dd") + "</b></td><td class=\"tdFive\" style=\"width: 65px; height: 15px;  padding-left: 1px;\">包件总数</td><td class=\"tdFour\">" + batchlist.PackageCount + "</td></tr>");
            sb.Append("</table>");
            sb.Append("<table class=\"itemlist\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
            sb.Append("<tr><td class=\"tdSix\" style=\"width: 65px; text-align: left;\">产品型号</td><td class=\"tdSix\">产品图片</td><td class=\"tdSix\" style=\"width:305px;\" colspan=\"2\">规格</td><td class=\"tdSix\"  style=\"width: 50px;\">数量</td><td class=\"tdSix\" style=\"width: 80px;\">包装件数</td><td class=\"tdSix\" style=\"width: 60px;\" >包装体积</td><td class=\"tdSix\" style=\"width: 170px;\">备注</td></tr>");
            //<td class=\"tdSix\" style=\"width: 100px;\">定制规格颜色</td>
            foreach (var item in itemlist)
            {
                sb.Append("<tr><td class=\"tdSix\" style=\"width: 65px; text-align: left;\">" + item.OuterIid + "</td><td class=\"tdSix\"><img src='" + CommonUtil.GetItemImgFileName("http://msgys.keyierp.com:30000/Item_Images/" + "MSTest/" + item.OuterIid + item.OuterSkuId + ".jpg") + "' width='80' height='100' onerror=\"this.style.display='none'\" /></td><td class=\"tdSix\" style=\"width: 305px; text-align: left;\" colspan=\"2\">" + item.OuterSkuId + "</td><td class=\"tdSix\"  style=\"width: 50px;\">" + item.Num + "</td><td class=\"tdSix\"  style=\"width: 80px;\">" + item.PackageCount + "</td><td class=\"tdSix\"  style=\"width: 60px;\">" + item.Volume + "</td><td class=\"tdSix\" style=\"width: 170px;\">" + item.Remark + "</td></tr>");
            }
            sb.Append("<tr><td class=\"tdSix\" style=\"width: 65px; text-align: left;\">发票</td><td class=\"tdSix\" style=\"text-align: left;\" colspan=\"7\">" + batchlist.Title + "</td></tr>");
            sb.Append("<tr><td class=\"tdSix\" style=\"width: 65px; text-align: left;\">客户留言</td><td class=\"tdSix\" style=\"text-align: left;\" colspan=\"7\">" + batchlist.BuyerMemo + "</td></tr>");
            sb.Append("<tr></tr>");
            sb.Append("<tr><td style=\"border-color: white; padding: 2px;\" colspan=\"8\">备注：所有产品都是经过仔细检查后才发货,为了保障您得利益,请签收前务必核对产品包装数量,外包装破损需拆开检查.签收时如发现件数不对或运输损坏请不要签收,立即联系我们,我们会迅速协助解答和处理.运输过程中造成的货物丢失或损坏,如未仔细检查直接签收,导致的经济损失由客户单方承担.此出货单代表产品质量保修卡,请妥善保管!</td></tr>");
            sb.Append("</table><div style=\"width: 767px; margin-left: 8px; margin-top: 5px; font-size: 16px; font-family: '宋体';\">");
            sb.Append("<span>跟单：</span><span>" + batchlist.UserName + "</span><span style=\"margin-left: 185px;\">财务：</span><span>" + batchlist.FinViewer + "</span><span style=\"margin-left: 180px;\">仓库：</span><span></span><span style=\"display: block\"></span><span style=\"margin-left:115px;font-size:13px;\">白色联：存根&nbsp;&nbsp;红色联：业务员&nbsp;&nbsp;蓝色联：仓库&nbsp;&nbsp;绿色联：司机&nbsp;&nbsp;黄色联：财务</span></div>");


            sb.Append("</div>\n");
            //SerNoCaller.Calr_SuppBatch.ExecSql("Update T_ERP_SuppBatch set Reserved1 = 1 where guid =@0 and SuppName = @1", guid, userName);
            return sb.ToString();
        }


        [System.Web.Services.WebMethod]
        public static string PrintPurch(string guid)
        {
            if (HttpContext.Current.Request.Cookies["Login"] == null)
            {
                return "操作失败";
            }
            string userName = HttpUtility.UrlDecode(HttpContext.Current.Request.Cookies["Login"]["UserName"].ToString());
            if (string.IsNullOrEmpty(userName))
            {
                return "操作失败";
            }
            string msg = string.Empty;
            if (string.IsNullOrEmpty(guid)) return msg = "操作失败,请联系客易技术";
            var bch = SerNoCaller.Calr_SuppPurch.Get("Where Guid = @0", guid).FirstOrDefault();
            if (bch == null) return msg = "操作失败,请联系客易技术";
            var batchlist = SerNoCaller.Calr_V_ERP_NprintPurch.GetByProc("exec P_ERP_GetNprintPurch @0", bch.ItemSession).FirstOrDefault();
            var nitemlist = SerNoCaller.Calr_V_ERP_PurchItemGet.GetByProc("exec P_ERP_NPurchItemGet @0", bch.ItemSession);
            if (batchlist == null || nitemlist == null) return msg = "操作失败,请联系客易技术";
            List<V_ERP_PurchItemGet> itemlist = null;
            if (userName != "admin")
            {
                itemlist = nitemlist.Where(j => j.SuppName == userName).ToList();
            }
            else
            {
                itemlist = nitemlist;
            }
            if (batchlist == null || itemlist == null || itemlist.Count < 1) return "";
            StringBuilder html = new StringBuilder();
            html.Append("<div id=\"printdiv\" style=\"width: 740px; \">\n");
            var pth = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "order.html");
            var txtorder = File.ReadAllText(pth, Encoding.UTF8);
            StringBuilder sbsub = new StringBuilder(100);
            foreach (var item in itemlist)
            {
                string isCardImg = string.Empty;
                if (item.IsCard)
                {
                    if (!string.IsNullOrEmpty(item.SKImageUrl))
                    {
                        isCardImg = string.Format("<img src='{0}' border='0' onerror=\"this.style.display='none'\" style=\"width:94px;height:79px\"  />", "http://101.251.96.120:30000/Images/" + item.SKImageUrl.Remove(0, 6));
                    }
                }
                else
                {
                    isCardImg = "";
                }
                sbsub.AppendLine(string.Format(txtorder, item.OuterIid, string.Format("<img src='{0}' border='0' onerror=\"this.style.display='none'\" style=\"width:94px;height:79px\"  />", "http://101.251.96.120:30000/Item_Images/MSTest/" + CommonUtil.GetItemImgFileName(item.OuterIid + item.OuterSkuId + ".jpg"))
                    , item.OuterSkuId, item.IsCard == false ? string.Empty : isCardImg, item.RealNum, item.AssignItemNum, item.RealPrice, item.SumCostPrice, item.ReceiverName, item.Remark));
            }
            pth = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "head.html");
            var txtmst = File.ReadAllText(pth, Encoding.UTF8);
            try
            {
                html.AppendLine(string.Format(txtmst, batchlist.SuppName, batchlist.PurchNo, batchlist.Phone, batchlist.SuppQQ, batchlist.PurchTime, batchlist.PlanArriveTime, sbsub.ToString(), batchlist.PurchNum, batchlist.SumAllPrice, batchlist.UserName, batchlist.Auditor, batchlist.PrintTime));
                html.Append("</div>\n");
            }
            catch (Exception ex)
            {


            }
            html.Append("</div>\n");

            return html.ToString();
        }
    }
}