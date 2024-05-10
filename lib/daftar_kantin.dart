import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DaftarKantinKampus(),
  ));
}

class DaftarKantinKampus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Kantin Kampus',
          style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 158, 79, 50),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 1,
        children: [
          KantinTile(
            nama: 'Kantin Bu Sri',
            deskripsi: 'Menyediakan Makanan ringan dan Snack.',
            menu: ['Biskuat', 'Es Krim', 'Coklat'],
            imageAsset: 'assets/images/Kantin Bu Sri.jpg',
          ),
          KantinTile(
            nama: 'Kantin Bu Yuli',
            deskripsi: 'Menyediakan Makanan dan Minuman.',
            menu: ['Es Teh', 'Ayam Goreng', 'Geprek'],
            imageAsset: 'assets/images/Kantin Bu Yuli.jpg',
          ),
          KantinTile(
            nama: 'Kantin Pak Ahmad',
            deskripsi: 'Menyediakan Soto dan Wifi Gratis.',
            menu: ['Es Teh', 'Soto Madura', 'Soto Banyumas'],
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
  final List<String> menu;
  final String imageAsset;

  KantinTile(
      {required this.nama,
      required this.deskripsi,
      required this.menu,
      required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailKantin(
                  nama: nama,
                  deskripsi: deskripsi,
                  menu: menu,
                  imageAsset: imageAsset),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                nama,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 8),
              Text(
                deskripsi,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailKantin extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final List<String> menu;
  final String imageAsset;

  DetailKantin(
      {required this.nama,
      required this.deskripsi,
      required this.menu,
      required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nama, style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: const Color.fromARGB(255, 158, 79, 50),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 8),
            Text(
              deskripsi,
              style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DaftarMenuPesanan(menu: menu),
                  ),
                );
              },
              child: Text('Lihat Menu'),
            ),
          ],
        ),
      ),
    );
  }
}

class DaftarMenuPesanan extends StatefulWidget {
  final List<String> menu;

  DaftarMenuPesanan({required this.menu});

  @override
  _DaftarMenuPesananState createState() => _DaftarMenuPesananState();
}

class _DaftarMenuPesananState extends State<DaftarMenuPesanan> {
  List<MenuItem> keranjang = [];
  int jumlahPesanan = 0;

  List<double> hargaMenu = [2000.0, 10000.0, 15000.0];

  @override
  Widget build(BuildContext context) {
    List<String> reversedMenu = List.from(widget.menu.reversed);
    List<double> reversedHargaMenu = List.from(hargaMenu.reversed);

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Menu', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: const Color.fromARGB(255, 158, 79, 50),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: reversedMenu.length,
        itemBuilder: (context, index) {
          final menu = reversedMenu[index];
          final menuItem =
              MenuItem(nama: menu, harga: reversedHargaMenu[index]);
          return ListTile(
            title: Text(menu, style: TextStyle(fontFamily: 'Poppins')),
            subtitle: Text(
                'Harga: Rp${reversedHargaMenu[index].toStringAsFixed(0)}',
                style: TextStyle(fontFamily: 'Poppins')),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  keranjang.add(menuItem);
                  jumlahPesanan++;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$menu ditambahkan ke keranjang.'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JumlahPesanan(
                jumlahPesanan: jumlahPesanan,
                keranjang: keranjang,
              ),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class MenuItem {
  final String nama;
  final double harga;

  MenuItem({required this.nama, required this.harga});
}

class JumlahPesanan extends StatefulWidget {
  final int jumlahPesanan;
  final List<MenuItem> keranjang;

  JumlahPesanan({required this.jumlahPesanan, required this.keranjang});

  @override
  _JumlahPesananState createState() => _JumlahPesananState();
}

class _JumlahPesananState extends State<JumlahPesanan> {
  String _metodePembayaran = 'COD';

  @override
  Widget build(BuildContext context) {
    double totalHarga = 0;

    for (var item in widget.keranjang) {
      totalHarga += item.harga;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Jumlah Pesanan', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: const Color.fromARGB(255, 158, 79, 50),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.keranjang.length,
              itemBuilder: (context, index) {
                final item = widget.keranjang[index];
                return ListTile(
                  title: Text(item.nama, style: TextStyle(fontFamily: 'Poppins')),
                  subtitle: Text('Harga: Rp${item.harga.toStringAsFixed(0)}',
                      style: TextStyle(fontFamily: 'Poppins')),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total Pesanan: ${widget.jumlahPesanan}',
                  style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                ),
                SizedBox(height: 8),
                Text(
                  'Total Harga: Rp${totalHarga.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                ),
                SizedBox(height: 16),
                Text(
                  'Metode Pembayaran:',
                  style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                ),
                DropdownButton<String>(
                  value: _metodePembayaran,
                  onChanged: (String? newValue) {
                    setState(() {
                      _metodePembayaran = newValue!;
                    });
                  },
                  items: <String>['COD', 'Pembayaran Online']
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontFamily: 'Poppins')),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 8),
                if (_metodePembayaran == 'COD') ...[
                  Text(
                    'Pesanan akan dibayar di muka',
                    style: TextStyle(fontSize: 15, color: Colors.grey, fontFamily: 'Poppins'),
                  ),
                ] else if (_metodePembayaran == 'Pembayaran Online') ...[
                  Text(
                    'Pesanan akan dibayar melalui aplikasi',
                    style: TextStyle(fontSize: 15, color: Colors.grey, fontFamily: 'Poppins'),
                  ),
                ],
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProsesPemesanan(
                          metodePembayaran: _metodePembayaran,
                        ),
                      ),
                    );
                  },
                  child: Text('Pesan Sekarang'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProsesPemesanan extends StatelessWidget {
  final String metodePembayaran;

  ProsesPemesanan({required this.metodePembayaran});

  @override
  Widget build(BuildContext context) {
    String pesan;

    if (metodePembayaran == 'COD') {
      pesan = 'Pesanan Anda akan siap diambil!';
    } else {
      pesan = 'Pesanan Anda akan dikirim!';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Proses Pemesanan', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: const Color.fromARGB(255, 158, 79, 50),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'PROSES PEMESANAN',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 10),
              Text(
                pesan,
                style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DaftarKantinKampus(),
                    ),
                  );
                },
                child: Text('Kembali ke Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
