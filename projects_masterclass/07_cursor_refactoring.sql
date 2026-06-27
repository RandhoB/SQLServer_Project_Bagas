-- ====================================================================
-- Project 7: Cursor to Set-Based Refactoring
-- Topik: Menghilangkan RBAR (Row-By-Agonizing-Row)
-- ====================================================================

-- 1. SETUP
CREATE TABLE BankAccounts (
    AccID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Balance DECIMAL(18,2),
    Status VARCHAR(20) NULL
);
INSERT INTO BankAccounts VALUES 
(1, 'Agus', -500, NULL), (2, 'Budi', 1000, NULL), (3, 'Cinta', 0, NULL);

-- 2. KODE LEGACY LAMBAT (MENGGUNAKAN CURSOR)
-- Bayangkan tabel ini ada jutaan data. Cursor ini butuh waktu berjam-jam!
DECLARE @Id INT, @Bal DECIMAL(18,2);
DECLARE cur_Accounts CURSOR FOR SELECT AccID, Balance FROM BankAccounts;

OPEN cur_Accounts;
FETCH NEXT FROM cur_Accounts INTO @Id, @Bal;
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @Bal < 0
        UPDATE BankAccounts SET Status = 'Overdrawn' WHERE AccID = @Id;
    ELSE IF @Bal > 0
        UPDATE BankAccounts SET Status = 'Active' WHERE AccID = @Id;
    ELSE
        UPDATE BankAccounts SET Status = 'Dormant' WHERE AccID = @Id;

    FETCH NEXT FROM cur_Accounts INTO @Id, @Bal;
END;
CLOSE cur_Accounts;
DEALLOCATE cur_Accounts;

-- Reset data untuk tes Set-Based
UPDATE BankAccounts SET Status = NULL;

-- 3. KODE MODERN (SET-BASED REFACTORING)
-- Ini memproses seluruh jutaan baris data dalam hitungan DETIK (Bulk Operation)
UPDATE BankAccounts
SET Status = CASE 
    WHEN Balance < 0 THEN 'Overdrawn'
    WHEN Balance > 0 THEN 'Active'
    ELSE 'Dormant'
END;

SELECT * FROM BankAccounts;
