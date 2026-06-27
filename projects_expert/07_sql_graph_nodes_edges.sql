-- ====================================================================
-- Project 7: Graph Database Capabilities
-- Topik: SQL Graph (NODE & EDGE) - SQL Server 2017+
-- ====================================================================

-- 1. SETUP: Membuat arsitektur Graph (Orang Berteman dengan Orang)

-- A. Membuat tabel NODE
CREATE TABLE Person (
    ID INT PRIMARY KEY,
    Name VARCHAR(100)
) AS NODE;

-- B. Membuat tabel EDGE (Relasi/Hubungan)
CREATE TABLE isFriendOf AS EDGE;

-- 2. DML: Insert Data
INSERT INTO Person (ID, Name) VALUES (1, 'Agus'), (2, 'Bagas'), (3, 'Cinta'), (4, 'Deni');

-- Mendapatkan Node ID internal ($node_id) untuk insert ke EDGE
DECLARE @AgusId NVARCHAR(MAX) = (SELECT $node_id FROM Person WHERE Name = 'Agus');
DECLARE @BagasId NVARCHAR(MAX) = (SELECT $node_id FROM Person WHERE Name = 'Bagas');
DECLARE @CintaId NVARCHAR(MAX) = (SELECT $node_id FROM Person WHERE Name = 'Cinta');
DECLARE @DeniId NVARCHAR(MAX) = (SELECT $node_id FROM Person WHERE Name = 'Deni');

-- Memasukkan relasi (A berteman dengan B)
INSERT INTO isFriendOf ($from_id, $to_id) VALUES 
(@AgusId, @BagasId),
(@AgusId, @CintaId),
(@BagasId, @DeniId);

-- 3. QUERY: Menggunakan fungsi MATCH() 
-- Menemukan "Teman dari temannya Agus" (Mutual Friends)
-- Agus -> Berteman -> Teman1 -> Berteman -> Teman2

SELECT 
    Person1.Name AS StartPerson,
    Person2.Name AS Friend,
    Person3.Name AS FriendOfFriend
FROM 
    Person Person1, 
    isFriendOf FriendRel1, 
    Person Person2, 
    isFriendOf FriendRel2, 
    Person Person3
WHERE 
    MATCH(Person1-(FriendRel1)->Person2-(FriendRel2)->Person3)
    AND Person1.Name = 'Agus';
