// lib/domain/usecases/fetch_reservoir_data_usecase.dart

import 'dart:async';
import '../repositories/reservoir_repository.dart';  // Relative import
import '../entities/reservoir_entity.dart';  // Relative import

class FetchReservoirDataUseCase {
  final ReservoirRepository repository;

  FetchReservoirDataUseCase(this.repository);

  Future<GridObject> execute() async {
    return await repository.fetchReservoirData();
  }
}
