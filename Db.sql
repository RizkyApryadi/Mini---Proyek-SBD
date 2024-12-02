/*
	Kelompok 2 topik Sistem Pengelolaan Inventaris Gudang
*/


-- tabel Barang
CREATE TABLE Barang (
    Barang_id SERIAL PRIMARY KEY,
    Nama_barang VARCHAR(255) NOT NULL,
    Status VARCHAR(50),
    Tanggal_stok_terakhir DATE,
    Kategori VARCHAR(50),
    Stok INT NOT NULL,
    Harga_beli NUMERIC(15, 2),
    Harga_jual NUMERIC(15, 2),
    Deskripsi TEXT
);

-- tabel Peringatan Stok
CREATE TABLE Peringatan_Stok (
    Peringatan_id SERIAL PRIMARY KEY,
    Barang_id INT NOT NULL,
    Batas_stok_minimum INT NOT NULL,
    Tanggal_peringatan DATE,
    Status_peringatan VARCHAR(50),
    CONSTRAINT fk_barang_peringatan FOREIGN KEY (Barang_id) REFERENCES Barang(Barang_id) ON DELETE CASCADE
);

-- tabel Data Harga
CREATE TABLE Data_Harga (
    Harga_id SERIAL PRIMARY KEY,
    Barang_id INT NOT NULL,
    Harga_pasar NUMERIC(15, 2),
    Tanggal_pengambilan DATE,
    CONSTRAINT fk_barang_harga FOREIGN KEY (Barang_id) REFERENCES Barang(Barang_id) ON DELETE CASCADE
);

--  tabel Gudang
CREATE TABLE Gudang (
    Gudang_id SERIAL PRIMARY KEY,
    Nama_gudang VARCHAR(255) NOT NULL,
    Lokasi TEXT NOT NULL,
    Kapasitas_minimum INT,
    Kapasitas_maksimum INT
);

-- tabel Pengguna (User)
CREATE TABLE Pengguna (
    User_id SERIAL PRIMARY KEY,
    Nama_pengguna VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(50)
);

-- tabel Transaksi Stok
CREATE TABLE Transaksi_Stok (
    Transaksi_id SERIAL PRIMARY KEY,
    Barang_id INT NOT NULL,
    User_id INT NOT NULL,
    Jenis_transaksi VARCHAR(50), 
    Stok_awal INT NOT NULL,
    Stok_akhir INT NOT NULL,
    Jumlah_barang INT NOT NULL,
    Tanggal_transaksi DATE,
    Status_validasi VARCHAR(50),
    CONSTRAINT fk_barang_transaksi FOREIGN KEY (Barang_id) REFERENCES Barang(Barang_id) ON DELETE CASCADE,
    CONSTRAINT fk_user_transaksi FOREIGN KEY (User_id) REFERENCES Pengguna(User_id) ON DELETE CASCADE
);

-- tabel Relasi Gudang dan Barang
CREATE TABLE Menyimpan (
    Barang_id INT NOT NULL,
    Gudang_id INT NOT NULL,
    PRIMARY KEY (Barang_id, Gudang_id),
    CONSTRAINT fk_barang_menyimpan FOREIGN KEY (Barang_id) REFERENCES Barang(Barang_id) ON DELETE CASCADE,
    CONSTRAINT fk_gudang_menyimpan FOREIGN KEY (Gudang_id) REFERENCES Gudang(Gudang_id) ON DELETE CASCADE
);



-- Menambah data ke tabel Barang
INSERT INTO Barang (Nama_barang, Status, Tanggal_stok_terakhir, Kategori, Stok, Harga_beli, Harga_jual, Deskripsi)
VALUES 
('Laptop Asus', 'Tersedia', '2024-11-01', 'Elektronik', 50, 7500000, 10000000, 'Laptop untuk pekerjaan dan gaming'),
('Meja Kayu', 'Tersedia', '2024-11-10', 'Furnitur', 20, 500000, 750000, 'Meja kayu jati ukuran besar');

-- Menambah data ke tabel Gudang
INSERT INTO Gudang (Nama_gudang, Lokasi, Kapasitas_minimum, Kapasitas_maksimum)
VALUES 
('Gudang Utama', 'Jakarta', 100, 1000),
('Gudang Cabang', 'Surabaya', 50, 500);

-- Menambah data ke tabel Pengguna
INSERT INTO Pengguna (Nama_pengguna, Email, Password, Role)
VALUES 
('Admin', 'admin@example.com', 'password123', 'Administrator'),
('User1', 'user1@example.com', 'password123', 'User');

-- Menambah data ke tabel Transaksi Stok
INSERT INTO Barang (Nama_barang, Status, Tanggal_stok_terakhir, Kategori, Stok, Harga_beli, Harga_jual, Deskripsi)
VALUES 
('Laptop Asus', 'Tersedia', '2024-11-01', 'Elektronik', 50, 7500000, 10000000, 'Laptop untuk pekerjaan dan gaming'),
('Meja Kayu', 'Tersedia', '2024-11-10', 'Furnitur', 20, 500000, 750000, 'Meja kayu jati ukuran besar');



-- Update Stok Barang
UPDATE Barang SET Stok = Stok + 50 WHERE Barang_id = 1;

-- Update info gudang
UPDATE Gudang SET Lokasi = 'Bandung' WHERE Gudang_id = 2;

-- hapus data pengguna
DELETE FROM Pengguna WHERE Email = 'user1@example.com';

-- Menghapus data barang
DELETE FROM Barang WHERE Barang_id = 2;

-- Melihat semua data barang
SELECT * FROM Barang;

-- Melihat semua data pengguna
SELECT * FROM Pengguna;

