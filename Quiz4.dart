import 'dart:io';
import 'dart:math';

void main() {
  stdout.write('Masukkan sebuah angka: ');
  String? input = stdin.readLineSync();
  
  if (input == null) return;
  
  int number = int.parse(input);
  bool isPrime = true;

  
  if (number < 2) {
    isPrime = false;
  } else {

    for (var i = 2; i <= sqrt(number); i++) {
      if (number % i == 0) {
        isPrime = false;
        break;
      }
    }
  }

  if (isPrime) {
    print('$number adalah bilangan prima');
  } else {
    print('$number bukan bilangan prima');
  }
}