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
    public partial class PurchOrderlist : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
        }

        protected void btnRef_Click(object sender, EventArgs e)
        {
            string queryStr = string.Empty;
            string PurchNo = this.txtPurchNo.Text.Trim();
            queryStr += PurchNo+",";;
            queryStr += tabindex.Value;
            Session["PurStr"] = queryStr;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {

        }
    }
}