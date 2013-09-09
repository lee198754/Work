using System;
using System.Collections.Generic;
using System.Text;

namespace Model
{
    [Serializable]
    public class M_Sys_UserInfo
    {
        public M_Sys_UserInfo()
        { }
        #region Model
        private int _f_iid;
        private string _f_sname;
        private string _f_spwd;
        private int? _f_itype;
        private string _f_icode;
        private int? _f_isign;
        private string _f_stext;
        private string _f_stext1;
        private int? _f_stext2;
        private string _f_susername;
        private string _f_srealname;
        private string _f_spermissions;
        /// <summary>
        /// 
        /// </summary>
        public string F_sRealName
        {
            set { _f_srealname = value; }
            get { return _f_srealname; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string F_sPermissions
        {
            set { _f_spermissions = value; }
            get { return _f_spermissions; }
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
        public int F_iID
        {
            set { _f_iid = value; }
            get { return _f_iid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string F_sName
        {
            set { _f_sname = value; }
            get { return _f_sname; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string F_sPwd
        {
            set { _f_spwd = value; }
            get { return _f_spwd; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? F_iType
        {
            set { _f_itype = value; }
            get { return _f_itype; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string F_iCode
        {
            set { _f_icode = value; }
            get { return _f_icode; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? F_iSign
        {
            set { _f_isign = value; }
            get { return _f_isign; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string F_sText
        {
            set { _f_stext = value; }
            get { return _f_stext; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string F_sText1
        {
            set { _f_stext1 = value; }
            get { return _f_stext1; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int? F_sText2
        {
            set { _f_stext2 = value; }
            get { return _f_stext2; }
        }
        #endregion Model
    }
}
