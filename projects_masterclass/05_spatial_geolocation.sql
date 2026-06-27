-- ====================================================================
-- Project 5: Spatial Data & Geolocation
-- Topik: GEOGRAPHY Data Type, Radius Calculation
-- ====================================================================

-- 1. SETUP
CREATE TABLE StoreLocations (
    StoreID INT IDENTITY(1,1) PRIMARY KEY,
    StoreName VARCHAR(100),
    GeoLocation GEOGRAPHY -- Menggunakan tipe data khusus koordinat bumi
);

-- Format Data: POINT(Longitude Latitude) menggunakan format WKT (Well-Known Text)
-- SRID 4326 adalah standar koordinat GPS Bumi (WGS 84)
INSERT INTO StoreLocations (StoreName, GeoLocation) VALUES 
('Toko Jakarta Pusat', geography::STGeomFromText('POINT(106.827153 -6.175110)', 4326)),
('Toko Jakarta Selatan', geography::STGeomFromText('POINT(106.816666 -6.250000)', 4326)),
('Toko Depok', geography::STGeomFromText('POINT(106.8286 -6.3956)', 4326));

-- 2. KASUS: Pelanggan membuka aplikasi Gojek/Grab
-- Lokasi Pelanggan saat ini
DECLARE @CustomerLoc GEOGRAPHY = geography::STGeomFromText('POINT(106.820000 -6.200000)', 4326);

-- 3. SOLUSI 1: Hitung jarak semua toko dari pelanggan (dalam Meter)
SELECT 
    StoreName,
    GeoLocation.STDistance(@CustomerLoc) AS DistanceInMeters,
    GeoLocation.STDistance(@CustomerLoc) / 1000.0 AS DistanceInKm
FROM StoreLocations
ORDER BY DistanceInMeters ASC;

-- 4. SOLUSI 2: Cari toko yang berada dalam radius 10 KM saja
SELECT 
    StoreName,
    GeoLocation.STDistance(@CustomerLoc) / 1000.0 AS DistanceInKm
FROM StoreLocations
WHERE GeoLocation.STDistance(@CustomerLoc) <= 10000 -- 10 Ribu Meter (10 Km)
ORDER BY DistanceInMeters ASC;
