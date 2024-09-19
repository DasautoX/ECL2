// lib/domain/entities/reservoir_entity.dart

import '../../core/utils/grid_utils.dart'; // Import the utility functions for grid operations

class GridObject {
  final int nx, ny, nz;  // Number of cells in x, y, and z directions
  final double dx, dy, dz;  // Cell dimensions in x, y, and z directions
  String gridType;
  Map<String, dynamic> spatialData;
  List<double> zcorn = [];
  List<double> coord = [];

  GridObject(this.nx, this.ny, this.nz, this.dx, this.dy, this.dz, this.gridType)
      : spatialData = {};

  // Initialize grid points for Cartesian grid type
  void initCartesian(List<double> tops) {
    List<List<double>> points = [];
    for (int i = 0; i < nx; i++) {
      for (int j = 0; j < ny; j++) {
        for (int k = 0; k < nz; k++) {
          points.add([i * dx, j * dy, tops[k] + k * dz]);
        }
      }
    }
    spatialData['cartesian'] = points;
  }

  // Initialize grid points for corner-point grid type
  void initCornerPoint() {
    List<List<List<double>>> points = List.generate(nx + 1,
            (i) => List.generate(ny + 1, (j) => List.generate(nz + 1, (k) => 0.0)));

    for (int i = 0; i <= nx; i++) {
      for (int j = 0; j <= ny; j++) {
        for (int k = 0; k <= nz; k++) {
          if (i < nx && j < ny) {
            points[i][j][k] = (i * dx + j * dy + k * dz);
          } else {
            points[i][j][k] = 0.0;
          }
        }
      }
    }

    spatialData['cornerPoints'] = points;
  }

  factory GridObject.fromJson(Map<String, dynamic> json) {
    return GridObject(
      json['nx'],
      json['ny'],
      json['nz'],
      json['dx'].toDouble(),
      json['dy'].toDouble(),
      json['dz'].toDouble(),
      json['gridType'],
    )..spatialData = json['spatialData'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nx': nx,
      'ny': ny,
      'nz': nz,
      'dx': dx,
      'dy': dy,
      'dz': dz,
      'gridType': gridType,
      'spatialData': spatialData,
    };
  }
}
