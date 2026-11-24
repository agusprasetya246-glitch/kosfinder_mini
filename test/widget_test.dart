import 'package:flutter_test/flutter_test.dart';

import 'package:kosfinder_mini/main.dart';

void main() {
  testWidgets('Menampilkan judul dan kartu kos pertama', (WidgetTester tester) async {
    await tester.pumpWidget(const KosFinderApp());

    expect(find.text('KosFinder Mini'), findsOneWidget);
    expect(find.text('Kos Melati'), findsOneWidget);
    expect(find.text('Lokasi: Singaraja'), findsOneWidget);
    expect(find.text('Rp 850.000 / bulan'), findsOneWidget);
  });
}
