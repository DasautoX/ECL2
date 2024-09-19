// lib/domain/repositories/reservoir_repository.dart

import '../entities/reservoir_entity.dart';

/// Abstract repository interface for accessing reservoir data.
abstract class ReservoirRepository {
  /// Fetches reservoir data.
  Future<GridObject> fetchReservoirData();

  /// Saves reservoir data.
  Future<void> saveReservoirData(GridObject data);
}
