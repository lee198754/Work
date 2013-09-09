using System;
using System.Collections.Generic;
using System.Text;

namespace Model
{
    [Serializable]
    public class M_Log_WebLoginLog
    {
        public M_Log_WebLoginLog()
        { }
        #region Model
        private int _f_iid;
        private int? _f_iuserid;
        private string _f_susername;
        private DateTime? _f_ddate;
        private string _f_sloginip;
        /// <summary>
        /// 
        /// </summary>
        public int F_iID
        {
            set { _f_iid = value; }
            get { return _f_iid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? F_iUserID
        {
            set { _f_iuserid = value; }
            get { return _f_iuserid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string F_sUserName
        {
            set { _f_susername = value; }
            get { return _f_susername; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? F_dDate
        {
            set { _f_ddate = value; }
            get { return _f_ddate; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string F_sLoginIP
        {
            set { _f_sloginip = value; }
            get { return _f_sloginip; }
        }
        #endregion Model
    }
}
