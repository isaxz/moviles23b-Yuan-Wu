import 'dart:math' as math;

/// Clase que representa una fracción.
/// Puedes crear una fracción utilizando varios constructores y realizar
/// operaciones aritméticas y comparaciones con fracciones.
class Fraction {
  late int numerator;
  late int denominator;

  Fraction(this.numerator, this.denominator) {
    simplify();
  }

  /// Conversión desde double a fracción
  Fraction.fromDouble(double value, {int precision = 6}) {
    final multiplier = math.pow(10, precision).toInt();
    final roundedValue = (value * multiplier).round();
    numerator = roundedValue;
    denominator = multiplier;
    simplify();
  }

  /// Conversión desde String a fracción
  Fraction.fromString(String value) {
    final parts = value.split('/');
    if (parts.length != 2) {
      throw FormatException('String does not represent a valid fraction: $value');
    }
    numerator = int.parse(parts[0]);
    denominator = int.parse(parts[1]);
    if (denominator == 0) {
      throw ArgumentError('Denominator cannot be zero.');
    }
    simplify();
  }

  /// Conversión desde Json a fracción
  Fraction.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('numerator') || !json.containsKey('denominator')) {
      throw const FormatException('JSON object does not contain required fields.');
    }
    numerator = json['numerator'];
    denominator = json['denominator'];
    if (denominator == 0) {
      throw ArgumentError('Denominator cannot be zero.');
    }
    simplify();
  }

  /// Conversión desde BigInt a fracción
  Fraction.fromBigInt(BigInt numerator, BigInt denominator) {
    this.numerator = numerator.toInt();
    this.denominator = denominator.toInt();
    if (this.denominator == 0) {
      throw ArgumentError('Denominator cannot be zero.');
    }
    simplify();
  }

  /// Simplifica la fracción
  void simplify() {
    final gcd = _calculateGCD(numerator.abs(), denominator);
    numerator ~/= gcd;
    denominator ~/= gcd;
    if (denominator < 0) {
      numerator = -numerator;
      denominator = -denominator;
    }
  }

  /// Calcula máximo común divisor
  int _calculateGCD(int a, int b) {
    if (b == 0) {
      return a;
    }
    return _calculateGCD(b, a % b);
  }

  /// Operador + sobrecargado para sumar fracciones
  Fraction operator +(Fraction other) {
    final commonDenominator = (denominator * other.denominator) ~/ _calculateGCD(denominator, other.denominator);
    final newNumerator = (numerator * (commonDenominator ~/ denominator)) +
        (other.numerator * (commonDenominator ~/ other.denominator));
    return Fraction(newNumerator, commonDenominator);
  }

  /// Operador - sobrecargado para restar fracciones
  Fraction operator -(Fraction other) {
    final commonDenominator = (denominator * other.denominator) ~/ _calculateGCD(denominator, other.denominator);
    final newNumerator = (numerator * (commonDenominator ~/ denominator)) -
        (other.numerator * (commonDenominator ~/ other.denominator));
    return Fraction(newNumerator, commonDenominator);
  }

  /// Operador * sobrecargado para multiplicar fracciones
  Fraction operator *(Fraction other) {
    return Fraction(numerator * other.numerator, denominator * other.denominator);
  }

  /// Operador / sobrecargado para dividir fracciones
  Fraction operator /(Fraction other) {
    if (other.numerator == 0) {
      throw ArgumentError('Cannot divide by zero.');
    }
    return Fraction(numerator * other.denominator, denominator * other.numerator);
  }

  /// Operador < (menor a) sobrecargado para comparar fracciones
  bool operator <(Fraction other) {
    final commonDenominator = (denominator * other.denominator) ~/ _calculateGCD(denominator, other.denominator);
    final thisNumerator = numerator * (commonDenominator ~/ denominator);
    final otherNumerator = other.numerator * (commonDenominator ~/ other.denominator);
    return thisNumerator < otherNumerator;
  }

  /// Operador < (menor o igual a) sobrecargado para comparar fracciones
  bool operator <=(Fraction other) {
    return numerator * other.denominator <= other.numerator * denominator;
  }

/// Operador == (igual a) sobrecargado para comparar fracciones
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Fraction &&
        numerator == other.numerator &&
        denominator == other.denominator;
  }

  @override
  int get hashCode => numerator.hashCode ^ denominator.hashCode;

  /// Operador >= (mayor o igual a) sobrecargado para comparar fracciones
  bool operator >=(Fraction other) {
    return this > other || this == other;
  }

  /// Operador > (mayor) sobrecargado para comparar fracciones
  bool operator >(Fraction other) {
    final commonDenominator = (denominator * other.denominator) ~/ _calculateGCD(denominator, other.denominator);
    final thisNumerator = numerator * (commonDenominator ~/ denominator);
    final otherNumerator = other.numerator * (commonDenominator ~/ other.denominator);
    return thisNumerator > otherNumerator;
  }

  /// Conversión desde Fraction a int
  int toInt() {
    if (denominator != 1) {
      throw StateError('Fraction is not a whole number.');
    }
    return numerator;
  }

  /// Conversión desde Fraction a double
  double toDouble() {
    return numerator.toDouble() / denominator.toDouble();
  }

  /// Conversión desde Fraction a String
  @override
  String toString() {
    return '$numerator/$denominator';
  }

  /// Método para calcular la exponencial de un Fraction
  Fraction pow(int exponent) {
    if (exponent < 0) {
      throw ArgumentError('Exponent must be non-negative.');
    }
    return Fraction(math.pow(numerator.toDouble(), exponent).toInt(), math.pow(denominator.toDouble(), exponent).toInt());
  }

  /// Determina si Fraction es propio
  bool get isProper {
    return numerator.abs() < denominator;
  }

/// Determina si Fraction es impropio
  bool get isImproper {
    return numerator.abs() >= denominator;
  }

  /// Comprueba si el número es entero
  bool get isWhole {
    return numerator % denominator == 0;
  }

  /// Conversión desde Fraction a num
  num toNum() {
    return numerator / denominator;
  }
}
