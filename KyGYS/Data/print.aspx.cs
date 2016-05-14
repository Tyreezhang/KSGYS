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
            //if (HttpContext.Current.Session["UserName"] == null)
            if (HttpContext.Current.Request.Cookies["Login"] == null)
            {
                return "操作失败";
            }
            string userName = HttpContext.Current.Request.Cookies["Login"]["UserName"].ToString();
            if (string.IsNullOrEmpty(userName))
            {
                return "操作失败";
            }
            string msg = string.Empty;
            StringBuilder sb = new StringBuilder();
            if (string.IsNullOrEmpty(guid)) return msg = "操作失败,请联系客易技术";
            var bch = SerNoCaller.Calr_SuppBatch.Get("Where Guid = @0", guid).FirstOrDefault();
            var ords = SerNoCaller.Calr_SuppOrder.Get("select * from V_ERP_SuppOrder Where SuppBatchGuid = @0", guid);
            if (bch == null || ords==null) return msg = "操作失败!";
            List<T_ERP_SuppOrder> nords = null; 
            if (bch.IsClear)
            {
                if (userName != "admin")
                {
                    nords = ords.Where(j => j.SuppName == userName).ToList();
                }
                else
                {
                    nords = ords;
                }
                if (nords == null || nords.Count < 1) return "操作失败!";
                sb.Append("<div id=\"printdiv\" style=\"width: 740px; \">\n");
                foreach (var item in nords)
                {
                    sb.Append("<div style='width: 740px; height: 522px; page-break-after:always'>\n");
                    sb.Append("<style type='text/css'>td { border: solid #000 1px;} .tdstyle { height: 30px; line-height: 20px; text-align: left; vertical-align: middle; padding-left: 1px; font-family: '微软雅黑'; font-size: 13px;}</style>");
                    sb.Append("<table style=\"width: 500px; margin-left:0px; margin-top:5px; font-size:12px;  border-collapse: collapse;   border: none;\"   border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
                    sb.Append("<tr><td colspan='2'><img src='" + CommonUtil.GetItemImgFileName("http://yjgys.keyierp.com:30000/Item_Images/" + "Ultra_YJ/" + item.OuterIid + item.OuterSkuId + ".jpg") + "' width='500' height='300' /></td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>下单日期：" + bch.CreateDate.ToString("yyyy-MM-dd HH:mm") + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>产品型号：" + item.Category + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>产品数量：" + item.Num + "套" + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>浴柜材质：" + item.Material + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>产品颜色：" + item.Color + "</td></tr>");
                    sb.Append("<tr><td class='tdstyle'>台面石材：" + item.Mesastone + "</td><td class='tdstyle'>台面边型：" + item.EdgeType + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>水龙头孔位：" + item.HoleLocation + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>产品尺寸：" + item.Size + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>主柜：" + item.MainCabinet + "</td></tr>");
                    if (item.Mirror != null && item.Mirror != "" && (item.MirrorCabinet == null || item.MirrorCabinet == ""))
                    {
                        sb.Append("<tr><td colspan='2' class='tdstyle'>镜子：" + item.Mirror + "</td></tr>");
                    }
                    if (item.MirrorCabinet != null && item.MirrorCabinet != "" && (item.Mirror == null || item.Mirror == ""))
                    {
                        sb.Append("<tr><td colspan='2' class='tdstyle'>镜柜：" + item.MirrorCabinet + "</td></tr>");
                    }
                    if (item.Mirror != null && item.Mirror != "" && item.MirrorCabinet != null && item.MirrorCabinet != "")
                    {
                        sb.Append("<tr><td colspan='2' class='tdstyle'>镜子：" + item.Mirror + "   镜柜：" + item.MirrorCabinet + "</td></tr>");
                    }
                    if (item.Wardrobe != null && item.Wardrobe != "")
                    {
                        sb.Append("<tr><td colspan='2' class='tdstyle'>立柜：" + item.Wardrobe + "</td></tr>");
                    }
                    if (item.Cupboard != null && item.Cupboard != "")
                    {
                        sb.Append("<tr><td colspan='2' class='tdstyle'>小吊柜：" + item.Cupboard + "</td></tr>");
                    }
                    sb.Append("<tr><td colspan='2' class='tdstyle'>客户要求：" + "" + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>发货时间：" + "" + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>收货人地址：" + bch.ReceiverName + "," + bch.ReceiverMobile + "," + bch.ReceiverAddress + "</td></tr>");
                    sb.Append("</table></div>");
                }

                sb.Append("</div>\n");
            }
            else
            {
                #region 正常货审打印
                var batchlist = SerNoCaller.Calr_V_ERP_NPrintBatch.GetByProc("exec P_ERP_GetNPrintBatch @0,@1", bch.MergerSysNo, bch.BatchGuid).FirstOrDefault();
                var nitemlist = SerNoCaller.Calr_V_ERP_NPrintItem.GetByProc("exec P_ERP_NPrintItem @0,@1", bch.MergerSysNo, bch.BatchGuid);
                if (batchlist == null || nitemlist == null) return msg = "操作失败!";
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

                sb.Append("<div id=\"printdiv\" style=\"width: 740px; \">\n");
                foreach (var item in itemlist)
                {
                    sb.Append("<div style='width: 740px; height: 522px; page-break-after:always'>\n");
                    sb.Append("<style type='text/css'>td { border: solid #000 1px;} .tdstyle { height: 30px; line-height: 20px; text-align: left; vertical-align: middle; padding-left: 1px; font-family: '微软雅黑'; font-size: 13px;}</style>");
                    sb.Append("<table style=\"width: 500px; margin-left:0px; margin-top:5px; font-size:12px;  border-collapse: collapse;   border: none;\"   border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
                    if (item.CusSavedFileName != null && item.CusSavedFileName != "")
                    {
                        sb.Append("<tr><td colspan='2' style='boder:solid #000 1px;'><img src='" + CommonUtil.GetItemImgFileName("http://yjgys.keyierp.com:30000/Images/" + item.CusSavedFileName) + "' width='500' height='300' /></td></tr>");
                    }
                    else
                    {
                        sb.Append("<tr><td colspan='2'><img src='" + CommonUtil.GetItemImgFileName("http://yjgys.keyierp.com:30000/Item_Images/" + "Ultra_YJ/" + item.OuterIid + item.OuterSkuId + ".jpg") + "' width='500' height='300' /></td></tr>");
                    }
                    sb.Append("<tr><td colspan='2' class='tdstyle'>下单日期：" + bch.CreateDate.ToString("yyyy-MM-dd HH:mm") + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>产品型号：" + item.Category + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>产品数量：" + item.Num + "套" + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>浴柜材质：" + item.Material + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>产品颜色：" + item.Color + "</td></tr>");
                    sb.Append("<tr><td class='tdstyle'>台面石材：" + item.Mesastone + "</td><td class='tdstyle'>台面边型：" + item.EdgeType + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>水龙头孔位：" + item.HoleLocation + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>产品尺寸：" + item.Size + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>主柜：" + item.MainCabinet + "</td></tr>");
                    if (item.Mirror != null && item.Mirror != "" && (item.MirrorCabinet == null || item.MirrorCabinet == ""))
                    {
                        sb.Append("<tr><td colspan='2' class='tdstyle'>镜子：" + item.Mirror + "</td></tr>");
                    }
                    if (item.MirrorCabinet != null && item.MirrorCabinet != "" && (item.Mirror == null || item.Mirror == ""))
                    {
                        sb.Append("<tr><td colspan='2' class='tdstyle'>镜柜：" + item.MirrorCabinet + "</td></tr>");
                    }
                    if (item.Mirror != null && item.Mirror != "" && item.MirrorCabinet != null && item.MirrorCabinet != "")
                    {
                        sb.Append("<tr><td colspan='2' class='tdstyle'>镜子：" + item.Mirror + "   镜柜：" + item.MirrorCabinet + "</td></tr>");
                    }
                    if (item.Wardrobe != null && item.Wardrobe != "")
                    {
                        sb.Append("<tr><td colspan='2' class='tdstyle'>立柜：" + item.Wardrobe + "</td></tr>");
                    }
                    if (item.Cupboard != null && item.Cupboard != "")
                    {
                        sb.Append("<tr><td colspan='2' class='tdstyle'>小吊柜：" + item.Cupboard + "</td></tr>");
                    }
                    sb.Append("<tr><td colspan='2' class='tdstyle'>客户要求：" + batchlist.PrintMemo + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>发货时间：" + batchlist.ProDelTime + "</td></tr>");
                    sb.Append("<tr><td colspan='2' class='tdstyle'>收货人地址：" + batchlist.ReceiverName + "," + batchlist.ReceiverMobile + "," + batchlist.ReceiverAddress + "</td></tr>");
                    if (item.SavedFileName != null && item.SavedFileName != "")
                    {
                        sb.Append("<tr><td colspan='2' style='boder:solid #000 1px;'><img src='" + CommonUtil.GetItemImgFileName("http://yjgys.keyierp.com:30000/Images/" + item.SavedFileName) + "' width='500' height='300' /></td></tr>");
                    }
                    sb.Append("</table></div>");
                }

                sb.Append("</div>\n");
                #endregion
            }
            return sb.ToString();
        }
    }
}