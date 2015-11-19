using KyGYS.Controls;
using PetaPoco;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UltraDbEntity;
namespace KyGYS
{
    public partial class SendGoodsList : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }

        protected void btnRef_Click(object sender, EventArgs e)
        {
            string queryStr = string.Empty;
            string txtBuyerNick = this.txtBuyerNick.Text.Trim();
            queryStr += txtBuyerNick + ",";
            string txtSellerNick = this.txtSellerNick.Text.Trim();
            queryStr += txtSellerNick + ",";
            string txtReceiverName = this.txtReceiverName.Text.Trim();
            queryStr += txtReceiverName+",";
            string txtReceiverMobile= this.txtReceiverMobile.Text.Trim();
            queryStr += txtReceiverMobile + ",";
            string txtReceiverAddress = this.txtReceiverAddress.Text.Trim();
            queryStr += txtReceiverAddress;
            Session["queryStr"] = queryStr;
        }
    }
}