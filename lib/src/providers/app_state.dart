import 'package:flutter/material.dart';
import 'package:stock_market_game/src/models/time_series_stock.dart';

class AppState with ChangeNotifier {
  AppState();
  List<TimeSeriesStocks> selectionData = [];
  int _dataSize = 0;
  int selectedPoint = -1;
  bool isDiagramRunning = false;

  List<TimeSeriesStocks> getStockData(int value) {
    if (value > _dataSize) _setStockDataSize(value);
    return data.sublist(0, _dataSize);
  }

  void updateSelectionData() {
    selectionData.add(data[_dataSize - 1]);
    notifyListeners();
  }

  List<TimeSeriesStocks> getSelectionData() {
    return selectionData;
  }

  void toggleDiagramRunning() {
    isDiagramRunning = !isDiagramRunning;
    notifyListeners();
  }

  bool getDiagramState() {
    return isDiagramRunning;
  }

  void _setStockDataSize(int value) {
    if (value < data.length) {
      _dataSize = value;
    }
  }

  final data = [
    new TimeSeriesStocks(new DateTime(2017, 9, 19), 5),
    new TimeSeriesStocks(new DateTime(2017, 9, 26), 30),
    new TimeSeriesStocks(new DateTime(2017, 10, 3), 110),
    new TimeSeriesStocks(new DateTime(2017, 10, 10), 41),
    new TimeSeriesStocks(new DateTime(2017, 10, 11), 75),
    new TimeSeriesStocks(new DateTime(2017, 10, 12), 35),
    new TimeSeriesStocks(new DateTime(2017, 10, 13), 12),
    new TimeSeriesStocks(new DateTime(2017, 10, 14), 33),
    new TimeSeriesStocks(new DateTime(2017, 10, 15), 59),
    new TimeSeriesStocks(new DateTime(2017, 10, 17), 89),
    new TimeSeriesStocks(new DateTime(2017, 10, 18), 49),
  ];
}
