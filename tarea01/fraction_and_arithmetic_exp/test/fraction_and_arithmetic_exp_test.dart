import 'package:test/test.dart';
import 'package:fraction_and_arithmetic_exp/fraction.dart';

/// Unit tests
void main() {
  test('Fraction constructor with integers', () {
    var fraction = Fraction(5, 9);
    expect(fraction.toString(), '5/9');
  });

  test('Fraction constructor from double', () {
    var fraction = Fraction.fromDouble(1.5);
    expect(fraction.toString(), '3/2');
  });

  test('Fraction constructor from string', () {
    var fraction = Fraction.fromString('345/753');
    expect(fraction.toString(), '115/251');
  });

  test('Fraction constructor from JSON', () {
    var fraction = Fraction.fromJson({"numerator": 12, "denominator": 4});
    expect(fraction.toString(), '3/1');
  });

  test('Fraction constructor from BigInt', () {
    var fraction = Fraction.fromBigInt(
      BigInt.parse("11111111111111111111111111111111111111111111111"),
      BigInt.parse("99999999999999999999999999999999999999999999999"),
    );
    expect(
        fraction.toString(),
        '11111111111111111111111111111111111111111111111/'
        '99999999999999999999999999999999999999999999999');
  });

  test('Fraction addition', () {
    var f1 = Fraction(5, 9);
    var f2 = Fraction(1, 3);
    var result = f1 + f2;
    expect(result.toString(), '14/9');
  });

  test('Fraction toNum', () {
    var fraction = Fraction(3, 2);
    expect(fraction.toNum(), 1.5);
  });
}
