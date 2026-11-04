let
  Source = Excel.Workbook(File.Contents("C:\Users\stear\Downloads\Behind_the_Ticket_Data.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Events", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"EventID", type text}, {"EventName", type text}, {"EventDate", type datetime}, {"VenueID", type text}, {"Artist", type text}, {"Genre", type text}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Changed column type", {{"EventDate", type date}})
in
  #"Changed column type 1"