// lib/core/utils/byte_utils.dart

import 'dart:typed_data';

/// Converts a list of bytes to an integer.
/// This is equivalent to Python's int.from_bytes() with big-endian byte order.
int intFromBytes(Uint8List byteArray) {
  ByteData byteData = ByteData.sublistView(byteArray);
  return byteData.getInt32(0, Endian.big);
}

/// Converts an integer to a list of bytes.
/// Equivalent to Python's to_bytes() method.
Uint8List intToBytes(int value, int length) {
  final buffer = ByteData(length);
  buffer.setInt32(0, value, Endian.big);
  return buffer.buffer.asUint8List();
}

/// Checks if a given byte string represents a character type (e.g., CHAR or C0XX).
bool isCharacterType(String typeStr) {
  final regex = RegExp(r'^(CHAR|C0\d{2})$');
  return regex.hasMatch(typeStr);
}

/// Utility function to check if a given byte string is a valid reservoir data type.
bool isValidType(String typeStr) {
  // Assuming staticItemSizes is a predefined map of valid types and sizes.
  const Map<String, int> staticItemSizes = {
    'INTE': 4,
    'REAL': 4,
    'LOGI': 4,
    'DOUB': 8,
    'CHAR': 8,
    // Add more as needed...
  };

  if (staticItemSizes.containsKey(typeStr)) {
    return true;
  }
  if (RegExp(r'^C0\d{2}$').hasMatch(typeStr)) {
    return true;
  }
  return false;
}
