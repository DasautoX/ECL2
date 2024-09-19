// lib/data/datasources/remote/api_data_source.dart

import 'dart:convert';  // For JSON encoding/decoding
import 'package:http/http.dart' as http;  // Import the HTTP package
import '../../../domain/entities/reservoir_entity.dart';  // Import the entity

/// Remote data source for fetching reservoir data from an API.
class ApiDataSource {
  final String baseUrl;

  ApiDataSource(this.baseUrl);

  /// Fetches reservoir data from a remote API.
  Future<GridObject> fetchReservoirData() async {
    final response = await http.get(Uri.parse('$baseUrl/reservoir_data'));

    if (response.statusCode == 200) {
      // Parse JSON to GridObject
      return GridObject.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load reservoir data');
    }
  }

  /// Sends reservoir data to a remote API.
  Future<void> sendReservoirData(GridObject data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reservoir_data'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),  // Convert GridObject to JSON
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send reservoir data');
    }
  }
}
