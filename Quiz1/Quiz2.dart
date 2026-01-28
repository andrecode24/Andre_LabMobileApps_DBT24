import 'dart:io';
import 'dart:math';

void main() {
  final random = Random();
  final choices = ['batu', 'kertas', 'gunting'];
  
  print('=== GAME GUNTING BATU KERTAS ===');
  print('Pilihan: batu, kertas, gunting');
  print('');
  
  while (true) {
    final computerChoice = choices[random.nextInt(3)];
  
    stdout.write('Masukkan pilihan Anda (batu/kertas/gunting) atau "keluar": ');
    final userInput = stdin.readLineSync()?.toLowerCase() ?? '';
    
    if (userInput == 'keluar') {
      print('Terima kasih sudah bermain!');
      break;
    }

    if (!choices.contains(userInput)) {
      print('Pilihan tidak valid! Coba lagi.\n');
      continue;
    }

    print('Anda memilih: $userInput');
    print('Komputer memilih: $computerChoice');
    
   
    if (userInput == computerChoice) {
      print('keSERI!');
    } else if (
        (userInput == 'batu' && computerChoice == 'gunting') ||
        (userInput == 'kertas' && computerChoice == 'batu') ||
        (userInput == 'gunting' && computerChoice == 'kertas')
    ) {
      print('ANDA MENANG!');
    } else {
      print('KOMPUTER MENANG!');
    }
  }
}