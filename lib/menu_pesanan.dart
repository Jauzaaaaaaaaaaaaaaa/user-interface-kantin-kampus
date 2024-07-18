import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kantin/kantin.dart';

// Definisi MenuItem dipindahkan ke sini
class Invoice {
  final List<CartItem> items;
  final double totalHarga;

  Invoice({required this.items, required this.totalHarga});
}

class MenuItem {
  final String nama;
  final double harga;
  final String imageAsset;

  MenuItem({
    required this.nama,
    required this.harga,
    required this.imageAsset,
  });
}

class DaftarMenuPesanan extends StatefulWidget {
  final List<MenuItem> menu;

  const DaftarMenuPesanan({Key? key, required this.menu}) : super(key: key);

  @override
  _DaftarMenuPesananState createState() => _DaftarMenuPesananState();
}

class _DaftarMenuPesananState extends State<DaftarMenuPesanan> {
  List<CartItem> keranjang = [];
  int jumlahPesanan = 0;

  void tambahKeKeranjang(MenuItem item) {
    setState(() {
      // Cek apakah item sudah ada di keranjang
      if (!keranjang.any((element) => element.item.nama == item.nama)) {
        keranjang.add(CartItem(item: item, jumlah: 1));
      } else {
        // Jika sudah ada, tambahkan jumlah pesanan
        int index =
            keranjang.indexWhere((element) => element.item.nama == item.nama);
        keranjang[index].jumlah++;
      }
      jumlahPesanan++;
    });
  }

  void tambahSatu(CartItem item) {
    setState(() {
      // Cari index item yang ingin ditambah
      int index = keranjang.indexOf(item);
      keranjang[index].jumlah++;
      jumlahPesanan++;
    });
  }

  void kurangiSatu(CartItem item) {
    setState(() {
      // Cari index item yang ingin dikurangi
      int index = keranjang.indexOf(item);
      keranjang[index].jumlah--;
      jumlahPesanan--;

      // Jika jumlah pesanan mencapai 0, hapus dari keranjang
      if (keranjang[index].jumlah == 0) {
        keranjang.removeAt(index);
      }
    });
  }

  void konfirmasiPesan() {
    // Menghitung total harga pesanan
    double totalHarga = keranjang.fold(
        0, (sum, item) => sum + item.item.harga * item.jumlah);

    // Membuat objek Invoice
    Invoice invoice = Invoice(items: keranjang, totalHarga: totalHarga);

    // Navigasi ke halaman invoice
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoicePage(invoice: invoice),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Menu', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: const Color.fromARGB(255, 255, 165, 0), // Ubah ke oranye
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              itemCount: widget.menu.length,
              itemBuilder: (context, index, realIndex) {
                final item = widget.menu[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        child: Image.asset(
                          item.imageAsset,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.nama,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Harga: Rp${item.harga}',
                              style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => tambahKeKeranjang(item),
                              child: const Text('Tambah ke Keranjang'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 255, 165, 0), // Ubah ke oranye
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
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                height: 400,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 0,
                autoPlay: true,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: const Color.fromARGB(255, 255, 165, 0), // Ubah ke oranye
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pesanan: $jumlahPesanan',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KeranjangPesanan(
                        keranjang: keranjang,
                        tambahSatu: tambahSatu,
                        kurangiSatu: kurangiSatu,
                      ),
                    ),
                  );
                },
                child: const Text('Keranjang'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 165, 0), // Ubah ke oranye
                  backgroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KeranjangPesanan extends StatefulWidget {
  final List<CartItem> keranjang;
  final Function(CartItem) tambahSatu;
  final Function(CartItem) kurangiSatu;

  const KeranjangPesanan({
    Key? key,
    required this.keranjang,
    required this.tambahSatu,
    required this.kurangiSatu,
  }) : super(key: key);

  @override
  _KeranjangPesananState createState() => _KeranjangPesananState();
}

class _KeranjangPesananState extends State<KeranjangPesanan> {
  void konfirmasiPesan() {
    // Menghitung total harga pesanan
    double totalHarga = widget.keranjang.fold(
        0, (sum, item) => sum + item.item.harga * item.jumlah);

    // Membuat objek Invoice
    Invoice invoice = Invoice(items: widget.keranjang, totalHarga: totalHarga);

    // Navigasi ke halaman invoice
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoicePage(invoice: invoice),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalHarga = widget.keranjang.fold(
        0, (sum, item) => sum + item.item.harga * item.jumlah);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Pesanan', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: const Color.fromARGB(255, 255, 165, 0), // Ubah ke oranye
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
                  leading: Image.asset(item.item.imageAsset,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(item.item.nama,
                      style: const TextStyle(fontFamily: 'Poppins')),
                  subtitle: Text('Rp${item.item.harga} x ${item.jumlah}',
                      style: const TextStyle(fontFamily: 'Poppins')),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => widget.kurangiSatu(item),
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        item.jumlah.toString(), // Menampilkan jumlah item
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      IconButton(
                        onPressed: () => widget.tambahSatu(item),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total: Rp$totalHarga',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: konfirmasiPesan,
                  child: const Text('Konfirmasi Pesan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 165, 0), // Ubah ke oranye
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
        ],
      ),
    );
  }
}

class InvoicePage extends StatelessWidget {
  final Invoice invoice;

  const InvoicePage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: const Color.fromARGB(255, 255, 165, 0), // Ubah ke oranye
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: invoice.items.length,
              itemBuilder: (context, index) {
                final item = invoice.items[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jumlah: ${item.jumlah}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                'Total Menu: Rp${item.item.harga * item.jumlah}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Menu: ${item.item.nama}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Harga per Menu: Rp${item.item.harga}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Divider(),
                Text(
                  'Total Pembayaran: Rp${invoice.totalHarga}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DaftarKantinKampus(),
                      ),
                    );
                  },
                  child: const Text('Kembali ke Daftar Kantin'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 165, 0), // Ubah ke oranye
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
        ],
      ),
    );
  }
}

class CartItem {
  final MenuItem item;
  int jumlah;

  CartItem({
    required this.item,
    this.jumlah = 1,
  });
}
