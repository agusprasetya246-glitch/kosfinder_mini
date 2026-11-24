import 'package:flutter/material.dart';

void main() {
  runApp(const KosFinderApp());
}

class Kos {
  const Kos({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.harga,
  });

  final int id;
  final String nama;
  final String lokasi;
  final int harga;
}

const List<Kos> dummyKos = [
  Kos(id: 1, nama: 'Melati', lokasi: 'Singaraja', harga: 850000),
  Kos(id: 2, nama: 'Mawar', lokasi: 'Sukasada', harga: 1200000),
  Kos(id: 3, nama: 'Anggrek', lokasi: 'Banjar', harga: 950000),
  Kos(id: 4, nama: 'Kenanga', lokasi: 'Seririt', harga: 1500000),
  Kos(id: 5, nama: 'Flamboyan', lokasi: 'Sawan', harga: 750000),
  Kos(id: 6, nama: 'Dahlia', lokasi: 'Kubutambahan', harga: 1100000),
];

String formatHargaPerBulan(int harga) {
  final digits = harga.toString();
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    buffer.write(digits[i]);
    final remaining = digits.length - 1 - i;
    if (remaining > 0 && remaining % 3 == 0) {
      buffer.write('.');
    }
  }

  return 'Rp $buffer / bulan';
}

class KosFinderApp extends StatelessWidget {
  const KosFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KosFinder Mini',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const KosListPage(),
    );
  }
}

class KosListPage extends StatelessWidget {
  const KosListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KosFinder Mini')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: dummyKos.length,
        itemBuilder: (context, index) {
          final kos = dummyKos[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kos.nama,
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Lokasi: ${kos.lokasi}'),
                  const SizedBox(height: 4),
                  Text(formatHargaPerBulan(kos.harga)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
