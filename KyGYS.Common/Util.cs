using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ultra.Web.Core.Common;

namespace KyGYS.Common
{
    public sealed class Util
    {

        private static string ConKey = "1F520EC40D7FDD0E2C517288FA4C5B12";
        private static string PwdKey = "9E437346EBA2CB75FF37234EC8EE35D0";

        public static string Encrypt(string src)
        {
            DESEncrypt d = new DESEncrypt();
            return d.EncryptString(src, ByteStringUtil.ByteArrayToHexStr(
                HashDigest.StringDigest(ConKey)));
        }

        public static string Decrypt(string src)
        {
            DESEncrypt d = new DESEncrypt();
            return d.DecryptString(src, ByteStringUtil.ByteArrayToHexStr(
                HashDigest.StringDigest(ConKey)));
        }

        public static string EncryptPwd(string src)
        {
            DESEncrypt d = new DESEncrypt();
            return ByteStringUtil.ByteArrayToHexStr(
                HashDigest.StringDigest(
                d.EncryptString(src, ByteStringUtil.ByteArrayToHexStr(
                HashDigest.StringDigest(PwdKey)))));
        }
    }
}
