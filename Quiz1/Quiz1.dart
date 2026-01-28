// Soal 1:
void main() {
  List a = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100];
  List genap = [];

  for (var x in a) {
    if (x % 2 == 0) {
      genap.add(x);
    }
  }

  print(genap); 
}