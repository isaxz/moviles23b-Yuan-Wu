import 'dart:math' as math;

/// Class that represent a fraction.
/// You can create a fraction using various consntructors and perform
/// arithmetic operations and comparisons with fractions.
class Fraction {
  late int numerator;
  late int denominator;
  int precision;

  Fraction(this.numerator, this.denominator, {this.precision = 4}) {
    if (denominator == 0) {
      throw FractionException("The denominator cannot be zero.");
    }
    simplify();
  }

  /// Conversion from double to fraction
  Fraction.fromDouble(double value, {this.precision = 4}) {
    final parts = value.toString().split('.');
    final decimals = parts.length > 1 ? parts[1] : '';
    final multiplier = math.pow(10, decimals.length).toInt();
    numerator = (value * multiplier).toInt();
    denominator = multiplier;
    simplify();
  }

  /// Conversión desde String a fracción
  Fraction.fromString(String value, {this.precision = 4}) {
    final parts = value.split('/');
    if (parts.length != 2) {
      throw FractionException('String does not represent a valid fraction: $value');
    }
    numerator = int.parse(parts[0]);
    denominator = int.parse(parts[1]);
    if (denominator == 0) {
      throw FractionException("Denominator cannot be zero");
    }
    simplify();
  }

  /// Conversión desde Json a fracción
  Fraction.fromJson(Map<String, dynamic> json, {this.precision = 4}) {
    if (!json.containsKey('numerator') || !json.containsKey('denominator')) {
      throw const FormatException('JSON object does not contain required fields.');
    }
    numerator = json["numerator"];
    denominator = json["denominator"];
    if (denominator == 0) {
      throw FractionException("Denominator cannot be zero");
    }
    simplify();
  }

  /// Conversion from BigInt to fraction
  Fraction.fromBigInt(BigInt num, BigInt den, {this.precision = 4}) {
    numerator = num.toInt();
    denominator = den.toInt();
    if (denominator == 0) {
      throw FractionException("Denominator cannot be zero");
    }
    simplify();
  }

  /// simplify the fraction
  void simplify() {
    final gcd = _gcd(numerator, denominator);
    numerator ~/= gcd;
    denominator ~/= gcd;
  }

  /// calculate the greatest common divisor
  int _gcd(int a, int b) {
    while (b != 0) {
      final t = b;
      b = a % b;
      a = t;
    }
    return a;
  }

  /// Overloaded + operator for adding fractions
  Fraction operator +(Fraction other) {
    final commonDenominator = denominator * other.denominator;
    final newNumerator = (numerator * other.denominator) + (other.numerator * denominator);
    return Fraction(newNumerator, commonDenominator, precision: precision);
  }

  /// Operator - overloaded for subtracting fractions
  Fraction operator -(Fraction other) {
    final commonDenominator = denominator * other.denominator;
    final newNumerator = (numerator * other.denominator) - (other.numerator * denominator);
    return Fraction(newNumerator, commonDenominator, precision: precision);
  }

  /// Overloaded * operator to multiply fractions
  Fraction operator *(Fraction other) {
    return Fraction(numerator * other.numerator, denominator * other.denominator, precision: precision);
  }

  /// Overloaded / operator for dividing fractions
  Fraction operator /(Fraction other) {
    if (other.numerator == 0) {
      throw FractionException("Cannot divide by zero.");
    }
    return Fraction(numerator * other.denominator, denominator * other.numerator, precision: precision);
  }

  /// Operator < (less than) overloaded to compare fractions
  bool operator <(Fraction other) {
    return numerator * other.denominator < other.numerator * denominator;
  }

/// Operator < (less than or equal to) overloaded to compare fractions
  bool operator <=(Fraction other) {
    return numerator * other.denominator <= other.numerator * denominator;
  }

  /// Operator == (equal to) overloaded to compare fractions
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Fraction && numerator == other.numerator && denominator == other.denominator;
  }

  /// Operator >= (greater than or equal to) overloaded to compare fractions
  bool operator >=(Fraction other) {
    return numerator * other.denominator >= other.numerator * denominator;
  }

  /// Operator > (greater than) overloaded to compare fractions
  bool operator >(Fraction other) {
    return numerator * other.denominator > other.numerator * denominator;
  }

  @override
  int get hashCode => numerator.hashCode ^ denominator.hashCode;

  /// exponential function
  Fraction pow(int exponent) {
    if (exponent < 0) {
      return Fraction.fromBigInt(BigInt.from(denominator).pow(-exponent), BigInt.from(numerator).pow(-exponent));
    } else if (exponent == 0) {
      return Fraction(1, 1);
    } else {
      return Fraction.fromBigInt(BigInt.from(numerator).pow(exponent), BigInt.from(denominator).pow(exponent));
    }
  }

  /// Determine if the fraction is a proper
  bool get isProper => numerator.abs() < denominator;

  /// Determine if the fraction is improper
  bool get isImproper => !isProper;
  bool get isWhole => numerator % denominator == 0;

  /// Determine if the fraction is a num
  num toNum() {
    return numerator / denominator;
  }

  /// Conversion from Fraction to String
  @override
  String toString() {
    return "$numerator/$denominator";
  }
}

extension FractionExtensions on int {
  Fraction toFraction() {
    return Fraction(this, 1);
  }
}

extension DoubleExtensions on double {
  Fraction toFraction({int precision = 4}) {
    return Fraction.fromDouble(this, precision: precision);
  }
}

extension StringExtensions on String {
  Fraction toFraction({int precision = 4}) {
    return Fraction.fromString(this, precision: precision);
  }
}

class FractionException implements Exception {
  final String message;

  FractionException(this.message);

  @override
  String toString() => message;
}
