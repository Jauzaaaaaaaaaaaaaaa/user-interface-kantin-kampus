import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'menu_pesanan.dart';

class DaftarKantinKampus extends StatelessWidget {
  const DaftarKantinKampus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Kantin Kampus',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:const Color.fromARGB(255, 255, 165, 0),
        centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                } catch (e) {
                  Get.snackbar("Error", e.toString());
                }
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white, // Mengatur warna ikon menjadi putih
                size: 28, // Mengatur ukuran ikon
              ),
            )
          ],

      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          KantinTile(
            nama: 'Kantin Bu Sri',
            deskripsi: 'Menyediakan Makanan ringan dan Snack.',
            menu: [
              MenuItem(nama: 'Biskuit', harga: 2500.0, imageAsset: 'assets/images/Biskuat.jpeg'),
              MenuItem(nama: 'Es Krim', harga: 8000.0, imageAsset: 'assets/images/EsKrim.jpeg'),
              MenuItem(nama: 'Coklat', harga: 20000.0, imageAsset: 'assets/images/Coklat.jpeg'),
            ],
            imageAsset: 'assets/images/Kantin Bu Sri.jpg',
          ),
          KantinTile(
            nama: 'Kantin Bu Yuli',
            deskripsi: 'Menyediakan Makanan dan Minuman.',
            menu: [
              MenuItem(nama: 'Es Teh', harga: 3000.0, imageAsset: 'assets/images/EsTeh.jpeg'),
              MenuItem(nama: 'Ayam Goreng', harga: 15000.0, imageAsset: 'assets/images/AyamGoreng.jpeg'),
              MenuItem(nama: 'Geprek', harga: 18000.0, imageAsset: 'assets/images/Geprek.jpeg'),
            ],
            imageAsset: 'assets/images/Kantin Bu Yuli.jpg',
          ),
          KantinTile(
            nama: 'Kantin Pak Ahmad',
            deskripsi: 'Menyediakan Soto dan Wifi Gratis.',
            menu: [
              MenuItem(nama: 'Es Teh', harga: 3000.0, imageAsset: 'assets/images/EsTeh.jpeg'),
              MenuItem(nama: 'Soto Madura', harga: 15000.0, imageAsset: 'assets/images/SotoMadura.jpeg'),
              MenuItem(nama: 'Soto Banyumas', harga: 16000.0, imageAsset: 'assets/images/SotoBanyumas.jpeg'),
            ],
            imageAsset: 'assets/images/Kantin Pak Ahmad.jpg',
          ),
        ],
      ),
    );
  }
}

class KantinTile extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final List<MenuItem> menu;
  final String imageAsset;

  const KantinTile({
    Key? key,
    required this.nama,
    required this.deskripsi,
    required this.menu,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailKantin(
                nama: nama,
                deskripsi: deskripsi,
                menu: menu,
                imageAsset: imageAsset,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imageAsset,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deskripsi,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailKantin extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final List<MenuItem> menu;
  final String imageAsset;

  const DetailKantin({
    Key? key,
    required this.nama,
    required this.deskripsi,
    required this.menu,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nama,
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 165, 0),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              deskripsi,
              style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DaftarMenuPesanan(menu: menu),
                  ),
                );
              },
              child: const Text('Lihat Menu'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 165, 0),
                textStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
