![Showcase MediList](assets/dokumentasi/showcase.png)

# MediList

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

## Tentang Proyek

MediList adalah aplikasi manajemen inventaris obat yang dirancang untuk membantu apotek dan fasilitas medis dalam mengelola stok obat mereka. Aplikasi ini dikembangkan sebagai tugas akhir dari mata pelajaran produktif RPL (Rekayasa Perangkat Lunak) di SMK Telkom Malang untuk kelas 11 RPL 3.

**Anggota Tim:**

1. CIPTO YAFIG ADIWONGSO
2. ANDRYANSYAH
3. FADEL MUHAMMAD IZZAT
4. SULTAN MIKAIL ZAKI AL BANI

## Deskripsi Aplikasi

Proyek ini saat ini masih berupa implementasi front-end saja. Meskipun integrasi backend akan sangat meningkatkan fungsionalitas aplikasi, karena keterbatasan waktu, fokus kami adalah pada pembuatan antarmuka pengguna yang komprehensif dan fungsional. Aplikasi ini mendemonstrasikan kemampuan manajemen inventaris termasuk pelacakan produk, manajemen stok, manajemen pemasok, dan pelaporan.

## Unduh Aplikasi

Anda dapat mengunduh dan mencoba aplikasi MediList melalui link berikut:
[Unduh MediList.apk](https://drive.google.com/file/d/1SySufvLLB3GYNKjBtORDDntFACU74rBj/view?usp=sharing)

## Sumber Daya Desain

Proses desain kami meliputi pembuatan mockup dan desain UI terperinci menggunakan Figma:

- [Mockup Board](https://www.figma.com/board/G0YIngtoy02XnqTtZq55sZ/Untitled?node-id=0-1&p=f)
- [Desain Aplikasi](https://www.figma.com/design/LQhY0jEPH4hidmvIZZjEZ7/Tugas-Akhir?node-id=0-1&p=f)

## Struktur Proyek

```bash
lib
-> tree
.
├── core
│   ├── constant.dart
│   ├── themes.dart
│   └── utils.dart
├── main.dart
├── models
│   ├── produk.dart
│   ├── supplier.dart
│   └── user.dart
├── pages
│   ├── auth
│   │   ├── login.dart
│   │   └── signup.dart
│   ├── dashboard
│   │   └── dashboard.dart
│   ├── history
│   │   └── history-page.dart
│   ├── produk
│   │   └── produk-page.dart
│   ├── report
│   │   └── report-page.dart
│   ├── splash-screen
│   │   └── splashscreen.dart
│   ├── stock
│   │   ├── stock-in.dart
│   │   └── stock-out.dart
│   └── supplier
│       └── supplier-page.dart
└── services
    └── api-services.dart

13 directories, 18 files
```

## Fitur Aplikasi

- **Autentikasi**: Login dan registrasi pengguna
- **Dashboard**: Ringkasan informasi penting tentang inventaris
- **Manajemen Produk**: Tambah, edit, lihat detail produk
- **Manajemen Stok**: Pencatatan stok masuk dan stok keluar
- **Manajemen Supplier**: Kelola informasi supplier
- **Riwayat Transaksi**: Lihat dan filter riwayat transaksi stok
- **Laporan**: Generate dan lihat laporan inventaris

## Dokumentasi Aplikasi

### 1. Autentikasi

#### 1.1 Registrasi

![Registrasi](assets/dokumentasi/registrasi.png)

#### 1.2 Registrasi Dengan Validasi

![Registrasi Validasi](assets/dokumentasi/registrasi-validasi.png)

#### 1.3 Registrasi Ketika Sukses

![Registrasi Sukses](assets/dokumentasi/registrasi-succes.png)

#### 1.4 Login

![Login](assets/dokumentasi/login.png)

#### 1.5 Login Dengan Validasi

![Login Validasi](assets/dokumentasi/login-validasi.png)

### 2. Dashboard & Navigasi

#### 2.1 Dashboard

![Dashboard](assets/dokumentasi/dashboard.png)

#### 2.2 Navigasi

![Navbar](assets/dokumentasi/navbar.png)

### 3. Manajemen Produk

#### 3.1 Daftar Produk

![Produk](assets/dokumentasi/products.png)

#### 3.2 Tambah Produk

![Tambah Produk](assets/dokumentasi/products-add.png)

#### 3.3 Produk Stok Rendah

![Produk Stok Rendah](assets/dokumentasi/products-lowstock.png)

#### 3.4 Produk Mendekati Kadaluarsa

![Produk Mendekati Kadaluarsa](assets/dokumentasi/products-nearexpiry.png)

#### 3.5 Validasi Tambah Stok

![Validasi Tambah Stok](assets/dokumentasi/products-addstock_validasi.png)

#### 3.6 Sukses Tambah Stok

![Sukses Tambah Stok](assets/dokumentasi/products-addstock_succes.png)

### 4. Manajemen Stok Masuk

#### 4.1 Halaman Stok Masuk

![Stok In](assets/dokumentasi/stockin.png)

#### 4.2 Tambah Produk Baru

![Tambah Produk Baru](assets/dokumentasi/stockin-addnew.png)

#### 4.3 Pilih Kategori Produk

![Pilih Kategori](assets/dokumentasi/stockin-addnew_selectcategory.png)

#### 4.4 Pilih Supplier

![Pilih Supplier](assets/dokumentasi/stockin-addnew_selectsupplier.png)

#### 4.5 Validasi Tambah Produk

![Validasi Tambah Produk](assets/dokumentasi/stockin-addnew_validasi.png)

#### 4.6 Sukses Tambah Produk

![Sukses Tambah Produk](assets/dokumentasi/stockin-addnew_succes.png)

#### 4.7 Tambah Stok

![Tambah Stok](assets/dokumentasi/stockin-addstock.png)

#### 4.8 Pilih Produk Untuk Tambah Stok

![Pilih Produk](assets/dokumentasi/stockin-addstock_selectproduct.png)

#### 4.9 Validasi Tambah Stok

![Validasi Tambah Stok](assets/dokumentasi/stockin-addstock_validasi.png)

#### 4.10 Sukses Tambah Stok

![Sukses Tambah Stok](assets/dokumentasi/stockin-addstock_succes.png)

### 5. Manajemen Stok Keluar

#### 5.1 Halaman Stok Keluar

![Stok Out](assets/dokumentasi/stockout.png)

#### 5.2 Form Stok Keluar

![Form Stok Keluar](assets/dokumentasi/stockout-stockout.png)

#### 5.3 Pilih Produk Untuk Stok Keluar

![Pilih Produk](assets/dokumentasi/stockout-stockout_selectproduct.png)

#### 5.4 Validasi Stok Keluar

![Validasi Stok Keluar](assets/dokumentasi/stockout-stockout_validasi.png)

#### 5.5 Sukses Stok Keluar

![Sukses Stok Keluar](assets/dokumentasi/stockout-stockout_succes.png)

### 6. Manajemen Supplier

#### 6.1 Halaman Supplier 1

![Supplier 1](assets/dokumentasi/supplier-1.png)

#### 6.2 Halaman Supplier 2

![Supplier 2](assets/dokumentasi/supplier-2.png)

#### 6.3 Tambah Supplier

![Tambah Supplier](assets/dokumentasi/supplier-add_supplier.png)

#### 6.4 Validasi Tambah Supplier

![Validasi Tambah Supplier](assets/dokumentasi/supplier-add_supplier-validasi.png)

#### 6.5 Sukses Tambah Supplier

![Sukses Tambah Supplier](assets/dokumentasi/supplier-add_supplier-succes.png)

### 7. Riwayat Transaksi

#### 7.1 Semua Riwayat

![Semua Riwayat](assets/dokumentasi/history-all.png)

#### 7.2 Filter Berdasarkan Tanggal

![Filter Tanggal](assets/dokumentasi/history-date.png)

#### 7.3 Riwayat Stok Masuk

![Riwayat Stok Masuk](assets/dokumentasi/history-in.png)

#### 7.4 Riwayat Stok Keluar

![Riwayat Stok Keluar](assets/dokumentasi/history-out.png)

#### 7.5 Riwayat Pengembalian

![Riwayat Pengembalian](assets/dokumentasi/history-return.png)

#### 7.6 Riwayat Kadaluarsa

![Riwayat Kadaluarsa](assets/dokumentasi/history-expired.png)

#### 7.7 Ringkasan Riwayat

![Ringkasan Riwayat](assets/dokumentasi/history-summary.png)

### 8. Laporan

#### 8.1 Halaman Laporan 1

![Laporan 1](assets/dokumentasi/reports-1.png)

#### 8.2 Halaman Laporan 2

![Laporan 2](assets/dokumentasi/reports-2.png)

#### 8.3 Halaman Laporan 3

![Laporan 3](assets/dokumentasi/reports-3.png)

#### 8.4 Filter Laporan Berdasarkan Tanggal

![Filter Laporan](assets/dokumentasi/reports-date.png)

#### 8.5 Lihat Laporan 1

![Lihat Laporan 1](assets/dokumentasi/reports-view_1.png)

#### 8.6 Lihat Laporan 2

![Lihat Laporan 2](assets/dokumentasi/reports-view_2.png)

#### 8.7 Ekspor Laporan PDF

![Ekspor PDF](assets/dokumentasi/reports-pdf.png)

## Cara Menjalankan Proyek

1. **Clone repository**:

   ```bash
   git clone https://github.com/flageagle777/MediList.git
   cd MediList
   ```

2. **Persiapan:**

   ```bash
   flutter pub get
   ```

3. **Menjalankan di mode debug**:

   ```bash
   flutter run
   ```

4. **Build aplikasi release**:
   ```bash
   flutter build apk --release
   ```

## Implementasi Teknis

- **State Management**: Penggunaan StatefulWidget dengan manajemen state yang efisien
- **API Integration**: Komunikasi dengan backend menggunakan HTTP client yang dioptimalkan
- **Error Handling**: Penanganan error yang komprehensif dengan feedback visual
- **Form Validation**: Validasi input yang lengkap pada setiap form
- **Session Management**: Penyimpanan dan pengelolaan session pengguna

## Teknologi yang Digunakan

- **Framework**: Flutter
- **Bahasa Pemrograman**: Dart
- **Desain UI/UX**: Figma
- **State Management**: Provider
- **Penyimpanan Lokal**: SharedPreferences

© Terima Kasih
