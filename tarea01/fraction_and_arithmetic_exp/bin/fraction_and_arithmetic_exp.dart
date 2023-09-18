import 'package:fraction_and_arithmetic_exp/fraction.dart';

void main() {
  var f1 = Fraction(5, 9);
  var f2 = Fraction.fromDouble(1.5);
  var f3 = Fraction.fromString('345/753');

  print('Fracción 1: $f1');
  print('Fracción 2: $f2');
  print('Fracción 3: $f3');

  var sum = f1 + f2;
  var product = f2 * f3;

  print('Suma: $sum');
  print('Producto: $product');
}
