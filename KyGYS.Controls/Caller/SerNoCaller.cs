using KyGYS.Controls.Controller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ultra.CoreCaller;

namespace KyGYS.Controls.Caller
{
    public partial class SerNoCaller
    {
        static SerNoCaller()
        {
            Ultra.Surface.Lanuch.Lanucher.SetConnectionStrng(SQLCONN.Conn);
            var che = new Ultra.Cache.CacheBase();
            che.Put<bool>("Ultra.SYS.Core.BSMode", false);
            Ultra.Common.Util.SetCache(che);
        }
        //CtlUserController
        protected static EFCaller<UltraDbEntity.T_ERP_User> _Calr_User = null;
        public static EFCaller<UltraDbEntity.T_ERP_User> Calr_User
        {
            get
            {
                
                    _Calr_User = _Calr_User ??
                   new EFCaller<UltraDbEntity.T_ERP_User>(new CtlUserController());
                    return _Calr_User;
            }
        }


        //CtlV_ERP_NPrintItemController
        protected static EFCaller<UltraDbEntity.V_ERP_NPrintItem> _Calr_V_ERP_NPrintItem = null;
        public static EFCaller<UltraDbEntity.V_ERP_NPrintItem> Calr_V_ERP_NPrintItem
        {
            get
            {
                return
                    _Calr_V_ERP_NPrintItem = _Calr_V_ERP_NPrintItem ??
                   new EFCaller<UltraDbEntity.V_ERP_NPrintItem>(new CtlV_ERP_NPrintItemController());
            }
        }

        //CtlV_ERP_NPrintBatchController
        protected static EFCaller<UltraDbEntity.V_ERP_NPrintBatch> _Calr_V_ERP_NPrintBatch = null;
        public static EFCaller<UltraDbEntity.V_ERP_NPrintBatch> Calr_V_ERP_NPrintBatch
        {
            get
            {
                return
                    _Calr_V_ERP_NPrintBatch = _Calr_V_ERP_NPrintBatch ??
                   new EFCaller<UltraDbEntity.V_ERP_NPrintBatch>(new CtlV_ERP_NPrintBatchController());
            }
        }

        //CtlSuppBatchController
        protected static EFCaller<UltraDbEntity.T_ERP_SuppBatch> _Calr_SuppBatch = null;
        public static EFCaller<UltraDbEntity.T_ERP_SuppBatch> Calr_SuppBatch
        {
            get
            {
                return
                    _Calr_SuppBatch = _Calr_SuppBatch ??
                   new EFCaller<UltraDbEntity.T_ERP_SuppBatch>(new CtlSuppBatchController());
            }
        }




        //CtlBatchOrderController
        protected static EFCaller<UltraDbEntity.T_ERP_BatchOrder> _Calr_BatchOrder = null;
        public static EFCaller<UltraDbEntity.T_ERP_BatchOrder> Calr_BatchOrder
        {
            get
            {
                return
                    _Calr_BatchOrder = _Calr_BatchOrder ??
                   new EFCaller<UltraDbEntity.T_ERP_BatchOrder>(new CtlBatchOrderController());
            }
        }


        //CtlMapUserController
        protected static EFCaller<UltraDbEntity.T_ERP_MapUser> _Calr_MapUser = null;
        public static EFCaller<UltraDbEntity.T_ERP_MapUser> Calr_MapUser
        {
            get
            {
                return
                    _Calr_MapUser = _Calr_MapUser ??
                   new EFCaller<UltraDbEntity.T_ERP_MapUser>(new CtlMapUserController());
            }
        }


        //CtlSuppOrderController
        protected static EFCaller<UltraDbEntity.T_ERP_SuppOrder> _Calr_SuppOrder = null;
        public static EFCaller<UltraDbEntity.T_ERP_SuppOrder> Calr_SuppOrder
        {
            get
            {
                return
                    _Calr_SuppOrder = _Calr_SuppOrder ??
                   new EFCaller<UltraDbEntity.T_ERP_SuppOrder>(new CtlSuppOrderController());
            }
        }
    }
}
