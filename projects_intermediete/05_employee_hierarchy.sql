-- ====================================================================
-- Project 5: Employee Hierarchy & Reporting Tree
-- Topik: Recursive CTEs
-- ====================================================================

-- 1. SETUP
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Title VARCHAR(100),
    ManagerID INT NULL -- Null berarti dia adalah pimpinan tertinggi (CEO)
);

INSERT INTO Employees VALUES
(1, 'Pak Direktur', 'CEO', NULL),
(2, 'Bu VP Sales', 'VP Sales', 1),
(3, 'Pak VP IT', 'VP IT', 1),
(4, 'Andi', 'Sales Manager', 2),
(5, 'Budi', 'Sales Staff', 4),
(6, 'Citra', 'IT Manager', 3),
(7, 'Dewi', 'Programmer', 6),
(8, 'Eka', 'Programmer', 6);

-- 2. SOLUSI: Recursive CTE
-- Kita ingin melihat struktur organisasi beserta level kedalamannya (Hierarchy Level)

WITH OrgChart AS (
    -- Anchor Member (Titik awal: CEO atau level teratas)
    SELECT 
        EmpID, EmpName, Title, ManagerID, 
        0 AS HierarchyLevel,
        CAST(EmpName AS VARCHAR(MAX)) AS Path
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Recursive Member (Bergabung dengan dirinya sendiri untuk mencari bawahan)
    SELECT 
        e.EmpID, e.EmpName, e.Title, e.ManagerID,
        oc.HierarchyLevel + 1,
        oc.Path + ' -> ' + CAST(e.EmpName AS VARCHAR(MAX))
    FROM Employees e
    INNER JOIN OrgChart oc ON e.ManagerID = oc.EmpID
)
SELECT 
    EmpID, 
    REPLICATE('  ', HierarchyLevel) + EmpName AS IndentedName, 
    Title, 
    HierarchyLevel,
    Path
FROM OrgChart
ORDER BY Path;
