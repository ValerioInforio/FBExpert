object dmFBExpert: TdmFBExpert
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 311
  Width = 304
  object FDCSQLite: TFDConnection
    Params.Strings = (
      'Database=C:\FBExpert\FBExpert.db'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object FDConexao: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 208
    Top = 16
  end
  object FDQDatabases: TFDQuery
    Connection = FDCSQLite
    SQL.Strings = (
      'SELECT * FROM DATABASES')
    Left = 40
    Top = 88
  end
  object DSDatabases: TDataSource
    DataSet = CDSDatabases
    Left = 40
    Top = 248
  end
  object DSPDatabases: TDataSetProvider
    DataSet = FDQDatabases
    Left = 40
    Top = 144
  end
  object CDSDatabases: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPDatabases'
    Left = 40
    Top = 198
  end
end
