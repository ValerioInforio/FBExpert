object dmFBExpert: TdmFBExpert
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 262
  Width = 304
  object FDCSQLite: TFDConnection
    Params.Strings = (
      'Database=C:\FBExpert\FBExpert.db'
      'DriverID=SQLite')
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
  object DataSource1: TDataSource
    Left = 136
    Top = 112
  end
end
