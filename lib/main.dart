import 'package:flutter/material.dart'; // Import library Flutter untuk membangun UI

void main() { // Fungsi utama yang menjalankan aplikasi Flutter
  runApp(const MyApp()); // Menjalankan widget MyApp sebagai root dari aplikasi
}

class MyApp extends StatelessWidget { // Widget utama aplikasi yang bersifat stateless
  const MyApp({super.key}); // Konstruktor untuk MyApp, menggunakan super.key untuk mendukung key pada widget

  @override // Override method build untuk membangun UI dari widget ini
  Widget build(BuildContext context) { // Mengembalikan MaterialApp sebagai root widget dari aplikasi
    return MaterialApp( // MaterialApp menyediakan banyak fitur untuk aplikasi seperti routing, tema, dll
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug di pojok kanan atas
      title: 'Manage App', // Judul aplikasi
      initialRoute: '/', // Route awal yang akan ditampilkan saat aplikasi dijalankan
      routes: { // Mendefinisikan route untuk navigasi antar halaman
        '/': (context) => const LoginPage(), // Route untuk halaman login
        '/forgot': (context) => const ForgotPasswordPage(), // Route untuk halaman reset password
        '/dashboard': (context) => const DashboardPage(), // Route untuk halaman dashboard
      },
    );
  }
}
// Halaman login dengan form input email dan password, tombol login, dan fitur validasi serta feedback
class LoginPage extends StatefulWidget { // Widget untuk halaman login yang bersifat stateful karena memiliki state untuk form, loading, dll
  const LoginPage({super.key}); // Konstruktor untuk LoginPage, menggunakan super.key untuk mendukung key pada widget

  @override // Override method createState untuk membuat state dari widget ini
  State<LoginPage> createState() => _LoginPageState(); // Mengembalikan instance dari _LoginPageState sebagai state untuk widget ini
}
// State untuk halaman login yang mengelola form input, validasi, loading, dan feedback error
class _LoginPageState extends State<LoginPage> { // State untuk halaman login yang mengelola form input, validasi, loading, dan feedback error

  final _formKey = GlobalKey<FormState>();// Key untuk form agar bisa melakukan validasi
// Controller untuk input email dan password agar bisa mengambil nilai yang diinput oleh pengguna
  TextEditingController email = TextEditingController(); // Controller untuk input email
  TextEditingController password = TextEditingController(); // Controller untuk input password

// State untuk loading, visibility password, dan pesan error
  bool isLoading = false; // State untuk menandakan apakah sedang dalam proses login (loading)
  bool isPasswordVisible = false; // State untuk menandakan apakah password terlihat atau tidak
  String errorMessage = ""; // State untuk menyimpan pesan error jika login gagal

// Data login yang benar (hardcoded untuk demo)
  final String correctEmail = "admin@test.com"; 
  final String correctPassword = "Admin123";
// Fungsi untuk menangani proses login, termasuk validasi form, simulasi loading, dan memberikan feedback berdasarkan hasil login
  void login() async { 
// Validasi form, jika tidak valid maka keluar dari fungsi
    if(!_formKey.currentState!.validate()){
      return;
    }

// Jika valid, set state untuk loading dan reset pesan error
    setState(() {
      isLoading = true; // Menandakan bahwa proses login sedang berlangsung
      errorMessage = ""; // Reset pesan error sebelum mencoba login
    });

// Simulasi proses login dengan delay 2 detik untuk memberikan feedback loading kepada pengguna
    await Future.delayed(const Duration(seconds: 2));

// Cek apakah email dan password yang diinput sesuai dengan data login yang benar
    if(email.text == correctEmail && password.text == correctPassword){

// Jika login berhasil, set state untuk loading menjadi false dan tampilkan snackbar sebagai feedback
      setState(() {// Set state untuk loading menjadi false karena proses login selesai
        isLoading = false;
      });

// Menampilkan snackbar sebagai feedback bahwa login berhasil
      ScaffoldMessenger.of(context).showSnackBar( 
        const SnackBar(content: Text("Login Berhasil")) // Snackbar dengan pesan "Login Berhasil"
      );
// Mengarahkan ke halaman dashboard dan mengirimkan email sebagai argumen
      Navigator.pushReplacementNamed( // Mengganti halaman saat ini dengan halaman dashboard
        context,
        '/dashboard',
        arguments: email.text, // Mengirimkan email yang diinput sebagai argumen ke halaman dashboard
      );

// Jika login gagal, set state untuk loading menjadi false dan tampilkan pesan error
    }else{

      setState(() {
        isLoading = false;
        errorMessage = "Email atau Password salah"; // Set pesan error untuk ditampilkan di UI jika login gagal
      });

// Menampilkan snackbar dengan pesan "Login Gagal" jika login tidak berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Gagal"))
      );
    }
  }

