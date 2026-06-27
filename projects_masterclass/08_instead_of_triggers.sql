-- ====================================================================
-- Project 8: INSTEAD OF Triggers
-- Topik: Memperbolehkan UPDATE/INSERT pada Complex View
-- ====================================================================

-- 1. SETUP: 2 Tabel
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    StaffName VARCHAR(50),
    DeptID INT FOREIGN KEY REFERENCES Departments(DeptID)
);
INSERT INTO Departments VALUES (1, 'IT'), (2, 'HR');
INSERT INTO Staff VALUES (101, 'Agus', 1);

-- 2. SETUP: Membuat View yang menggabungkan (JOIN) 2 tabel
GO
CREATE VIEW vw_StaffInfo
AS
SELECT 
    s.StaffID, s.StaffName, 
    d.DeptID, d.DeptName
FROM Staff s
JOIN Departments d ON s.DeptID = d.DeptID;
GO

-- 3. MASALAH: View yang terhubung dengan JOIN tidak bisa di-insert begitu saja
-- INSERT INTO vw_StaffInfo VALUES (102, 'Budi', 2, 'HR'); -- INI AKAN ERROR

-- 4. SOLUSI: INSTEAD OF TRIGGER
-- Kita cegat (intercept) percobaan INSERT ke view, lalu kita manipulasi agar masuk ke tabel aslinya
GO
CREATE TRIGGER trg_InsteadOfInsert_vw_StaffInfo
ON vw_StaffInfo
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Insert ke tabel Staff saja, karena Department diasumsikan sudah ada (berdasarkan DeptID)
    INSERT INTO Staff (StaffID, StaffName, DeptID)
    SELECT StaffID, StaffName, DeptID
    FROM inserted; -- 'inserted' adalah tabel virtual berisi data yang dicoba di-insert
END;
GO

-- 5. TEST SOLUSI
-- Sekarang INSERT ini BERHASIL! (Trigger mencegatnya dan mengarahkannya ke tabel Staff)
INSERT INTO vw_StaffInfo (StaffID, StaffName, DeptID) VALUES (102, 'Budi', 2);

SELECT * FROM vw_StaffInfo;
