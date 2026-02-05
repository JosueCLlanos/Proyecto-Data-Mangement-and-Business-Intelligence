

CREATE PROCEDURE [dbo].[GetShippersChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN

  SELECT 
  e.ShipperID,
  e.CompanyName,
  e.Phone
  from dbo.Shippers e
  WHERE 
  (e.[rowversion] > CONVERT(ROWVERSION,@startRow) AND e.[rowversion] <= CONVERT(ROWVERSION,@endRow))
END
GO


