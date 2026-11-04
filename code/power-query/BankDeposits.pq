let
  Source = Excel.Workbook(File.Contents("C:\Users\stear\Downloads\Behind_the_Ticket_Data.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "BankDeposits", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"DepositID", type text}, {"SettlementID", type text}, {"BankReference", type text}, {"DepositDate", type datetime}, {"DepositAmount", Currency.Type}, {"RemittanceNote", type text}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Changed column type", {{"DepositDate", type date}})
in
  #"Changed column type 1"