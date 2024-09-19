// lib/presentation/widgets/reservoir_data_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state_management/reservoir_data_provider.dart';
import '../../domain/entities/reservoir_entity.dart';

class ReservoirDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReservoirDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservoir Data'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: provider.fetchReservoirData,
          ),
        ],
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(child: Text('Error: ${provider.errorMessage}'))
          : provider.reservoirData != null
          ? Column(
        children: [
          Text('Reservoir Data Loaded: ${provider.reservoirData}'),
          ElevatedButton(
            onPressed: () async {
              final data = GridObject(1, 1, 1, 10, 10, 10, 'ExampleType');
              await provider.saveReservoirData(data);
            },
            child: Text('Save Data'),
          ),
        ],
      )
          : Center(
        child: ElevatedButton(
          onPressed: provider.fetchReservoirData,
          child: Text('Fetch Data'),
        ),
      ),
    );
  }
}
