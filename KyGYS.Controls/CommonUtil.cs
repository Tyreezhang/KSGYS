using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace KyGYS.Controls
{
    public class CommonUtil
    {
        public static string ConnStr
        {
            get
            {
                _ConnStr = string.IsNullOrEmpty(_ConnStr) ? GetConn() : _ConnStr;
                return _ConnStr;
            }
        }

        private static string GetConn()
        {
            Ultra.Web.Core.Configuration.OptionConfig cfg = new Ultra.Web.Core.Configuration.OptionConfig(Ultra.Web.Core.Configuration.EnOptionConfigType.Web);
            string vlu = cfg.Get<string>("conn");
            if (string.IsNullOrEmpty(vlu))
                cfg.Set<string>("conn", string.Empty);
            return vlu;
        }

        private static string _ConnStr = string.Empty;

    }

    public class EasyGridData<T>
    {
        public string total { get; set; }

        public List<T> rows { get; set; }

        public EasyGridData<T> Init(PetaPoco.Page<T> pg)
        {
            this.total = pg.TotalItems.ToString();
            this.rows = pg.Items;
            return this;
        }
    }
}