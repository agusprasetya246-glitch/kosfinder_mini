# KosFinder Mini

Aplikasi Flutter sederhana untuk mencari kos, dibuat dengan bantuan GitHub Copilot (vibe coding) pada mata kuliah Pemrograman Mobile.

**Agus Prasetya** · NIM 2415051039 · PTI-5B · Pendidikan Teknik Informatika, Undiksha

## Fitur

- 6 data kos dummy (lokal, tanpa backend dan tanpa package tambahan)
- Kartu kos berisi nama, lokasi, dan harga per bulan (format `Rp 850.000 / bulan`)
- Pencarian nama kos yang tidak peka huruf besar-kecil, dengan tombol clear
- Tombol favorit (ikon hati) per kartu, disimpan sebagai `Set<int>` id di state
- Empty state "Kos tidak ditemukan"

## Menjalankan

```bash
flutter pub get
flutter run -d chrome
```

## Pengujian

```bash
flutter analyze
flutter test
```

| No | Skenario | Expected result |
|----|----------|-----------------|
| 1 | Aplikasi dibuka | 6 data kos terlihat |
| 2 | Cari "mel" | Hanya Kos Melati |
| 3 | Cari "MEL" | Hasil sama (case-insensitive) |
| 4 | Cari "xyz" | Pesan "Kos tidak ditemukan" |
| 5 | Klik favorit dua kali | Ikon on → off |
| 6 | flutter analyze | Tidak ada error analisis |

## Struktur

Seluruh kode aplikasi ada di `lib/main.dart`: model `Kos` (immutable), `KosFinderApp` (MaterialApp), dan `KosListPage` (StatefulWidget) yang menyimpan state pencarian dan favorit. Smoke test ada di `test/widget_test.dart`.

## Penggunaan AI

Kode dibuat bertahap dengan GitHub Copilot di VS Code. Langkahnya: mode Ask untuk perencanaan, lalu mode Agent untuk antarmuka, kemudian pencarian dan favorit, lalu validasi dan perbaikan. Setiap perubahan dari AI direview (Keep/Undo), dijalankan, dan diuji sebelum di-commit.