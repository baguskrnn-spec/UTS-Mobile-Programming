=======
**ManageApp (Mobile User Management System)**

ManageApp adalah aplikasi mobile berbasis Flutter yang dirancang sebagai sistem manajemen autentikasi pengguna. Aplikasi ini memungkinkan pengguna untuk melakukan proses login, reset password, dan mengakses dashboard utama setelah proses autentikasi berhasil. 
Aplikasi ini dikembangkan sebagai bagian dari Ujian Tengah Semester (UTS) Mata Kuliah Mobile Programming dengan fokus pada implementasi user authentication flow dalam pengembangan aplikasi mobile menggunakan Flutter.

**Informasi Pengembang**

- Nama: Kadek Bagus Karunia Dwi Dharmayasa
- Jurusan: Rekayasa Sistem Komputer
- Mata Kuliah: Mobile Programming
- Dosen: Ir. Ahmad Asroni, S.Kom., M.Kom.
- Institusi: INSTIKI
  
**Deskripsi Aplikasi**
ManageApp merupakan aplikasi mobile yang berfungsi sebagai modul autentikasi pengguna dalam sebuah sistem aplikasi digital. Sistem ini dirancang untuk mengelola proses login pengguna secara aman dan memberikan akses ke halaman dashboard setelah autentikasi berhasil. 
Aplikasi ini dapat digunakan sebagai bagian dari berbagai sistem digital seperti:
- Sistem manajemen pengguna perusahaan
- Aplikasi layanan pelanggan
- Sistem manajemen internal organisasi
- Platform layanan berbasis akun pengguna
  
Dengan arsitektur sederhana namun terstruktur, aplikasi ini menunjukkan implementasi dasar UI/UX Flutter, validasi form, navigasi antar halaman, serta pengelolaan state pada aplikasi mobile.

Fitur Utama

**Login System**

Fitur autentikasi pengguna menggunakan email dan password.
Fitur yang tersedia:
- Input email dan password
- Validasi form menggunakan Form dan TextFormField
- Validasi format email menggunakan Regular Expression
- Validasi password minimal 8 karakter
- Fitur show/hide password
- Feedback kepada pengguna menggunakan SnackBar
- Simulasi proses autentikasi menggunakan Future.delayed()

**Forgot Password**

Fitur untuk membantu pengguna yang lupa password.
Fungsi utama :
- Input email pengguna
- Validasi format email
- Simulasi pengiriman permintaan reset password

**Dashboard**

Halaman utama setelah pengguna berhasil melakukan login.
Fitur:
- Menampilkan informasi pengguna yang sedang login
- Tampilan halaman utama aplikasi
- Navigasi dasar dalam aplikasi

**Alur Penggunaan Aplikasi**

Berikut alur penggunaan aplikasi ManageApp
1. Pengguna membuka aplikasi
2. Pengguna memasukkan email dan password
3. Sistem melakukan validasi input
4. Jika login berhasil → pengguna diarahkan ke Dashboard
5. Jika pengguna lupa password → dapat mengakses Forgot Password

Flow Aplikasi :
Login --> Dashboard
Login --> Forgot Password

**Teknologi yang Digunakan**

Aplikasi ini dikembangkan menggunakan teknologi berikut:
- Flutter
- Dart
- Material Design UI

**Widget Flutter yang Digunakan**

Beberapa widget utama yang digunakan dalam aplikasi ini antara lain:

1. Basic Widgets
   - MaterialApp
   - Scaffold
   - Text
   - Column
   - Row
   - Container
   - Padding
   - SizedBox
2. Form Widgets
   - Form
   - TextFormField
   - GlobalKey
3. Advanced Widgets
   - Navigator
   - SnackBar
   - CircleAvatar
   - IconButton
   - LinearGradient
   - CircularProgressIndicator
   - SingleChildScrollView
  
**Cara Menjalankan Aplikasi**
1. Clone repository ini

git clone https://github.com/username/manageapp.git

2. Masuk ke folder project

cd manageapp

3. Install dependencies

flutter pub get

4. Jalankan aplikasi

flutter run

Pastikan Flutter SDK sudah terinstall pada perangkat Anda.
>>>>>>> 93c5e08bfdcb810d90f63ff0773ecfa8d8d3de11
