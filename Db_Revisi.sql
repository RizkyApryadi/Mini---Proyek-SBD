-- Tabel Gudang
CREATE TABLE Gudang (
    gudang_id SERIAL PRIMARY KEY,
    nama_gudang VARCHAR(255) NOT NULL,
    kapasitas_maks INT NOT NULL,
    kapasitas_min INT NOT NULL
);

-- Tabel Barang
CREATE TABLE Barang (
    id_barang SERIAL PRIMARY KEY,
    nama_barang VARCHAR(255) NOT NULL,
    deskripsi TEXT,
    harga_jual NUMERIC(15, 2) NOT NULL,
    harga_beli NUMERIC(15, 2) NOT NULL,
    kategori VARCHAR(100),
    stok_barang INT NOT NULL,
    tgl_masuk DATE NOT NULL,
    gudang_id INT,
    FOREIGN KEY (gudang_id) REFERENCES Gudang(gudang_id)
);

-- Tabel User
CREATE TABLE UserTable (
    user_id SERIAL PRIMARY KEY,
    nama_user VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

-- Tabel Transaksi
CREATE TABLE Transaksi (
    id_transaksi SERIAL PRIMARY KEY,
    user_id INT,
    id_barang INT,
    tgl_pengambilan DATE NOT NULL,
    stok_awal INT NOT NULL,
    stok_akhir INT NOT NULL,
    total_harga NUMERIC(15, 2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    jlh_barang_diambil INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES UserTable(user_id),
    FOREIGN KEY (id_barang) REFERENCES Barang(id_barang)
);

-- Tabel Peringatan_Stok
CREATE TABLE Peringatan_Stok (
    id_peringatan SERIAL PRIMARY KEY,
    id_barang INT,
    tgl_peringatan DATE NOT NULL,
    FOREIGN KEY (id_barang) REFERENCES Barang(id_barang)
);


-- Dummy Data untuk Gudang
INSERT INTO Gudang (nama_gudang, kapasitas_maks, kapasitas_min)
VALUES
('Gudang Utama', 1000, 100),
('Gudang Selatan', 800, 50),
('Gudang Barat', 500, 30),
('Gudang Timur', 700, 70),
('Gudang Pusat', 1200, 200);

-- Dummy Data untuk Barang
INSERT INTO Barang (nama_barang, deskripsi, harga_jual, harga_beli, kategori, stok_barang, tgl_masuk, gudang_id)
VALUES
('Laptop', 'Laptop Core i5', 7500000, 6500000, 'Elektronik', 50, '2024-12-01', 1),
('Smartphone', 'Smartphone 6GB RAM', 5000000, 4500000, 'Elektronik', 80, '2024-12-02', 1),
('Tablet', 'Tablet 10 Inch', 3500000, 3000000, 'Elektronik', 30, '2024-12-03', 2),
('Monitor', 'Monitor LED 24 Inch', 1500000, 1300000, 'Elektronik', 40, '2024-12-04', 2),
('Mouse', 'Mouse Wireless', 300000, 200000, 'Elektronik', 100, '2024-12-05', 3),
('Keyboard', 'Keyboard Mechanical', 500000, 400000, 'Elektronik', 90, '2024-12-06', 3),
('Printer', 'Printer Laser', 2000000, 1800000, 'Elektronik', 25, '2024-12-07', 4),
('Scanner', 'Scanner Dokumen', 1200000, 1000000, 'Elektronik', 15, '2024-12-08', 4),
('Headset', 'Headset Gaming', 800000, 700000, 'Elektronik', 60, '2024-12-09', 5),
('Speaker', 'Speaker Bluetooth', 1000000, 850000, 'Elektronik', 70, '2024-12-10', 5);

-- Dummy Data untuk UserTable
INSERT INTO UserTable (nama_user, role)
VALUES
('Admin A', 'Admin'),
('Admin B', 'Admin'),
('Admin C', 'Admin'),
('Operator A', 'Operator'),
('Operator B', 'Operator'),
('Operator C', 'Operator'),
('Customer A', 'Customer'),
('Customer B', 'Customer'),
('Customer C', 'Customer'),
('Customer D', 'Customer');

-- Dummy Data untuk Transaksi
INSERT INTO Transaksi (user_id, id_barang, tgl_pengambilan, stok_awal, stok_akhir, total_harga, status, jlh_barang_diambil)
VALUES
(1, 1, '2024-12-02', 50, 45, 37500000, 'Selesai', 5),
(2, 2, '2024-12-03', 80, 75, 25000000, 'Selesai', 5),
(3, 3, '2024-12-04', 30, 20, 35000000, 'Selesai', 10),
(4, 4, '2024-12-05', 40, 35, 7500000, 'Selesai', 5),
(5, 5, '2024-12-06', 100, 90, 3000000, 'Selesai', 10),
(6, 6, '2024-12-07', 90, 85, 2500000, 'Selesai', 5),
(7, 7, '2024-12-08', 25, 20, 10000000, 'Selesai', 5),
(8, 8, '2024-12-09', 15, 10, 6000000, 'Selesai', 5),
(9, 9, '2024-12-10', 60, 55, 4000000, 'Selesai', 5),
(10, 10, '2024-12-11', 70, 65, 5000000, 'Selesai', 5);

-- Dummy Data untuk Peringatan_Stok
INSERT INTO Peringatan_Stok (id_barang, tgl_peringatan)
VALUES
(1, '2024-12-02'),
(2, '2024-12-03'),
(3, '2024-12-04'),
(4, '2024-12-05'),
(5, '2024-12-06'),
(6, '2024-12-07'),
(7, '2024-12-08'),
(8, '2024-12-09'),
(9, '2024-12-10'),
(10, '2024-12-11');


-- Membuat VIEW untuk melihat barang yang disimpan di Gudang
CREATE VIEW BarangDiGudang AS
SELECT 
    Barang.id_barang,
    Barang.nama_barang,
    Barang.deskripsi,
    Barang.harga_jual,
    Barang.harga_beli,
    Barang.kategori,
    Barang.stok_barang,
    Barang.tgl_masuk,
    Gudang.nama_gudang,
    Gudang.kapasitas_maks,
    Gudang.kapasitas_min
FROM 
    Barang
JOIN 
    Gudang
ON 
    Barang.gudang_id = Gudang.gudang_id;
	SELECT * FROM BarangDiGudang where nama_gudang = 'Gudang Selatan';
