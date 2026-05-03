/// ─────────────────────────────────────────────────────────────
/// JSON TYPE CONVERTER
/// Handles all type casting and conversion safely.
/// Supports auto-casting between compatible types.
///
/// Usage:
///   final value = JsonTypeConverter.convert<int>(rawValue, key: 'age');
/// ─────────────────────────────────────────────────────────────

import 'json_exception.dart';

class JsonTypeConverter {
  JsonTypeConverter._(); // prevent instantiation — static only

  /// Converts [value] to type [T] safely.
  /// Handles common implicit conversions automatically.
  ///
  /// Supported auto-conversions:
  ///   num   → int
  ///   num   → double
  ///   int   → double
  ///   bool  → String  ('true' / 'false')
  ///   int   → String
  ///   double → String
  ///
  /// Throws [JsonTypeMismatchException] if conversion is not possible.
  static T convert<T>(dynamic value, {required String key}) {
    if (value == null) {
      if (null is T) return null as T;
      throw JsonTypeMismatchException(
        key: key,
        expected: T.toString(),
        actual: 'null',
      );
    }

    // already the correct type
    if (value is T) return value;

    // ── num → int ──────────────────────────────────────────────
    if (T == int && value is num) return value.toInt() as T;

    // ── num → double ───────────────────────────────────────────
    if (T == double && value is num) return value.toDouble() as T;

    // ── int → double ───────────────────────────────────────────
    if (T == double && value is int) return value.toDouble() as T;

    // ── anything → String ──────────────────────────────────────
    if (T == String) return value.toString() as T;

    // ── String → int ───────────────────────────────────────────
    if (T == int && value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) return parsed as T;
    }

    // ── String → double ────────────────────────────────────────
    if (T == double && value is String) {
      final parsed = double.tryParse(value);
      if (parsed != null) return parsed as T;
    }

    // ── String → bool ──────────────────────────────────────────
    if (T == bool && value is String) {
      if (value.toLowerCase() == 'true') return true as T;
      if (value.toLowerCase() == 'false') return false as T;
    }

    // ── int → bool (0 = false, 1 = true) ──────────────────────
    if (T == bool && value is int) {
      return (value == 1) as T;
    }

    throw JsonTypeMismatchException(
      key: key,
      expected: T.toString(),
      actual: value.runtimeType.toString(),
    );
  }
}