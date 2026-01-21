void main() {
  List<int> a = [1, 3, 5, 7];
  List<int> b = [2, 4, 6, 8];
  List<int> gabungan = [...a, ...b];
  
  int max = gabungan[0];
  int secondMax = gabungan[0];

  for (var angka in gabungan) {
    if (angka > max) {
      secondMax = max;
      max = angka;
    } else if (angka > secondMax && angka != max) {
      secondMax = angka;
    }
  }

  print('Daftar gabungan: $gabungan');
  print('Nilai terbesar kedua: $secondMax');
}