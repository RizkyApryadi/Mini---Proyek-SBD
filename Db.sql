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