// Build method untuk membangun UI halaman login dengan form input email dan password, tombol login, dan feedback error
  @override
  Widget build(BuildContext context) { 
    return Scaffold( // Scaffold sebagai struktur dasar halaman dengan body
      body: SafeArea( // SafeArea untuk memastikan UI tidak terhalang oleh notch, status bar, dll
        child: Container( // Container utama yang membungkus seluruh UI halaman login
          width: double.infinity, 
          height: double.infinity, // Membuat container yang memenuhi seluruh layar

// Memberikan dekorasi dengan gradient warna untuk latar belakang halaman login
          decoration: const BoxDecoration( // Dekorasi untuk container dengan gradient warna
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFC107),
                Color(0xFFFFEB3B),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter, 
            ),
          ),

// SingleChildScrollView untuk memungkinkan halaman login dapat discroll jika konten melebihi tinggi layar, terutama saat keyboard muncul
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25), // Memberikan padding di sekitar seluruh konten halaman login agar tidak menempel ke tepi layar
              child: Column( 
                children: [ // Kolom utama yang berisi semua elemen UI pada halaman login, seperti avatar, judul, form input, tombol, dan feedback error

                  const SizedBox(height: 40), // Memberikan jarak vertikal antara atas layar dengan avatar

// CircleAvatar untuk menampilkan gambar avatar di halaman login
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-NYM-4jRyld-ZDTI1w210N1Csgl1IOODX8w&s",
                    ), // Gambar avatar yang diambil dari URL, dengan radius 50 untuk ukuran lingkaran avatar
                  ),

// SizedBox untuk memberikan jarak vertikal antara avatar dengan judul "Manage App"
                  const SizedBox(height: 20),
// Text untuk menampilkan judul "Manage App" dengan gaya teks yang besar dan tebal
                  const Text(
                    "ManageApp",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold, 
                    ),
                  ),

// SizedBox untuk memberikan jarak vertikal antara judul dengan form input email dan password
                  const SizedBox(height: 30),

// Container untuk membungkus form input email dan password dengan padding dan dekorasi seperti warna latar belakang putih dan border radius
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ), // Container dengan latar belakang putih dan border radius untuk membungkus form input email dan 
                      //password agar terlihat lebih menarik dan terpisah dari latar belakang gradient halaman login

// Form Login Email dan Password
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [

// Form Login Email dengan validasi format email dan tidak boleh kosong
                          TextFormField(
                            controller: email,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(),
                            ),

// Validasi Email (regex + tidak boleh kosong)
                            validator: (value){ // Fungsi validasi untuk input email, memeriksa apakah email tidak kosong dan sesuai dengan format email yang benar menggunakan regex

                              if(value == null || value.isEmpty){ // Memeriksa apakah nilai email kosong atau null, jika ya maka mengembalikan pesan error "Email tidak boleh kosong"
                                return "Email tidak boleh kosong";
                              }

                              final emailRegex = 
                              RegExp(r'^[^@]+@[^@]+\.[^@]+'); // Regex untuk memeriksa format email yang benar, memastikan ada karakter sebelum @, diikuti oleh domain dan ekstensi

                              if(!emailRegex.hasMatch(value)){ 
                                return "Format email tidak valid"; // Jika nilai email tidak sesuai dengan format yang benar, mengembalikan pesan error "Format email tidak valid"
                              }

                              return null; // Jika validasi berhasil, mengembalikan null yang menandakan tidak ada error
                            },
                          ),

                          const SizedBox(height: 15),

