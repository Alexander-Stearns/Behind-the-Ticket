let
  Source = BankDeposits,
  #"Grouped rows" = Table.Group(Source, {"SettlementID"}, {{"#(tab)ReceivedCash", each List.Sum([DepositAmount]), type nullable number}}),
  #"Changed column type" = Table.TransformColumnTypes(#"Grouped rows", {{"#(tab)ReceivedCash", Currency.Type}})
in
  #"Changed column type"