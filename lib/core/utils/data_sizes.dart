// lib/core/utils/data_sizes.dart

import 'dart:typed_data';  // Import added for Uint8List, ByteData, and Endian

/// Static sizes for various reservoir data types.
const Map<String, int> staticItemSizes = {
  'INTE': 4,   // Integer (4 bytes)
  'REAL': 4,   // Real number (4 bytes)
  'LOGI': 4,   // Logical (4 bytes)
  'DOUB': 8,   // Double precision (8 bytes)
  'CHAR': 8,   // Character (8 bytes)
  // Add more types as needed...
};

/// Returns the size (in bytes) for a given reservoir data type.
/// This is equivalent to the `item_size()` function in Python.
int itemSize(String typeKeyword) {
  if (typeKeyword.startsWith('C0')) {
    // Variable-length ASCII string type (e.g., C020, C030)
    return int.parse(typeKeyword.substring(2));
  } else {
    // Fixed-width types
    return staticItemSizes[typeKeyword] ?? 0;
  }
}

/// Returns the length of element groups in unformatted arrays based on the type keyword.
/// This is equivalent to the `group_length()` function in Python.
int groupLength(String typeKeyword) {
  if (typeKeyword.startsWith('C')) {
    return 105;  // For character types
  } else {
    return 1000; // Default for other types
  }
}

/// Computes the total number of bytes needed to store an array of a given type and length.
/// This is equivalent to the `bytes_in_array()` function in Python.
int bytesInArray(int arrayLength, String itemType) {
  int fullGroups = arrayLength ~/ groupLength(itemType);
  int remainder = arrayLength % groupLength(itemType);
  return fullGroups * groupLength(itemType) * itemSize(itemType) +
      remainder * itemSize(itemType);
}

/// Utility function to parse byte data and extract integer values.
/// Equivalent to the `int_from_bytes()` function from Python.
int intFromBytes(List<int> byteArray) {
  final buffer = Uint8List.fromList(byteArray).buffer;
  final byteData = ByteData.view(buffer);
  return byteData.getInt32(0, Endian.big);
}
