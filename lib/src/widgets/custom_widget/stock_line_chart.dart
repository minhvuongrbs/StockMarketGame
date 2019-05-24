import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StockLineChart extends StatefulWidget {
  @override
  _StockLineChartState createState() => _StockLineChartState();
}


class _StockLineChartState extends State<StockLineChart> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: charts.TimeSeriesChart(
            _createSampleData(),
            animate: false,
            primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec:
                new charts.BasicNumericTickProviderSpec(desiredTickCount: 2))
          )
    );
  }
  static List<charts.Series<TimeSeriesStocks, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesStocks(new DateTime(2017, 9, 19), 5),
      new TimeSeriesStocks(new DateTime(2017, 9, 26), 25),
      new TimeSeriesStocks(new DateTime(2017, 10, 3), 100),
      new TimeSeriesStocks(new DateTime(2017, 10, 10), 41),
      new TimeSeriesStocks(new DateTime(2017, 10, 10), 75),
      new TimeSeriesStocks(new DateTime(2017, 10, 10), 35),
      new TimeSeriesStocks(new DateTime(2017, 10, 10), 12),
    ];

    return [
      new charts.Series<TimeSeriesStocks, DateTime>(
        id: 'stock',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesStocks stocks, _) => stocks.time,
        measureFn: (TimeSeriesStocks stocks, _) => stocks.stocks,
        data: data,
      )
    ];
  }
}
class TimeSeriesStocks {
  final DateTime time;
  final int stocks;

  TimeSeriesStocks(this.time, this.stocks);
}