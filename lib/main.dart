// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/state_management/reservoir_data_provider.dart';
import 'data/datasources/local/file_data_source.dart';
import 'data/datasources/remote/api_data_source.dart';
import 'data/repositories/reservoir_repository_impl.dart';
import 'domain/usecases/fetch_reservoir_data_usecase.dart';
import 'domain/usecases/save_reservoir_data_usecase.dart';
import 'presentation/widgets/reservoir_data_screen.dart';  // Import the ReservoirDataScreen

void main() {
  // Initialize Data Sources
  final localDataSource = FileDataSource();
  final remoteDataSource = ApiDataSource('https://api.example.com');

  // Initialize Repository
  final repository = ReservoirRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );

  // Initialize Use Cases
  final fetchUseCase = FetchReservoirDataUseCase(repository);
  final saveUseCase = SaveReservoirDataUseCase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ReservoirDataProvider(
            fetchUseCase: fetchUseCase,
            saveUseCase: saveUseCase,
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservoir Data App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReservoirDataScreen(),  // Corrected reference to the screen
    );
  }
}
