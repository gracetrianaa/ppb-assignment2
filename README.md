# Assignment Week 7

Aplikasi To Do List sederhana dengan fitur add, edit, dan delete dengan koneksi ke Isar Database.

Nama: Gracetriana Survinta Septinaputri  
NRP: 5025211199  
Kelas: Pemrograman Perangkat Bergerak (C)  

## Referensi
- Flutter Projects for Beginners #02: [Building a To-Do List](https://medium.com/@frojho/flutter-projects-for-beginners-02-building-a-to-do-list-790acb8720d9)
- Flutter Isar Database Tutorial | Isar DB CRUD Guide: [Link](https://youtu.be/jVgQ5esp-PE?si=v76KYieYdlTxyU1O)

## Program Breakdown

Pada aplikasi ini dibagi menjadi 3 bagian yaitu `main.dart`, `pages/home_page.dart`, dan `models/task_model.dart`. 
Mari kita bahas satu persatu dimulai dari `main.dart` 

# `main.dart`

Pada bagian ini, seperti fungsi `main()` pada umumnya yang bertugas meninisialisasi, dalam project ini menggunakan Isar Database,
dan menjalankan aplikasi. Fungsi `main()` menggunakan WidgetsFlutterBinding.ensureInitialized() untuk memastikan semua binding Flutter 
siap sebelum melakukan operasi asinkron, seperti mengambil direktori lokal aplikasi dengan getApplicationDocumentsDirectory(). Setelah itu, database 
Isar dibuka dengan menyertakan skema TaskModelSchema dan menentukan direktori penyimpanan. Instance Isar tersebut kemudian diteruskan ke widget MyApp, 
yang bertugas membangun tampilan aplikasi dengan MaterialApp, menentukan tema, serta memuat halaman utama HomePage sambil meneruskan objek database agar 
dapat digunakan untuk mengelola data tugas secara lokal.

# `home_page.dart`

Bagian ini memuat HomePage yang mana adalah halaman utama dari aplikasi to-do list ini yang memuat CRUD data tugas dari Isar Database. Di dalam `State<HomePage>`, terdapat list `tasksList` yang menyimpan seluruh task yang diambil dari database.
Saat halaman pertama kali dimuat `(initState())`, fungsi `loadTasks()` dijalankan untuk mengambil seluruh data task dan menyimpannya ke `tasksList` menggunakan `setState()` agar Ui ikut diperbarui.
Fungsi `createTask()`, `updateTask()`, dan `deleteTask()` dijalankan dalam transaksi `writeTxn()` milik Isar dan masing-masing bertugas menyimpan task baru, mengubah data task, dan menghapus task berdasarkan ID-nya.
Fungsi `showEditDialog()` digunakan untuk menampilkan dialog pengeditan task saat pengguna tap item task dalam list. Dialog ini memungkinkan pengguna mengubah judul dan status dari task yang dipilih. Selain itu, jika status bukan "Completed", 
informasi "Last Updated" juga akan ditampilkan. UI dibangun dalam `build()` menggunakan `Scaffold` dan menampilkan daftar task dalam `ListView.builder`.

# `task_model.dart`

Bagian ini mendefinisikan `TaskModel`  yang merepresentasikan sebuah task (tugas) dalam aplikasi menggunakan Isar Database dalam bentuk koleksi (tabel). Properti `id` didefinisikan dengan `Isar.autoIncrement`, artinya setiap task baru akan secara otomatis diberi ID unik. 
Properti `title`, `status`, dan `lastUpdated` menyimpan informasi utama dari sebuah task: judul, status (seperti "In Progress", "Completed", atau "On Hold"), serta waktu terakhir diperbarui. Kelas ini juga menyediakan berbagai method bantu untuk konversi data, yaitu `toMap()`, 
`fromMap()`, `toJson()`, dan `fromJson()`. Fungsi-fungsi ini berguna untuk menyimpan task dalam bentuk JSON atau Map. File ini juga mengimpor `task_model.g.dart` melalui directive part, yang dihasilkan otomatis oleh Isar saat menjalankan build runner, untuk menangani serialisasi internal Isar.


