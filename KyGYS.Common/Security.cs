using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace KyGYS.Common
{
    public class Security
    {
        /// <summary>
        /// 32位MD5加密
        /// </summary>
        /// <param name="laws">明文</param>
        /// <returns></returns>
        public static string GetMd5(string laws)
        {
            string pwd = string.Empty;

            MD5 md5 = MD5.Create();
            byte[] s = md5.ComputeHash(Encoding.UTF8.GetBytes(laws));
            for (int i = 0; i < s.Length; i++)
            {
                pwd += s[i].ToString("X");
            }
            return pwd;
        }
    }
}
