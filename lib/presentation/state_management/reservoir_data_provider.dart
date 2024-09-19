// lib/presentation/state_management/reservoir_data_provider.dart

import 'package:flutter/material.dart';
import '../../domain/entities/reservoir_entity.dart';
import '../../domain/usecases/fetch_reservoir_data_usecase.dart';
import '../../domain/usecases/save_reservoir_data_usecase.dart';

class ReservoirDataProvider extends ChangeNotifier {
  final FetchReservoirDataUseCase fetchUseCase;
  final SaveReservoirDataUseCase saveUseCase;

  GridObject? _reservoirData;
  bool _isLoading = false;
  String? _errorMessage;

  ReservoirDataProvider({
    required this.fetchUseCase,
    required this.saveUseCase,
  });

  GridObject? get reservoirData => _reservoirData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Fetches the reservoir data and updates the state
  Future<void> fetchReservoirData() async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final data = await fetchUseCase.execute();
      if (data != null) {
        _reservoirData = data;
      } else {
        _setErrorMessage('No data available.');
      }
    } catch (e) {
      _setErrorMessage('Failed to fetch data: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Saves the reservoir data and updates the state
  Future<void> saveReservoirData(GridObject data) async {
    if (!validateData(data)) {
      _setErrorMessage('Invalid data. Please check the inputs.');
      return;
    }

    _setLoading(true);
    _setErrorMessage(null);

    try {
      await saveUseCase.execute(data);
      _reservoirData = data;  // Update local state after saving
    } catch (e) {
      _setErrorMessage('Failed to save data: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Validates the reservoir data.
  bool validateData(GridObject data) {
    // Implement any validation logic as required
    if (data.nx <= 0 || data.ny <= 0 || data.nz <= 0) {
      return false;
    }
    return true;
  }

  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
