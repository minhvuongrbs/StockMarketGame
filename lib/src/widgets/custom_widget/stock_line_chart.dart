import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/src/text_element.dart';
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/flutter.dart';

class StockLineChart extends StatefulWidget {
  @override
  _StockLineChartState createState() => _StockLineChartState();
}


class _StockLineChartState extends State<StockLineChart> {
  
  List<TimeSeriesStocks> selectionData = [];

  _onSelectionChanged(SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    TimeSeriesStocks selectedPoint;
    bool ok = false;
    // We get the model that updated with a list of [SeriesDatum] which is
    // simply a pair of series & datum.
    //
    // Walk the selection updating the measures map, storing off the sales and
    // series name for each selection point.
    if (selectedDatum.isNotEmpty) {
      selectedPoint = model.selectedDatum[0].datum;
      print(selectedPoint.stocks);
    }

    // Request a build.
    setState(() {
        selectionData.add(selectedPoint);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: TimeSeriesChart(
            _createSampleData(selectionData),
            animate: false,
            primaryMeasureAxis: new NumericAxisSpec(
            tickProviderSpec:
                BasicNumericTickProviderSpec()),
            customSeriesRenderers: [
              PointRendererConfig(
                customRendererId: 'custom point',
                symbolRenderer: CustomCircleSymbolRenderer()
              )
            ],
            selectionModels: [
              SelectionModelConfig(
                changedListener: _onSelectionChanged,
              )
            ],
            dateTimeFactory: const LocalDateTimeFactory(),
          )
    );
  }
  static List<Series<TimeSeriesStocks, DateTime>> _createSampleData(List<TimeSeriesStocks> selectionData) {
    final data = [
      new TimeSeriesStocks(new DateTime(2017, 9, 19), 5),
      new TimeSeriesStocks(new DateTime(2017, 9, 26), 30),
      new TimeSeriesStocks(new DateTime(2017, 10, 3), 100),
      new TimeSeriesStocks(new DateTime(2017, 10, 10), 41),
      new TimeSeriesStocks(new DateTime(2017, 10, 11), 75),
      new TimeSeriesStocks(new DateTime(2017, 10, 12), 35),
      new TimeSeriesStocks(new DateTime(2017, 10, 13), 12),
    ];

    return [
      new Series<TimeSeriesStocks, DateTime>(
        id: 'stock',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesStocks stocks, _) => stocks.time,
        measureFn: (TimeSeriesStocks stocks, _) => stocks.stocks,
        data: data,
      ),
      new Series<TimeSeriesStocks, DateTime>(
        id: 'select point',
        colorFn: (_, __) => MaterialPalette.pink.shadeDefault,
        domainFn: (TimeSeriesStocks stocks, _) => stocks.time,
        measureFn: (TimeSeriesStocks stocks, _) => stocks.stocks + 2,
        data: selectionData,
      )..setAttribute(rendererIdKey, 'custom point')
    ];
  }
}
class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds, {List<int> dashPattern, Color fillColor, Color strokeColor, double strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
      Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10, bounds.height + 10),
      fill: Color.white
    );
    var textStyle = style.TextStyle();
    textStyle.color = Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(
      TextElement("sell", style: textStyle),
        (bounds.left).round(),
        (bounds.top - 28).round()
    );
  }
}

class TimeSeriesStocks {
  final DateTime time;
  final int stocks;

  TimeSeriesStocks(this.time, this.stocks);
}