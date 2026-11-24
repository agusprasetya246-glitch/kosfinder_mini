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
  Kos(id: 1, nama: 'Kos Melati', lokasi: 'Singaraja', harga: 850000),
  Kos(id: 2, nama: 'Kos Mawar', lokasi: 'Sukasada', harga: 1200000),
  Kos(id: 3, nama: 'Kos Anggrek', lokasi: 'Banjar', harga: 950000),
  Kos(id: 4, nama: 'Kos Kenanga', lokasi: 'Seririt', harga: 1500000),
  Kos(id: 5, nama: 'Kos Flamboyan', lokasi: 'Sawan', harga: 750000),
  Kos(id: 6, nama: 'Kos Dahlia', lokasi: 'Kubutambahan', harga: 1100000),
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

class KosListPage extends StatefulWidget {
  const KosListPage({super.key});

  @override
  State<KosListPage> createState() => _KosListPageState();
}

class _KosListPageState extends State<KosListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final Set<int> _favoriteIds = <int>{};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Kos> get _filteredKos {
    final query = _searchQuery.toLowerCase().trim();
    if (query.isEmpty) {
      return dummyKos;
    }
    return dummyKos
        .where((kos) => kos.nama.toLowerCase().contains(query))
        .toList();
  }

  void _toggleFavorite(int id) {
    setState(() {
      if (_favoriteIds.contains(id)) {
        _favoriteIds.remove(id);
      } else {
        _favoriteIds.add(id);
      }
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredKos = _filteredKos;

    return Scaffold(
      appBar: AppBar(title: const Text('KosFinder Mini')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                hintText: 'Cari nama kos...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.trim().isNotEmpty
                    ? IconButton(
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filteredKos.isEmpty
                  ? const Center(child: Text('Kos tidak ditemukan'))
                  : ListView.builder(
                      itemCount: filteredKos.length,
                      itemBuilder: (context, index) {
                        final kos = filteredKos[index];
                        final isFavorite = _favoriteIds.contains(kos.id);

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        kos.nama,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _toggleFavorite(kos.id),
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite ? Colors.red : null,
                                      ),
                                      tooltip: isFavorite
                                          ? 'Hapus ${kos.nama} dari favorit'
                                          : 'Tambah ${kos.nama} ke favorit',
                                    ),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}
