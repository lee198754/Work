object DM_DataBase: TDM_DataBase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 637
  Top = 158
  Height = 433
  Width = 653
  object ADO_DataRec: TADOQuery
    Connection = Con_YDPrint
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      'select * from BI_CustomOrderDetails where 1=2')
    Left = 131
    Top = 8
  end
  object Con_YDPrint: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=YDPrint;Data Source=.;Use Procedure for' +
      ' Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=L' +
      'EE-PC;Use Encryption for Data=False;Tag with column collation wh' +
      'en possible=False;'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 488
    Top = 8
  end
  object ds_show: TDataSource
    AutoEdit = False
    DataSet = mte_DataRec
    Left = 32
    Top = 8
  end
  object ADO_Print: TADOQuery
    Connection = Con_YDPrint
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      'select * from DO_Invoice a,DO_InvoiceDetails b '
      'where a.F_iID=b.F_iInvoiceID and a.F_iID =1005')
    Left = 424
    Top = 8
  end
  object ADO_Temp: TADOQuery
    Connection = Con_YDPrint
    CursorType = ctStatic
    Parameters = <>
    Left = 131
    Top = 55
  end
  object IdIcmpClient1: TIdIcmpClient
    ReceiveTimeout = 500
    Left = 512
    Top = 225
  end
  object mte_DataRec: TMemTableEh
    CachedUpdates = True
    FetchAllOnOpen = True
    Params = <>
    DataDriver = dsd_DataRec
    Left = 288
    Top = 8
  end
  object dsd_DataRec: TDataSetDriverEh
    ProviderDataSet = ADO_DataRec
    Left = 208
    Top = 8
  end
  object ds_Temp: TDataSource
    DataSet = ADO_Temp
    Left = 32
    Top = 55
  end
  object ADO_MOD: TADOQuery
    Connection = Con_YDPrint
    CursorType = ctStatic
    Parameters = <>
    Left = 360
    Top = 8
  end
  object ADO_FHCX: TADOQuery
    Connection = Con_YDPrint
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'p_fhcx')
    Left = 131
    Top = 105
  end
  object ds_FHCX: TDataSource
    DataSet = ADO_FHCX
    Left = 32
    Top = 105
  end
  object dsd_FHCX: TDataSetDriverEh
    ProviderDataSet = ADO_FHCX
    Left = 208
    Top = 105
  end
  object mte_FHCX: TMemTableEh
    FetchAllOnOpen = True
    Params = <>
    DataDriver = dsd_FHCX
    Left = 280
    Top = 105
  end
  object ADO_XQXX: TADOQuery
    Connection = Con_YDPrint
    CursorType = ctStatic
    AfterEdit = ADO_XQXXAfterEdit
    Parameters = <>
    SQL.Strings = (
      'p_fhcx')
    Left = 131
    Top = 155
  end
  object ds_XQXX: TDataSource
    DataSet = ADO_XQXX
    Left = 32
    Top = 155
  end
  object dsd_xqxx: TDataSetDriverEh
    Left = 208
    Top = 155
  end
  object mte_xqxx: TMemTableEh
    FetchAllOnOpen = True
    Params = <>
    DataDriver = dsd_xqxx
    Left = 280
    Top = 155
  end
  object ADO_FHFK: TADOQuery
    Connection = Con_YDPrint
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      'Exec p_fhfkcx '#39#39','#39#39','#39#39','#39#39',1,50')
    Left = 131
    Top = 203
  end
  object ds_FHFK: TDataSource
    DataSet = ADO_FHFK
    Left = 32
    Top = 203
  end
  object ADO_XHQD: TADOQuery
    Connection = Con_YDPrint
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      'p_xhqd '#39'2011.09.01'#39','#39'2013.01.20'#39',1')
    Left = 131
    Top = 251
  end
  object ds_XHQD: TDataSource
    DataSet = ADO_XHQD
    Left = 32
    Top = 251
  end
  object RMXLSExport1: TRMXLSExport
    ShowAfterExport = True
    ExportPrecision = 1
    PagesOfSheet = 1
    ExportImages = True
    ExportFrames = True
    ExportImageFormat = ifBMP
    JPEGQuality = 0
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    CompressFile = False
    Left = 376
    Top = 224
  end
  object RMJPEGExport1: TRMJPEGExport
    ScaleX = 1.000000000000000000
    ScaleY = 1.000000000000000000
    Left = 424
    Top = 232
  end
  object gr_dc: TGridRow_X
    Left = 471
    Top = 224
  end
  object ADO_DataArchiving: TADOQuery
    Connection = Con_YDPrint
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      'p_xhqd '#39'2011.09.01'#39','#39'2013.01.20'#39',1')
    Left = 131
    Top = 299
  end
  object ds_DataArchiving: TDataSource
    DataSet = ADO_DataArchiving
    Left = 32
    Top = 299
  end
  object Con_History: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=YDPrint_History;Data Source=.;Use Proce' +
      'dure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstat' +
      'ion ID=LEE-PC;Use Encryption for Data=False;Tag with column coll' +
      'ation when possible=False;'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 488
    Top = 56
  end
end
