// lib/domain/usecases/save_reservoir_data_usecase.dart

import 'dart:async';
import '../repositories/reservoir_repository.dart';  // Relative import
import '../entities/reservoir_entity.dart';  // Relative import

class SaveReservoirDataUseCase {
  final ReservoirRepository repository;

  SaveReservoirDataUseCase(this.repository);

  Future<void> execute(GridObject data) async {
    await repository.saveReservoirData(data);
  }
}
