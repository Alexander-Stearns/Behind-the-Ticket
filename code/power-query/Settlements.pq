let
  Source = Excel.Workbook(File.Contents("C:\Users\stear\Downloads\Behind_the_Ticket_Data.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Settlements", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"SettlementID", type text}, {"EventID", type text}, {"SalesChannel", type text}, {"ExpectedBankReference", type text}, {"SettlementDueDate", type datetime}, {"TicketsSold", Int64.Type}, {"GrossSales", Currency.Type}, {"Refunds", Currency.Type}, {"ProcessingFees", Currency.Type}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Changed column type", {{"SettlementDueDate", type date}}),
  #"Added custom" = Table.AddColumn(#"Changed column type 1", "ExpectedSettlement", each [GrossSales] - [Refunds] - [ProcessingFees]),
  #"Changed column type 2" = Table.TransformColumnTypes(#"Added custom", {{"ExpectedSettlement", Currency.Type}}),
  #"Merged queries" = Table.NestedJoin(#"Changed column type 2", {"SettlementID"}, DepositSummary, {"SettlementID"}, "DepositSummary", JoinKind.LeftOuter),
  #"Expanded DepositSummary" = Table.ExpandTableColumn(#"Merged queries", "DepositSummary", {"#(tab)ReceivedCash"}, {"#(tab)ReceivedCash"}),
  #"Replaced value" = Table.ReplaceValue(#"Expanded DepositSummary", null, 0, Replacer.ReplaceValue, {"#(tab)ReceivedCash"}),
  #"Changed column type 3" = Table.TransformColumnTypes(#"Replaced value", {{"#(tab)ReceivedCash", Currency.Type}}),
  #"Renamed columns" = Table.RenameColumns(#"Changed column type 3", {{"#(tab)ReceivedCash", "ReceivedCash"}}),
  #"Added custom 1" = Table.TransformColumnTypes(Table.AddColumn(#"Renamed columns", "OutstandingCash", each [ExpectedSettlement] - [ReceivedCash]), {{"OutstandingCash", Currency.Type}}),
  #"Added custom 2" = Table.TransformColumnTypes(Table.AddColumn(#"Added custom 1", "DaysOverdue", each if [OutstandingCash] > 0
    and [SettlementDueDate] < Settings{0}[AsOfDate]
then Duration.Days(Settings{0}[AsOfDate] - [SettlementDueDate])
else 0), {{"DaysOverdue", Int64.Type}}),
  #"Added custom 3" = Table.TransformColumnTypes(Table.AddColumn(#"Added custom 2", "ReferenceMismatchCount", each let
    CurrentID = [SettlementID],
    ExpectedRef = [ExpectedBankReference]
in
    Table.RowCount(
        Table.SelectRows(
            BankDeposits,
            each [SettlementID] = CurrentID
                and [BankReference] <> ExpectedRef
        )
    )), {{"ReferenceMismatchCount", Int64.Type}}),
  #"Added custom 4" = Table.TransformColumnTypes(Table.AddColumn(#"Added custom 3", "SettlementStatus", each if [ReferenceMismatchCount] > 0 then "Reference mismatch"
else if [OutstandingCash] > 0 and [DaysOverdue] > 0 then "Overdue"
else if [OutstandingCash] > 0 then "Processing"
else "Reconciled"), {{"SettlementStatus", type text}})
in
  #"Added custom 4"