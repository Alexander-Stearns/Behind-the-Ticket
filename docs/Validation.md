# Validation

Source workbook recalculated independently using decimal arithmetic. Report interactions were checked manually in Power BI by the author and through supplied screenshots; the PBIX was not executed in this packaging environment.

| Metric | Verified source result |
|---|---:|
| Expected | 3,105,051.77 |
| Received | 2,827,431.34 |
| Outstanding | 277,620.43 |
| Overdue | 27,183.71 |
| Exceptions | 2.00 |

Status counts: {'Reconciled': 94, 'Overdue': 3, 'Reference mismatch': 2, 'Processing': 9}.

108 settlement rows; 124 deposit rows; 9 settlements without deposits; 25 settlements with multiple deposits.

## Cases checked

- E028-1: expected $30,630.79, received $18,378.47, outstanding/overdue $12,252.32; six days overdue.
- E027-2: received $12,708.58 in full; expected reference EL-E027-2, actual EL-E027-9; one reference exception and no cash shortfall.
- E035-2: expected/outstanding $41,937.77, received $0, due November 5; Processing at November 3. No deposit rows, action to monitor payment.
- E009-1: $16,633.19 + $11,088.79 = $27,721.98; reconciled, no action required.
- Event drillthrough, back navigation, geography selection, dynamic next action, zero-value conditional formatting and event tooltip changes were manually checked during development.

Screenshots record tested states and may include Power BI editing handles. Source checks do not substitute for opening and refreshing the report in Power BI Desktop.
