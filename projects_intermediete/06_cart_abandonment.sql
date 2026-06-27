-- ====================================================================
-- Project 6: E-Commerce Shopping Cart Abandonment
-- Topik: PIVOT, Subqueries, Temp Tables
-- ====================================================================

-- 1. SETUP
CREATE TABLE UserSessions (
    SessionID INT PRIMARY KEY,
    UserID INT,
    SessionDate DATE
);

CREATE TABLE SessionEvents (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    SessionID INT,
    EventName VARCHAR(50) -- 'View', 'AddToCart', 'Checkout', 'Payment'
);

INSERT INTO UserSessions VALUES (1, 101, '2023-11-01'), (2, 102, '2023-11-01'), (3, 103, '2023-11-02');

INSERT INTO SessionEvents (SessionID, EventName) VALUES
(1, 'View'), (1, 'AddToCart'), (1, 'Checkout'), (1, 'Payment'), -- Berhasil beli
(2, 'View'), (2, 'AddToCart'), -- Abandon di Cart
(3, 'View'), (3, 'AddToCart'), (3, 'Checkout'); -- Abandon di Checkout

-- 2. SOLUSI: Menggunakan PIVOT untuk melihat funnel
WITH FunnelData AS (
    SELECT SessionID, EventName, 1 AS EventCount
    FROM SessionEvents
)
SELECT *
INTO #TempFunnel
FROM FunnelData
PIVOT (
    MAX(EventCount)
    FOR EventName IN ([View], [AddToCart], [Checkout], [Payment])
) AS PivotTable;

-- Menghitung total dan drop-off rate
SELECT 
    COUNT([View]) AS TotalViewers,
    COUNT([AddToCart]) AS TotalAddToCart,
    COUNT([Checkout]) AS TotalCheckout,
    COUNT([Payment]) AS TotalPayment,
    -- Drop off dari AddToCart ke Payment (Cart Abandonment Rate)
    CAST(COUNT([AddToCart]) - COUNT([Payment]) AS FLOAT) / NULLIF(COUNT([AddToCart]), 0) * 100 AS CartAbandonmentRatePct
FROM #TempFunnel;

DROP TABLE #TempFunnel;
