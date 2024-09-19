// lib/data/repositories/reservoir_repository_impl.dart

import 'dart:async';
import '../../domain/repositories/reservoir_repository.dart';  // Corrected import path
import '../../domain/entities/reservoir_entity.dart';  // Corrected import path
import '../datasources/local/file_data_source.dart';  // Corrected import path
import '../datasources/remote/api_data_source.dart';  // Corrected import path

/// Concrete implementation of the ReservoirRepository interface.
class ReservoirRepositoryImpl implements ReservoirRepository {
  final FileDataSource localDataSource;
  final ApiDataSource remoteDataSource;

  ReservoirRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<GridObject> fetchReservoirData() async {
    try {
      return await localDataSource.readReservoirData();
    } catch (e) {
      return await remoteDataSource.fetchReservoirData();
    }
  }

  @override
  Future<void> saveReservoirData(GridObject data) async {
    await localDataSource.writeReservoirData(data);
  }
}
