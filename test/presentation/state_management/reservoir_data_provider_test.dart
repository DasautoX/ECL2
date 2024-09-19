// test/presentation/state_management/reservoir_data_provider_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../lib/presentation/state_management/reservoir_data_provider.dart';
import '../../../lib/domain/usecases/fetch_reservoir_data_usecase.dart';
import '../../../lib/domain/usecases/save_reservoir_data_usecase.dart';
import '../../../lib/domain/entities/reservoir_entity.dart';

// Mock Classes
class MockFetchReservoirDataUseCase extends Mock implements FetchReservoirDataUseCase {}
class MockSaveReservoirDataUseCase extends Mock implements SaveReservoirDataUseCase {}

void main() {
  group('ReservoirDataProvider Tests', () {
    late ReservoirDataProvider provider;
    late MockFetchReservoirDataUseCase mockFetchUseCase;
    late MockSaveReservoirDataUseCase mockSaveUseCase;

    setUp(() {
      mockFetchUseCase = MockFetchReservoirDataUseCase();
      mockSaveUseCase = MockSaveReservoirDataUseCase();
      provider = ReservoirDataProvider(
        fetchUseCase: mockFetchUseCase,
        saveUseCase: mockSaveUseCase,
      );
    });

    test('Initial state is correct', () {
      expect(provider.reservoirData, null);
      expect(provider.isLoading, false);
      expect(provider.errorMessage, null);
    });

    test('Fetch reservoir data successfully', () async {
      // Arrange
      final testData = GridObject(1, 1, 1, 10, 10, 10, 'ExampleType');

      // Ensure it returns Future<GridObject>
      when(mockFetchUseCase.execute()).thenAnswer((_) async => Future.value(testData));

      // Act
      await provider.fetchReservoirData();

      // Assert
      expect(provider.isLoading, false);
      expect(provider.reservoirData, testData);
      expect(provider.errorMessage, null);
    });

    test('Fetch reservoir data fails with an error', () async {
      // Arrange
      when(mockFetchUseCase.execute()).thenAnswer((_) async => Future.error(Exception('Failed to fetch data'))); // Correct Future.error setup

      // Act
      await provider.fetchReservoirData();

      // Assert
      expect(provider.isLoading, false);
      expect(provider.reservoirData, null);
      expect(provider.errorMessage, isNotNull);
    });

    test('Save reservoir data successfully', () async {
      // Arrange
      final testData = GridObject(1, 1, 1, 10, 10, 10, 'ExampleType');

      // Ensure it returns Future<void>
      when(mockSaveUseCase.execute(testData)).thenAnswer((_) async => Future.value());

      // Act
      await provider.saveReservoirData(testData);

      // Assert
      expect(provider.isLoading, false);
      expect(provider.reservoirData, testData);
      expect(provider.errorMessage, null);
    });

    test('Save reservoir data fails with an error', () async {
      // Arrange
      final testData = GridObject(1, 1, 1, 10, 10, 10, 'ExampleType');
      when(mockSaveUseCase.execute(testData)).thenAnswer((_) async => Future.error(Exception('Failed to save data'))); // Proper Future.error setup

      // Act
      await provider.saveReservoirData(testData);

      // Assert
      expect(provider.isLoading, false);
      expect(provider.errorMessage, isNotNull);
    });
  });
}
