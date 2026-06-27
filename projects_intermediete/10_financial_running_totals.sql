-- ====================================================================
-- Project 10: Financial Running Totals & Moving Averages
-- Topik: Window Functions (SUM OVER, ROWS/RANGE)
-- ====================================================================

-- 1. SETUP
CREATE TABLE DailyTransactions (
    TxDate DATE PRIMARY KEY,
    Revenue DECIMAL(18,2)
);

INSERT INTO DailyTransactions VALUES
('2023-01-01', 100),
('2023-01-02', 150),
('2023-01-03', 200),
('2023-01-04', 50),
('2023-01-05', 300),
('2023-01-06', 400),
('2023-01-07', 100);

-- 2. SOLUSI
SELECT 
    TxDate,
    Revenue,
    
    -- 1. Menghitung Running Total (Kumulatif YTD)
    SUM(Revenue) OVER(
        ORDER BY TxDate 
        ROWS UNBOUNDED PRECEDING
    ) AS RunningTotal,
    
    -- 2. Menghitung 3-Day Moving Average
    -- Rata-rata dari hari ini dan 2 hari sebelumnya
    AVG(Revenue) OVER(
        ORDER BY TxDate 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg_3Days,
    
    -- 3. Mendapatkan pendapatan hari sebelumnya (Previous Day) dengan LAG
    LAG(Revenue, 1, 0) OVER(
        ORDER BY TxDate
    ) AS PrevDayRevenue,
    
    -- 4. Menghitung Pertumbuhan (%) dari hari sebelumnya
    CASE 
        WHEN LAG(Revenue, 1, 0) OVER(ORDER BY TxDate) = 0 THEN 0
        ELSE ((Revenue - LAG(Revenue, 1, 0) OVER(ORDER BY TxDate)) / LAG(Revenue, 1, 0) OVER(ORDER BY TxDate)) * 100
    END AS GrowthPercent
    
FROM DailyTransactions
ORDER BY TxDate;
