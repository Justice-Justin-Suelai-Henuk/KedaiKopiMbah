-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 06, 2026 at 07:48 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_kedai_kopi_mbah_buyut`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id_kategori` int(11) NOT NULL,
  `nama_kategori` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id_kategori`, `nama_kategori`) VALUES
(1, 'Espresso Based'),
(2, 'Non-Coffee'),
(3, 'Makanan Ringan');

-- --------------------------------------------------------

--
-- Table structure for table `client_loyalty`
--

CREATE TABLE `client_loyalty` (
  `id_loyalty` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `total_coin` int(11) DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client_loyalty`
--

INSERT INTO `client_loyalty` (`id_loyalty`, `id_user`, `total_coin`, `updated_at`) VALUES
(1, 3, 100, '2026-10-06 05:33:46');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id_menu` int(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `nama_menu` varchar(100) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `stok` int(11) DEFAULT 0,
  `status_ketersediaan` enum('Tersedia','Habis') DEFAULT 'Tersedia',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id_menu`, `id_kategori`, `nama_menu`, `harga`, `stok`, `status_ketersediaan`, `created_at`) VALUES
(1, 1, 'Kopi Susu Mbah Buyut', 18000.00, 50, 'Tersedia', '2026-10-06 05:33:46'),
(2, 1, 'Americano', 15000.00, 40, 'Tersedia', '2026-10-06 05:33:46'),
(3, 2, 'Matcha Latte', 20000.00, 30, 'Tersedia', '2026-10-06 05:33:46'),
(4, 3, 'Cireng Bumbu Rujak', 12000.00, 25, 'Tersedia', '2026-10-06 05:33:46');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id_role` int(11) NOT NULL,
  `nama_role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id_role`, `nama_role`) VALUES
(1, 'Admin'),
(2, 'Kasir'),
(3, 'Pelanggan');

-- --------------------------------------------------------

--
-- Table structure for table `store_operational`
--

CREATE TABLE `store_operational` (
  `id_operasional` int(11) NOT NULL,
  `hari` enum('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu','Minggu') NOT NULL,
  `jam_buka` time NOT NULL,
  `jam_tutup` time NOT NULL,
  `is_open` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_operational`
--

INSERT INTO `store_operational` (`id_operasional`, `hari`, `jam_buka`, `jam_tutup`, `is_open`) VALUES
(1, 'Senin', '10:00:00', '22:00:00', 1),
(2, 'Selasa', '10:00:00', '22:00:00', 1),
(3, 'Rabu', '10:00:00', '22:00:00', 1),
(4, 'Kamis', '10:00:00', '22:00:00', 1),
(5, 'Jumat', '13:00:00', '23:00:00', 1),
(6, 'Sabtu', '10:00:00', '23:00:00', 1),
(7, 'Minggu', '10:00:00', '22:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `id_meja` int(11) NOT NULL,
  `nomor_meja` varchar(10) NOT NULL,
  `qr_code_token` varchar(255) NOT NULL,
  `status` enum('Tersedia','Terisi') DEFAULT 'Tersedia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tables`
--

INSERT INTO `tables` (`id_meja`, `nomor_meja`, `qr_code_token`, `status`) VALUES
(1, 'Meja 01', 'token_qr_meja_01_a8f9d', 'Tersedia'),
(2, 'Meja 02', 'token_qr_meja_02_b7c8e', 'Tersedia'),
(3, 'Meja 03', 'token_qr_meja_03_c6b7f', 'Tersedia');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id_transaksi` int(11) NOT NULL,
  `kode_transaksi` varchar(50) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_kasir` int(11) DEFAULT NULL,
  `id_meja` int(11) NOT NULL,
  `tipe_pemesanan` enum('QR_Code','Kasir_Direct') NOT NULL,
  `metode_bayar` enum('Cash','QRIS','Transfer_Bank') NOT NULL,
  `status_bayar` enum('Pending','Lunas','Batal') DEFAULT 'Pending',
  `subtotal` decimal(10,2) NOT NULL,
  `coin_digunakan` int(11) DEFAULT 0,
  `potongan_harga` decimal(10,2) DEFAULT 0.00,
  `total_harga` decimal(10,2) NOT NULL,
  `coin_diperoleh` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_detail`
--

CREATE TABLE `transaction_detail` (
  `id_detail` int(11) NOT NULL,
  `id_transaksi` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `id_role`, `nama`, `email`, `no_hp`, `password`, `created_at`, `updated_at`) VALUES
(1, 1, 'Admin Mbah Buyut', 'admin@mbahbuyut.com', '081234567890', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe11y01.x3S.S.b1J.W3B.0y.aZ.0.x', '2026-10-06 05:33:46', '2026-10-06 05:33:46'),
(2, 2, 'Budi Kasir', 'kasir1@mbahbuyut.com', '081234567891', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe11y01.x3S.S.b1J.W3B.0y.aZ.0.x', '2026-10-06 05:33:46', '2026-10-06 05:33:46'),
(3, 3, 'Siti Pelanggan', 'siti@gmail.com', '081234567892', '$2y$10$e0MYzXyjpJS7Pd0RVvHwHe11y01.x3S.S.b1J.W3B.0y.aZ.0.x', '2026-10-06 05:33:46', '2026-10-06 05:33:46');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `client_loyalty`
--
ALTER TABLE `client_loyalty`
  ADD PRIMARY KEY (`id_loyalty`),
  ADD UNIQUE KEY `id_user` (`id_user`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id_menu`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_role`),
  ADD UNIQUE KEY `nama_role` (`nama_role`);

--
-- Indexes for table `store_operational`
--
ALTER TABLE `store_operational`
  ADD PRIMARY KEY (`id_operasional`),
  ADD UNIQUE KEY `hari` (`hari`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id_meja`),
  ADD UNIQUE KEY `nomor_meja` (`nomor_meja`),
  ADD UNIQUE KEY `qr_code_token` (`qr_code_token`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD UNIQUE KEY `kode_transaksi` (`kode_transaksi`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_kasir` (`id_kasir`),
  ADD KEY `id_meja` (`id_meja`);

--
-- Indexes for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_transaksi` (`id_transaksi`),
  ADD KEY `id_menu` (`id_menu`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `no_hp` (`no_hp`),
  ADD KEY `id_role` (`id_role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id_kategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `client_loyalty`
--
ALTER TABLE `client_loyalty`
  MODIFY `id_loyalty` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `store_operational`
--
ALTER TABLE `store_operational`
  MODIFY `id_operasional` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `id_meja` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `client_loyalty`
--
ALTER TABLE `client_loyalty`
  ADD CONSTRAINT `client_loyalty_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `menus`
--
ALTER TABLE `menus`
  ADD CONSTRAINT `menus_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `categories` (`id_kategori`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE SET NULL,
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`id_kasir`) REFERENCES `users` (`id_user`) ON DELETE SET NULL,
  ADD CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`id_meja`) REFERENCES `tables` (`id_meja`) ON DELETE CASCADE;

--
-- Constraints for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  ADD CONSTRAINT `transaction_detail_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transactions` (`id_transaksi`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_detail_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `menus` (`id_menu`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
