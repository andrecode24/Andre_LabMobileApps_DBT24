import 'dart:io';
void main() {
  Ujian AvgNilai = Ujian();
  stdout.write('rata-rata nilai dari 3 mahasiswa\n');

  for (int i = 1; i <= 3; i++) {
    stdout.write('Masukkan nilai mahasiswa ke-$i: ');
    int nilai = int.parse(stdin.readLineSync()!);
    AvgNilai.tambahNilai(nilai);
  }

  num rataRata = AvgNilai.HitungRataRata();
  print('Rata-rata nilai: $rataRata');

}
class Ujian {
int TotalNilai=0;
int TotalMahasiswa=0;
void tambahNilai(int nilai){
  TotalNilai += nilai;
  TotalMahasiswa ++;
}

num HitungRataRata(){
  if (TotalMahasiswa == 0) {
    return 0; 
  }
  return TotalNilai / TotalMahasiswa;

}







}