// Form Login Password dengan fitur visibility dan validasi
                          TextFormField(
                            controller: password, // Controller untuk input password agar bisa mengambil nilai yang diinput oleh pengguna
                            obscureText: !isPasswordVisible, // Mengatur apakah teks password terlihat atau disembunyikan berdasarkan state isPasswordVisible
                            decoration: InputDecoration( // Dekorasi untuk input password, termasuk label, border, dan ikon untuk toggle visibility
                              labelText: "Password", 
                              border: const OutlineInputBorder(), // Border untuk input password agar terlihat lebih jelas dan terpisah dari latar belakang
                              suffixIcon: IconButton( // Ikon untuk toggle visibility password, menggunakan IconButton agar bisa ditekan untuk mengubah state visibility
                                icon: Icon(
                                  isPasswordVisible // Menampilkan ikon visibility atau visibility_off berdasarkan state isPasswordVisible, jika true maka tampilkan ikon visibility, jika false maka tampilkan ikon visibility_off
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: (){ // Fungsi yang dijalankan saat ikon visibility ditekan, mengubah state isPasswordVisible untuk toggle antara terlihat dan disembunyikan
                                  setState(() { // Memanggil setState untuk mengubah state isPasswordVisible, sehingga UI akan diperbarui untuk menampilkan atau menyembunyikan password
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            ),

// Validasi Password (minimal 8 karakter, harus mengandung huruf dan angka, tidak boleh kosong)
                            validator: (value){

                              if(value == null || value.isEmpty){
                                return "Password tidak boleh kosong";
                              }

                              if(value.length < 8){
                                return "Minimal 8 karakter";
                              }

                              final regex =
                              RegExp(r'^(?=.*[A-Za-z])(?=.*\d)'); // Regex untuk memeriksa apakah password mengandung setidaknya satu huruf dan satu angka, memastikan password memiliki kombinasi karakter yang lebih kuat

                              if(!regex.hasMatch(value)){
                                return "Harus mengandung huruf dan angka";
                              } // Jika nilai password tidak sesuai dengan kriteria validasi, mengembalikan pesan error yang sesuai, seperti "Password tidak boleh kosong", "Minimal 8 karakter", atau "Harus mengandung huruf dan angka"

                              return null;
                            },
                          ),

                          const SizedBox(height: 10),

// Tombol "Lupa Password?" yang mengarahkan ke halaman reset password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/forgot');
                              },
                              child: const Text("Lupa Password?"),
                            ),
                          ),

                          const SizedBox(height: 10),

// Tombol Login dengan state loading dan menampilkan pesan error jika login gagal
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : login,
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text("Login"),
                            ),
                          ),

                          const SizedBox(height: 10),

                          if(errorMessage.isNotEmpty)
                            Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),

                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text("Version 1.0.0")

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Halaman reset password dengan form input email, tombol kirim link reset, dan tombol kembali ke login
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key}); // Konstruktor untuk ForgotPasswordPage, menggunakan super.key untuk mendukung key pada widget

// Widget untuk halaman reset password yang bersifat stateful karena memiliki state untuk form, loading, dll
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
} // Widget untuk halaman reset password yang bersifat stateful karena memiliki state untuk form, loading, dll
// Halaman reset password dengan form input email, tombol kirim link reset, dan tombol kembali ke login

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
// Controller untuk input email agar bisa mengambil nilai yang diinput oleh pengguna
  TextEditingController email = TextEditingController();
  bool isLoading = false;

  void sendReset() async {

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

// Menampilkan snackbar sebagai feedback bahwa link reset telah dikirim
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Link reset telah dikirim ke email Anda"),
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ), // AppBar dengan judul "Reset Password" untuk halaman reset password

// Body halaman reset password dengan form input email, tombol kirim link reset, dan tombol kembali ke login
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

// Column utama yang berisi form input email, tombol kirim link reset, dan tombol kembali ke login, dengan padding di sekitar seluruh konten
          child: Column(
            children: [
// Form input email dengan validasi format email dan tidak boleh kosong
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(), // Border untuk input email agar terlihat lebih jelas dan terpisah dari latar belakang
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : sendReset,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Kirim Link Reset"),
                ),
              ),

              const SizedBox(height: 10),

// Tombol untuk kembali ke halaman login
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("Kembali ke Login"),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {

// Mengambil email pengguna yang dikirim dari halaman login melalui argumen route
    final userEmail =
        ModalRoute.of(context)!.settings.arguments as String?;

// Halaman dashboard yang menampilkan email pengguna, daftar produk, dan tombol logout
    return Scaffold(

      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
// Tombol logout yang mengarahkan kembali ke halaman login dan menghapus semua route sebelumnya
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false,
              );
            },
          )

        ],
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),

            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Selamat datang, $userEmail",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
// Daftar produk dummy menggunakan ListView.builder di dalam Expanded agar memenuhi sisa ruang pada layar
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context,index){
// Setiap item produk ditampilkan dalam Card dengan ikon, nama produk, dan deskripsi secara singkat
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),

                  child: ListTile( 
                    leading: const Icon(Icons.shopping_cart),
                    title: Text("Produk ${index+1}"),
                    subtitle: const Text("Deskripsi produk"), 
                  ),
                );
              },
            ),
          )

        ],
      ),
    );
  }
}