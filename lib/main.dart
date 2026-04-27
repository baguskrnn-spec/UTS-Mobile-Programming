import 'package:flutter/material.dart'; // Import library Flutter untuk membangun UI

void main() {
  runApp(const MyApp());
}

// Fungsi main sebagai titik masuk aplikasi, menjalankan MyApp sebagai root widget dari aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Widget utama aplikasi yang bersifat stateless karena tidak memiliki state yang berubah-ubah, hanya berfungsi untuk mengatur routing dan tema aplikasi

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manage App',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/forgot': (context) => const ForgotPasswordPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
} // Halaman login dengan form input email dan password, tombol login, dan fitur validasi serta feedback

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
} // Widget untuk halaman login yang bersifat stateful karena memiliki state untuk form input, validasi, loading, dan feedback error

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email =
      TextEditingController(); // Controller untuk input email
  TextEditingController password =
      TextEditingController(); // Controller untuk input password

  bool isLoading = false;
  bool isPasswordVisible = false;
  String errorMessage = "";

  final String correctEmail = "admin@test.com";
  final String correctPassword = "Admin123";

  void login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }// Memeriksa validasi form, jika tidak valid maka fungsi login akan berhenti dan tidak melanjutkan proses login

    setState(() {
      isLoading = true; 
      errorMessage = ""; 
    });// Set state untuk loading menjadi true agar tombol login dinonaktifkan dan menampilkan indikator loading, serta mengosongkan pesan error sebelum memulai proses login

    // Simulasi proses login dengan delay 2 detik untuk memberikan feedback loading kepada pengguna
    await Future.delayed(const Duration(seconds: 2));

    // Cek apakah email dan password yang diinput sesuai dengan data login yang benar
    if (email.text == correctEmail && password.text == correctPassword) {
      setState(() {
        isLoading = false;
      });

      // Menampilkan snackbar sebagai feedback bahwa login berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Berhasil"),
        ),
      );

      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
        arguments: email
            .text,
      );// Mengarahkan ke halaman dashboard dan mengirimkan email pengguna sebagai argumen untuk ditampilkan di halaman dashboard setelah login berhasil

    } else {
      setState(() {
        isLoading = false;
        errorMessage =
            "Email atau Password salah"; // Set pesan error untuk ditampilkan di UI jika login gagal
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login Gagal")));
    }
  }// Fungsi login yang dijalankan saat tombol login ditekan, melakukan validasi form, simulasi proses login dengan delay, dan memberikan feedback apakah login berhasil atau gagal melalui snackbar dan pesan error di UI

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height:
              double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFC107), Color(0xFFFFEB3B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          // SingleChildScrollView untuk memungkinkan halaman login dapat discroll jika konten melebihi tinggi layar, terutama saat keyboard muncul
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(
                25,
              ), // Memberikan padding di sekitar seluruh konten halaman login agar tidak menempel ke tepi layar
              child: Column(
                children: [
                  // Kolom utama yang berisi semua elemen UI pada halaman login, seperti avatar, judul, form input, tombol, dan feedback error
                  const SizedBox(
                    height: 40,
                  ), // Memberikan jarak vertikal antara atas layar dengan avatar
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-NYM-4jRyld-ZDTI1w210N1Csgl1IOODX8w&s",
                    ), // Gambar avatar yang diambil dari URL, dengan radius 50 untuk ukuran lingkaran avatar
                  ),

                  // SizedBox untuk memberikan jarak vertikal antara avatar dengan judul "Manage App"
                  const SizedBox(height: 20),
                  const Text(
                    "ManageApp",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  // SizedBox untuk memberikan jarak vertikal antara judul dengan form input email dan password
                  const SizedBox(height: 30),

                  // Container untuk membungkus form input email dan password dengan padding dan dekorasi seperti warna latar belakang putih dan border radius
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),

                    // Form Login Email dan Password
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: email,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(),
                            ),

                            // Validasi Email (regex + tidak boleh kosong)
                            validator: (value) {

                              if (value == null || value.isEmpty) {
                                return "Email tidak boleh kosong";
                              }

                              final emailRegex = RegExp(
                                r'^[^@]+@[^@]+\.[^@]+',
                              ); // Regex untuk memeriksa format email yang benar, memastikan ada karakter sebelum @, diikuti oleh domain dan ekstensi

                              if (!emailRegex.hasMatch(value)) {
                                return "Format email tidak valid"; // Jika nilai email tidak sesuai dengan format yang benar, mengembalikan pesan error "Format email tidak valid"
                              }
                              return null; 
                            },
                          ),

                          const SizedBox(height: 15),

                          // Form Login Password dengan fitur visibility dan validasi
                          TextFormField(
                            controller:
                                password,
                            obscureText:
                                !isPasswordVisible, 
                            decoration: InputDecoration(
                              labelText: "Password",
                              border:
                                  const OutlineInputBorder(), 
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible 
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    // Memanggil setState untuk mengubah state isPasswordVisible, sehingga UI akan diperbarui untuk menampilkan atau menyembunyikan password
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            ),

                            // Validasi Password (minimal 8 karakter, harus mengandung huruf dan angka, tidak boleh kosong)
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password tidak boleh kosong";
                              }

                              if (value.length < 8) {
                                return "Minimal 8 karakter";
                              }

                              final regex = RegExp(
                                r'^(?=.*[A-Za-z])(?=.*\d)',
                              ); // Regex untuk memeriksa apakah password mengandung setidaknya satu huruf dan satu angka, memastikan password memiliki kombinasi karakter yang lebih kuat

                              if (!regex.hasMatch(value)) {
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
                              onPressed: () {
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

                          if (errorMessage.isNotEmpty)
                            Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text("Version 1.0.0"),
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
  const ForgotPasswordPage({
    super.key,
  }); // Konstruktor untuk ForgotPasswordPage, menggunakan super.key untuk mendukung key pada widget

  // Widget untuk halaman reset password yang bersifat stateful karena memiliki state untuk form, loading, dll
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
} 

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
      const SnackBar(content: Text("Link reset telah dikirim ke email Anda")),
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
                  border:
                      OutlineInputBorder(), // Border untuk input email agar terlihat lebih jelas dan terpisah dari latar belakang
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : sendReset,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Kirim Link Reset"),
                ),
              ),

              const SizedBox(height: 10),

              // Tombol untuk kembali ke halaman login
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Kembali ke Login"),
              ),
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
    final userEmail = ModalRoute.of(context)!.settings.arguments as String?;

    // Halaman dashboard yang menampilkan email pengguna, daftar produk, dan tombol logout
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          // Tombol logout yang mengarahkan kembali ke halaman login dan menghapus semua route sebelumnya
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
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
              itemBuilder: (context, index) {
                // Setiap item produk ditampilkan dalam Card dengan ikon, nama produk, dan deskripsi secara singkat
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),

                  child: ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: Text("Produk ${index + 1}"),
                    subtitle: const Text("Deskripsi produk"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
