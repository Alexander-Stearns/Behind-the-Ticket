let
  Source = Excel.Workbook(File.Contents("C:\Users\stear\Downloads\Behind_the_Ticket_Data.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Venues", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"VenueID", type text}, {"VenueName", type text}, {"City", type text}, {"Region", type text}, {"State", type text}, {"Country", type text}, {"Latitude", type number}, {"Longitude", type number}})
in
  #"Changed column type"