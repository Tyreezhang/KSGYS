using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KyGYS
{
    public class BasicSecurity : System.Web.UI.Page
    {

        //public  string UserName
        //{
        //    get
        //    {
        //        if (Session["UserName"] != null)
        //        {
        //            return Session["UserName"].ToString();
        //        }
        //        else
        //        {
        //            return string.Empty;
        //        }
        //    }
        //}

        public string UserName
        {
            get
            {
                string _logis = string.Empty;
                HttpCookie login = Request.Cookies["Login"]; //获取客户端返回的Cookies中名称为Login的Cookie对象  
                if (login != null)
                {
                    _logis = HttpUtility.UrlDecode(login.Values["UserName"].ToString()); //读取Login中属性值  
                }
                else
                {
                    _logis = string.Empty;
                }
                return _logis;
            }
        }

        public string IsManager
        {
            get
            {
                string _ismanager = string.Empty;
                HttpCookie login = Request.Cookies["Login"]; //获取客户端返回的Cookies中名称为Login的Cookie对象  
                if (login != null)
                {
                    _ismanager = login.Values["IsManager"]; //读取Login中属性值  
                }
                else
                {
                    _ismanager = string.Empty;
                }
                return _ismanager;
            }
        }

        public string UserId
        {
            get
            {
                string _UserId = string.Empty;
                HttpCookie login = Request.Cookies["Login"]; //获取客户端返回的Cookies中名称为Login的Cookie对象  
                if (login != null)
                {
                    _UserId = login.Values["UserId"]; //读取Login中属性值  
                }
                else
                {
                    _UserId = string.Empty;
                }
                return _UserId;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //if (Session["UserId"] == null)
                //{
                if (string.IsNullOrEmpty(UserName))
                {
                    Response.Write("<script>alert('登录失效,请重新登录!'); if (window == top){window.location.href='../Login.aspx';} else{top.location.href='../Login.aspx';}</script>");
                    Response.End();
                    return;
                }
                //Session.Timeout = 1440;
            }
        }
    }
}