-- Melihat transaksi stok yang dilakukan oleh pengguna tertentu
SELECT ts.*, p.Nama_pengguna 
FROM Transaksi_Stok ts
JOIN Pengguna p ON ts.User_id = p.User_id
WHERE p.Nama_pengguna = 'Admin';

-- Melihat barang yang disimpan di gudang tertentu
SELECT b.Nama_barang, g.Nama_gudang FROM Menyimpan m JOIN Barang b ON m.Barang_id = b.Barang_id
JOIN Gudang g ON m.Gudang_id = g.Gudang_id WHERE g.Nama_gudang = 'Gudang Utama';


select * from barang

DELETE FROM Menyimpan;
DELETE FROM Transaksi_Stok;
DELETE FROM Data_Harga;
DELETE FROM Peringatan_Stok;
DELETE FROM Barang;
DELETE FROM Pengguna;
DELETE FROM Gudang;


SELECT * FROM Barang;
SELECT * FROM Pengguna;
SELECT * FROM Gudang;

--1. VIEW
-- a. view dimana kita dapat melihat barang yang disimpan di Gudang
-- membuat fungsi View Barang yang disimpan di Gudang
CREATE OR REPLACE VIEW View_Barang_Gudang AS
SELECT 
    b.Barang_id,
    b.Nama_barang,
    b.Kategori,
    b.Stok,
    b.Harga_jual,
    g.Nama_gudang,
    g.Lokasi
FROM Barang b
JOIN Menyimpan m ON b.Barang_id = m.Barang_id
JOIN Gudang g ON m.Gudang_id = g.Gudang_id;

-- pemanggilan fungsi
select * from View_Barang_Gudang;

-- b. view dimana kita dapat melihat data transaksi stok
-- membuat fungsi view transaksi stok
CREATE OR REPLACE VIEW View_Transaksi_Stok AS
SELECT 
    ts.Transaksi_id,
    ts.Barang_id,
    b.Nama_barang,
    ts.User_id,
    p.Nama_pengguna,
    ts.Jenis_transaksi,
    ts.Stok_awal,
    ts.Stok_akhir,
    ts.Jumlah_barang,
    ts.Tanggal_transaksi,
    ts.Status_validasi
FROM Transaksi_Stok ts
JOIN Barang b ON ts.Barang_id = b.Barang_id
JOIN Pengguna p ON ts.User_id = p.User_id;

-- pemanggilan fungsi
select * from View_Transaksi_Stok;

-- 2. STORED PROCEDURE
-- a. stored procedure untuk mengupdate stok barang
CREATE OR REPLACE PROCEDURE Update_Stok_Barang(
    IN p_barang_id INT,
    IN p_user_id INT,
    IN p_jenis_transaksi VARCHAR(50),
    IN p_jumlah_barang INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    stok_awal INT;
BEGIN
    -- Ambil stok awal barang
    SELECT Stok INTO stok_awal FROM Barang WHERE Barang_id = p_barang_id;

    -- Update stok berdasarkan jenis transaksi
    IF p_jenis_transaksi = 'Masuk' THEN
        UPDATE Barang SET Stok = Stok + p_jumlah_barang WHERE Barang_id = p_barang_id;
    ELSIF p_jenis_transaksi = 'Keluar' THEN
        UPDATE Barang SET Stok = Stok - p_jumlah_barang WHERE Barang_id = p_barang_id;
    END IF;

    -- Catat transaksi stok
    INSERT INTO Transaksi_Stok (
        Barang_id, User_id, Jenis_transaksi, Stok_awal, Stok_akhir, Jumlah_barang, Tanggal_transaksi, Status_validasi
    ) VALUES (
        p_barang_id, p_user_id, p_jenis_transaksi, stok_awal, stok_awal + CASE
            WHEN p_jenis_transaksi = 'Masuk' THEN p_jumlah_barang
            ELSE -p_jumlah_barang
        END, p_jumlah_barang, CURRENT_DATE, 'Valid'
    );
END;
$$;

CALL Update_Stok_Barang(1, 1, 'Masuk', 20);

SELECT * FROM Barang WHERE Barang_id = 1;

SELECT * FROM Transaksi_Stok WHERE Barang_id = 1;


-- b. stored procedure untuk menambah barang pada gudang 
CREATE OR REPLACE PROCEDURE Tambah_Barang_Gudang(
    IN p_barang_id INT,
    IN p_gudang_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Tambahkan relasi barang dan gudang
    INSERT INTO Menyimpan (Barang_id, Gudang_id) VALUES (p_barang_id, p_gudang_id);
END;
$$;

CALL Tambah_Barang_Gudang(3, 3);

select * from Menyimpan;

-- 3. TRIGGER 
-- Trigger untuk Menambahkan Peringatan Stok
CREATE OR REPLACE FUNCTION Tambah_Peringatan_Stok() 
RETURNS TRIGGER 
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.Stok < 10 THEN
        INSERT INTO Peringatan_Stok (
            Barang_id, Batas_stok_minimum, Tanggal_peringatan, Status_peringatan
        ) VALUES (
            NEW.Barang_id, 10, CURRENT_DATE, 'Aktif'
        );
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER Trigger_Peringatan_Stok
AFTER INSERT OR UPDATE ON Barang
FOR EACH ROW
EXECUTE FUNCTION Tambah_Peringatan_Stok();

INSERT INTO Barang (Nama_barang, Status, Tanggal_stok_terakhir, Kategori, Stok, Harga_beli, Harga_jual, Deskripsi)
VALUES ('Pensil', 'Tersedia', CURRENT_DATE, 'Alat Tulis', 5, 1000, 1500, 'Pensil HB berkualitas tinggi');

UPDATE Barang
SET Stok = 8
WHERE Barang_id = 1;

SELECT * FROM Peringatan_Stok;