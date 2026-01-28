import 'dart:io';

void main(){
  stdout.write('Masukkan sebuah angka: ');
  int input = int.parse(stdin.readLineSync()!);
  int totalpembagi = 0;

  for (var i = 1; i < input; i++) {
    if (input % i == 0) {
      totalpembagi += i;

    }
  }

  if (totalpembagi == input) {
    print('$input adalah bilangan sempurna');
  } else {
    print('$input bukan bilangan sempurna');
  }
}