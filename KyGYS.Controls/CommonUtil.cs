using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
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

        /// <summary>
        /// 如果名称中包含禁止的字符,则以MD5 为文件新的名称
        /// </summary>
        /// <param name="FileName"></param>
        /// <returns></returns>
        public static string GetItemImgFileName(string FileName)
        {
            FileName = FileName.Replace("\n", string.Empty).Replace("\r", string.Empty);
            string oriFileName = Path.GetFileNameWithoutExtension(FileName);
            string[] exc = new string[] { @"/", @"\", @"?", @"*", @":", @"<", @">", @"|", "\"" };
            bool bexc = false;
            if (string.IsNullOrEmpty(oriFileName))
            {
                oriFileName = Ultra.Web.Core.Common.ByteStringUtil.ByteArrayToHexStr
            (Ultra.Web.Core.Common.HashDigest.StringDigest(FileName));
                return oriFileName + ".jpg";
            }
            for (int i = 0; i < exc.Length; i++)
            {
                if ((bexc = FileName.Contains(exc[i])))
                    return oriFileName = Ultra.Web.Core.Common.ByteStringUtil.ByteArrayToHexStr
                (Ultra.Web.Core.Common.HashDigest.StringDigest(FileName)) + ".jpg";
            }

            string ext = string.Empty;
            var idx = FileName.LastIndexOf(".");
            if (idx < 1) ext = string.Empty;
            ext = FileName.Substring(idx);

            for (int i = 0; i < exc.Length; i++)
                if ((bexc = oriFileName.Contains(exc[i]))) break;
            if (bexc)
                return Ultra.Web.Core.Common.ByteStringUtil.ByteArrayToHexStr
            (Ultra.Web.Core.Common.HashDigest.StringDigest(oriFileName)) + ext;
            else
                return FileName.EndsWith(".jpg", StringComparison.OrdinalIgnoreCase) ? FileName : FileName + ".jpg";
        }

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