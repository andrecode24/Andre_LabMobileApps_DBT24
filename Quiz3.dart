import 'dart:io';
import 'dart:math';

void main(){
  final random = Random();
  int randomNumber = random.nextInt(100) + 1; 
  int attempts = 0;
  int guess;
  bool correct = false;

  while (!correct) {
    stdout.write('Masukkan angka tebakan (1-100): ');
    guess = int.parse(stdin.readLineSync()!);
    attempts++;

    if (guess == randomNumber) {
      print('Selamat! Anda  Berhasil menang dalam $attempts tebakan.');
      correct = true;
    } else if (guess < randomNumber) {
      print('Terlalu kecil! Coba lagi.');
    } else {
      print('Terlalu besar! Coba lagi.');
    }
  }
}