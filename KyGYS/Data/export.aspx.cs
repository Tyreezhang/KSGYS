using KyGYS.Controls;
using PetaPoco;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ultra.Web.Core.Common;

namespace KyGYS.Data
{
    public partial class export : BasicSecurity
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            Export();
        }

        private void Export()
        {
            string send = string.Empty;
            if (Request.QueryString["send"] != null)
            {
                send = Request.QueryString["send"];
            }
            string queryStr = string.Empty;
            if (UserName != "admin")
                queryStr = string.Format("  and  a.SuppName in (select UserName from T_ERP_MapUser where SuppName ='{0}')  and a.IsSendGoods = {1}", UserName, int.Parse(send));
            else
                queryStr = string.Format(" and a.IsSendGoods = {0}", int.Parse(send));
            DataTable dt = null;
            using (var db = new Database(SQLCONN.Conn))
            {
                SqlParameter[] prms = new SqlParameter[]{           
                new SqlParameter("@queryStr", queryStr),
            };
                dt = SqlHelper.ExecuteDataTable(SQLCONN.Conn, CommandType.StoredProcedure, "P_ERP_Excel", prms);
            }
            //if (dt != null && dt.Rows.Count > 0)
            //{
                int tRowCount = dt.Rows.Count;
                int tColumnCount = dt.Columns.Count;
                Response.Expires = 0;
                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "utf-8";
                Response.ContentEncoding = System.Text.Encoding.UTF8;
                Response.ContentType = "application/vnd.ms-excel";
                Response.AddHeader("Content-Disposition", "attachment; filename=订单明细.xls");
                Response.Write("<meta http-equiv=Content-Type content=text/html;charset=utf-8>");
                Response.Write("<Table borderColor=black border=1>");
                Response.Write("\n <TR>");
                for (int i = 0; i < tColumnCount; i++)
                {
                    Response.Write("\n <TD  bgcolor = #fff8dc>");
                    Response.Write(dt.Columns[i].ColumnName);
                    Response.Write("\n </TD>");
                }
                Response.Write("\n </TR>");
                for (int j = 0; j < tRowCount; j++)
                {
                    Response.Write("\n <TR>");
                    for (int k = 0; k < tColumnCount; k++)
                    {
                        Response.Write("\n <TD align=\"right\" style='vnd.ms-excel.numberformat:@'>");

                        Response.Write(dt.Rows[j][k].ToString());
                        Response.Write("\n </TD>");
                    }
                    Response.Write("\n </TR>");
                }
                Response.Write("</Table>");
                Response.End();
            //}
        }
    }
}