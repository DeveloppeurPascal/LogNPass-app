object dmOldSQLiteDB: TdmOldSQLiteDB
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    EngineLinkage = slFDEStatic
    Left = 424
    Top = 208
  end
  object ListeTable: TFDQuery
    Connection = LognpassConnection
    SQL.Strings = (
      
        'SELECT * FROM liste WHERE supprime="N" ORDER BY libelle,dateheur' +
        'e_creation')
    Left = 151
    Top = 327
  end
  object LognpassConnection: TFDConnection
    Params.Strings = (
      
        'Database=Z:\OlfSoftware\sites_web\lognpass\dev\app\lognpass_dev.' +
        'db'
      'ForeignKeys=Off'
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = LognpassConnectionAfterConnect
    Left = 433
    Top = 323
  end
end
