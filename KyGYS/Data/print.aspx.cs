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
            if (string.IsNullOrEmpty(guid)) return msg = "信息已发生变化，请刷新后操作!";
            var bch = SerNoCaller.Calr_SuppBatch.Get("Where Guid = @0", guid).FirstOrDefault();
            if (bch == null) return msg = "信息已发生变化，请刷新后操作!";
            var batchlist = SerNoCaller.Calr_V_ERP_NPrintBatch.GetByProc("exec P_ERP_GetNPrintBatch @0,@1", bch.MergerSysNo, bch.BatchGuid).FirstOrDefault();
            var nitemlist = SerNoCaller.Calr_V_ERP_NPrintItem.GetByProc("exec P_ERP_NPrintItem @0,@1", bch.MergerSysNo, bch.BatchGuid);
            if (batchlist == null || nitemlist == null) return msg = "信息已发生变化，请刷新后操作!";
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

            string sellernick = string.Empty;
            string sellerone = string.Empty;
            string sellersecond = string.Empty;
            string sellerthree = string.Empty;
            string logo = string.Empty;
            switch(bch.SellerNick)
            {
                case "伴雪逍遥":
                    logo = "<img  src=\"images/皇客.png\" style=\"margin-top:3px;\"/>";
                    sellernick = "<div style=\"margin-top: -70px; margin-left: 220px; width: 767px;\"><span style=\"font-family: '新宋体'; font-size: 24px; font-weight: bold;\">佛山市自享家具有限公司</span></div>";
                    sellerone = "皇客品牌 （淘宝店）";
                    sellersecond = "厂址：广东省佛山市顺德区乐从工业区";
                    sellerthree = "电话:0757-23636809&nbsp;&nbsp;手机：18942468629&nbsp;&nbsp;QQ：2693423356&nbsp;&nbsp;网址：gdhuangkejiaju.taobao.com";
                    break;
                case "广东顺德品牌家具":
                    logo = "<img  src=\"images/3.png\" style=\"margin-top:5px;\" />";
                    sellernick = "<div style=\"margin-top: -30px; margin-left: 220px; width: 767px;\"><span style=\"font-family: '新宋体'; font-size: 24px; font-weight: bold;\">佛山市自享家具有限公司</span></div>";
                    sellerone = "森兰品牌 （雅尚淘宝店）";
                    sellersecond = "厂址：广东省佛山市顺德区乐从工业区";
                    sellerthree = "电话:0757-23636809&nbsp;&nbsp;手机：17708617774&nbsp;&nbsp;QQ：3270784437&nbsp;&nbsp;网址：gdsdppjj.taobao.com";
                    break;
                case "森兰旗舰店":
                    logo = "<img  src=\"images/3.png\" style=\"margin-top:5px;\" />";
                    sellernick = "<div style=\"margin-top: -30px; margin-left: 220px; width: 767px;\"><span style=\"font-family: '新宋体'; font-size: 24px; font-weight: bold;\">佛山市自享家具有限公司</span></div>";
                    sellerone = "森兰品牌 （天猫店）";
                    sellersecond = "厂址：广东省佛山市顺德区乐从工业区";
                    sellerthree = "电话:0757-23636809&nbsp;&nbsp;手机：17708617774&nbsp;&nbsp;QQ：3270784437&nbsp;&nbsp;网址：senlan.tmall.com";
                    break;
                case "皇客家居旗舰店":
                    logo = "<img  src=\"images/皇客.png\" style=\"margin-top:3px;\" />";
                    sellernick = "<div style=\"margin-top: -70px; margin-left: 220px; width: 767px;\"><span style=\"font-family: '新宋体'; font-size: 24px; font-weight: bold;\">佛山市自享家具有限公司</span></div>";
                    sellerone = "皇客品牌 （京东店）";
                    sellersecond = "厂址：广东省佛山市顺德区乐从工业区";
                    sellerthree = "电话:0757-23637969&nbsp;&nbsp;手机：13377571755&nbsp;&nbsp;QQ：2978547608&nbsp;&nbsp;网址：http://mall.jd.com/index-146520.html";
                    break;
            }
            //拼接出货运信息
            var volume = batchlist.Volume != null && batchlist.Volume.HasValue ? batchlist.Volume : 0;
            var postFee = batchlist.PostFee != null && batchlist.PostFee.HasValue ? batchlist.PostFee : 0;
            var ThirdPackFee = batchlist.ThirdPackFee != null && batchlist.ThirdPackFee.HasValue ? batchlist.ThirdPackFee : 0;
            var pricePv = batchlist.VolumnPostFee != null && batchlist.VolumnPostFee.HasValue ? batchlist.VolumnPostFee : 0;
            var strPricePv = pricePv == 0 ? " " : "" + pricePv + "/方";
            var strVol = volume > 0 ? "共" + volume + "方" : "";

            var hydz = "" + batchlist.LogisName + batchlist.LogisMobile + "  " + strPricePv + strVol;

            if (ThirdPackFee > 0 || batchlist.ThirdPackType != "")
            {
                hydz = hydz + "+";
                if (ThirdPackFee > 0)
                {
                    hydz = hydz + ThirdPackFee + "元";
                }
                if (batchlist.ThirdPackType != "")
                {
                    hydz = hydz + batchlist.ThirdPackType;
                }
            }
            var sumF = postFee + ThirdPackFee;
            var strSumF = sumF == 0 ? "" : "=" + sumF + "元";
            hydz = hydz + strSumF + "    " + batchlist.PostFeeType;


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
            var div = itemlist.Count / 3;
            var mod = itemlist.Count % 3;
            if(mod<3 && mod != 0)
            {
                mod = 1;
            }
            var page = div + mod;


             StringBuilder html = new StringBuilder(100);
             html.Append("<div id=\"printdiv\" style=\"width: 740px; \">\n");
             for (int i = 0; i < page; i++)
             {
                 html.Append("<div style='width: 740px;  page-break-after:always'>\n");
                 var eitemlist = itemlist.OrderBy(k => k.SuppName).ThenBy(k => k.RowNum).Skip(i * 3).Take(3).ToList();
                 var pth = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "zxorder.html");
                 var txtorder = File.ReadAllText(pth, Encoding.UTF8);
                 StringBuilder sbsub = new StringBuilder(100);
                 foreach (var item in eitemlist)
                 {
                     sbsub.AppendLine(string.Format(txtorder, item.OuterIid, item.OuterSkuId, item.Direction, item.Num
                         , string.Format("<img src='{0}' border='0' onerror=\"this.style.display='none'\" style=\"width:120px;height:58px;\"  />", "http://zxgys.keyierp.com:30000/Item_Images/Ultra_ZX/" + CommonUtil.GetItemImgFileName(item.OuterIid + item.OuterSkuId + ".jpg"))
                         , item.PackageCount, item.Remark));
                 }
                 pth = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "zx.html");
                 var txtmst = File.ReadAllText(pth, Encoding.UTF8);
                 try
                 {
                     html.AppendLine(string.Format(txtmst, sellernick, sellerone, sellersecond, sellerthree, batchlist.PayTime, hydz, batchlist.ProDelTime == null ? "" : batchlist.ProDelTime.Value.ToString("yyyy-MM-dd")
                     , batchlist.ReceiverName, batchlist.ReceiverMobile, batchlist.Tids, batchlist.ReceiverAddress, sbsub.ToString(), batchlist.AddrPrintMemo, logo));
                     html.Append("</div>\n");
                 }
                 catch (Exception ex)
                 {

                 }
             }
             html.Append("</div>\n");
          
            return html.ToString();
        }
    }
}