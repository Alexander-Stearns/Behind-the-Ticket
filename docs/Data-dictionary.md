# Model fields

Extracted from the supplied PBIT. Automatic date tables omitted.


## Venues

| Field | Type |
|---|---|
| VenueID | string |
| VenueName | string |
| City | string |
| Region | string |
| State | string |
| Country | string |
| Latitude | double |
| Longitude | double |

## Events

| Field | Type |
|---|---|
| EventID | string |
| EventName | string |
| EventDate | dateTime |
| VenueID | string |
| Artist | string |
| Genre | string |

## Settlements

| Field | Type |
|---|---|
| SettlementID | string |
| EventID | string |
| SalesChannel | string |
| ExpectedBankReference | string |
| SettlementDueDate | dateTime |
| TicketsSold | int64 |
| GrossSales | decimal |
| Refunds | decimal |
| ProcessingFees | decimal |
| ExpectedSettlement | decimal |
| ReceivedCash | decimal |
| OutstandingCash | decimal |
| DaysOverdue | int64 |
| ReferenceMismatchCount | int64 |
| SettlementStatus | string |
| Next Action | string |

## BankDeposits

| Field | Type |
|---|---|
| DepositID | string |
| SettlementID | string |
| BankReference | string |
| DepositDate | dateTime |
| DepositAmount | decimal |
| RemittanceNote | string |

## Settings

| Field | Type |
|---|---|
| AsOfDate | dateTime |
| Currency | string |
| DataType | string |

## Cash Bridge Steps

| Field | Type |
|---|---|
| Step | string |
| Sort Order | int64 |