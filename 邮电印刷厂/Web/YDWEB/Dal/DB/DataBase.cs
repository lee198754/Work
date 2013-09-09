using System;
using System.Data;
using System.Configuration;
using System.Web;

using System.Data.SqlClient;

/// <summary>
/// DataBase 的摘要说明
/// </summary>
///
namespace Dal
{
    public class DataBase
    {
        public DataBase()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }
        private SqlConnection con;

        //打开（连接）数据库
        public void Open()
        {
            if (con == null)
            {
                con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
                // con = new SqlConnection("server=.;database=WebVoteDB;uid=sa;pwd=;");
                con.Open();

            }
        }
        //关闭数据库
        public void Close()
        {
            if (con != null)
            {
                con.Close();
                con = null;
            }
        }
        public void SelectStr(string Select, out DataSet dataset)
        {
            Open();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = new SqlCommand(Select, con);
            dataset = new DataSet();
            da.Fill(dataset);
            this.Close();

        }
        public void SelectStr(string Select)
        {
            Open();
            SqlCommand com = new SqlCommand(Select, con);
            com.ExecuteNonQuery();
            this.Close();
        }
        //CreateCommand方法
        private SqlCommand CreateCommand(string ProcName, SqlParameter[] Prams)
        {
            Open();
            SqlCommand cmd = new SqlCommand(ProcName, con);
            cmd.CommandType = CommandType.StoredProcedure;
            if (Prams != null)
            {
                foreach (SqlParameter Parameter in Prams)
                    cmd.Parameters.Add(Parameter);
            }
            // return param
            cmd.Parameters.Add(
                new SqlParameter("ReturnValue", SqlDbType.Int, 4,
                ParameterDirection.ReturnValue, false, 0, 0,
                string.Empty, DataRowVersion.Default, null));
            return cmd;
        }
        //Run stored procedure(SqlDataReader)
        public int RunProc(string ProcName)
        {
            SqlCommand cmd = CreateCommand(ProcName, null);
            cmd.ExecuteNonQuery();
            this.Close();
            return (int)cmd.Parameters["ReturnValue"].Value;
        }
        //Run stored procedure只传参数(SqlDataReader)
        public int RunProc(string ProcName, SqlParameter[] Prams)
        {
            SqlCommand cmd = CreateCommand(ProcName, Prams);
            cmd.ExecuteNonQuery();
            this.Close();
            return (int)cmd.Parameters["ReturnValue"].Value;
        }
        //Run stored procedure输出SqlDataReader(SqlDataReader)
        public void RunProc(string ProcName, out SqlDataReader datareader)
        {
            SqlCommand cmd = CreateCommand(ProcName, null);
            datareader = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

        }
        //Run stored procedure输出SqlDataReader(有传参数)(SqlDataReader)
        public void RunProc(string ProcName, SqlParameter[] Prams, out SqlDataReader datareader)
        {
            SqlCommand cmd = CreateCommand(ProcName, Prams);
            datareader = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

        }
        //Run stored procedure输出DataSet(DataSet)
        public void RunProc(string ProcName, out DataSet dataset)
        {
            SqlCommand cmd = CreateCommand(ProcName, null);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            dataset = new DataSet();
            da.Fill(dataset);
            this.Close();
        }
        //Run stored procedure输出DataSet(有传参数)(DataSet)
        public void RunProc(string ProcName, SqlParameter[] Prams, out DataSet dataset)
        {
            SqlCommand cmd = CreateCommand(ProcName, Prams);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            dataset = new DataSet();
            da.Fill(dataset);
            this.Close();
        }
        //传参方法
        public SqlParameter MakeParam(string ParamName, SqlDbType DbType, Int32 Size, ParameterDirection Direction, object Value)
        {
            SqlParameter Param;
            if (Size > 0)

                Param = new SqlParameter(ParamName, DbType, Size);

            else

                Param = new SqlParameter(ParamName, DbType);

            Param.Direction = Direction;
            if (!(Direction == ParameterDirection.Output && Value == null))
                Param.Value = Value;
            return Param;

        }
        //传出参数
        public SqlParameter MakeInParam(string ParamName, SqlDbType DbType, Int32 Size, object Value)
        {
            return MakeParam(ParamName, DbType, Size, ParameterDirection.Input, Value);
        }
        //返回参数
        public SqlParameter MakeOutParam(string ParamName, SqlDbType DbType, Int32 Size)
        {
            return MakeParam(ParamName, DbType, Size, ParameterDirection.Output, null);
        }
    }
}
