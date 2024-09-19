// lib/data/datasources/local/file_data_source.dart

import 'dart:async';
import 'dart:convert';  // Import for JSON encoding/decoding
import 'dart:io';  // For file handling
import 'package:path_provider/path_provider.dart';  // For file paths
import '../../../domain/entities/reservoir_entity.dart';  // Corrected relative import

/// Local data source for reading and writing reservoir data to files.
class FileDataSource {
  Future<GridObject> readReservoirData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/reservoir_data.json');
    if (await file.exists()) {
      final contents = await file.readAsString();
      return GridObject.fromJson(jsonDecode(contents)); // Ensure fromJson exists
    } else {
      throw Exception('File not found');
    }
  }

  Future<void> writeReservoirData(GridObject data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/reservoir_data.json');
    await file.writeAsString(jsonEncode(data.toJson())); // Ensure toJson exists
  }
}
