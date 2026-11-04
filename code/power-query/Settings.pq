let
  Source = Excel.Workbook(File.Contents("C:\Users\stear\Downloads\Behind_the_Ticket_Data.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Settings", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"AsOfDate", type datetime}, {"Currency", type text}, {"DataType", type text}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Changed column type", {{"AsOfDate", type date}})
in
  #"Changed column type 1"