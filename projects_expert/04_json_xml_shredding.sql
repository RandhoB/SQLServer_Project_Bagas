-- ====================================================================
-- Project 4: Advanced JSON & XML Shredding
-- Topik: OPENJSON (SQL Server 2016+)
-- ====================================================================

-- 1. SETUP: Data API Mentah
DECLARE @jsonRawData NVARCHAR(MAX) = N'[
    {
        "OrderId": 1001,
        "Customer": {"Name": "Agus", "Phone": "08123"},
        "Items": [
            {"ProductId": 1, "Price": 50, "Qty": 2},
            {"ProductId": 2, "Price": 150, "Qty": 1}
        ]
    },
    {
        "OrderId": 1002,
        "Customer": {"Name": "Budi", "Phone": "08999"},
        "Items": [
            {"ProductId": 3, "Price": 200, "Qty": 5}
        ]
    }
]';

-- 2. SOLUSI: SHREDDING JSON
-- Kita perlu memecah JSON bertingkat (Nested JSON) menjadi bentuk Relasional Rapi

SELECT 
    Orders.OrderId,
    Orders.CustomerName,
    Orders.CustomerPhone,
    Details.ProductId,
    Details.Price,
    Details.Qty,
    (Details.Price * Details.Qty) AS LineTotal
FROM OPENJSON(@jsonRawData)
WITH (
    OrderId INT 'strict $.OrderId',
    CustomerName VARCHAR(50) '$.Customer.Name',
    CustomerPhone VARCHAR(20) '$.Customer.Phone',
    ItemsData NVARCHAR(MAX) '$.Items' AS JSON -- Ambil sub-array sebagai JSON lagi
) AS Orders
-- Menggunakan CROSS APPLY untuk parsing JSON Array di dalam JSON (Nested Array)
CROSS APPLY OPENJSON(Orders.ItemsData)
WITH (
    ProductId INT '$.ProductId',
    Price DECIMAL(18,2) '$.Price',
    Qty INT '$.Qty'
) AS Details;
