// lib/core/utils/grid_utils.dart

import 'dart:typed_data';

/// Converts a grid coordinate to a 1D index for accessing data in a 1D array.
int gridToIndex(int x, int y, int z, int nx, int ny) {
  return x + nx * (y + ny * z);
}

/// Initializes a 3D list for corner-point grid data.
List<List<List<double>>> initialize3DGrid(int nx, int ny, int nz) {
  return List.generate(nx + 1,
          (i) => List.generate(ny + 1, (j) => List.generate(nz + 1, (k) => 0.0)));
}

/// Converts a list of doubles to bytes for serialization.
Uint8List doubleListToBytes(List<double> doubleList) {
  final byteData = ByteData(doubleList.length * 8);
  for (int i = 0; i < doubleList.length; i++) {
    byteData.setFloat64(i * 8, doubleList[i], Endian.little);
  }
  return byteData.buffer.asUint8List();
}

/// Converts bytes back to a list of doubles.
List<double> bytesToDoubleList(Uint8List byteArray) {
  final byteData = ByteData.sublistView(byteArray);
  List<double> doubleList = [];
  for (int i = 0; i < byteData.lengthInBytes; i += 8) {
    doubleList.add(byteData.getFloat64(i, Endian.little));
  }
  return doubleList;
}
