import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/src/text_element.dart';
import 'package:stock_market_game/src/models/time_series_stock.dart';
import 'package:stock_market_game/src/providers/app_state.dart';
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class StockLineChart extends StatefulWidget {
  @override
  _StockLineChartState createState() => _StockLineChartState();
}

class _StockLineChartState extends State<StockLineChart>
    with SingleTickerProviderStateMixin {
  List<TimeSeriesStocks> selectionData = [];
  AnimationController controller;
  Animation<int> _datasize;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _datasize = IntTween(begin: 0, end: 11).animate(controller)
      ..addListener(() {
        setState(() {});
      });
   controller.forward();
  }

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    TimeSeriesStocks selectedPoint;
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
    final appState = Provider.of<AppState>(context, listen: true);
    final diagramState = Provider.of<AppState>(context, listen: true);
     // if (diagramState.isDiagramRunning)
    
    // else
    //   controller.reset();
    return Expanded(
      child: charts.TimeSeriesChart(
        _createSampleData(appState),
        animate: false,
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickProviderSpec: charts.BasicNumericTickProviderSpec()),
        customSeriesRenderers: [
          charts.PointRendererConfig(
            customRendererId: 'custom point',
            symbolRenderer: CustomCircleSymbolRenderer(label: 'User'),
          )
        ],
        selectionModels: [
          charts.SelectionModelConfig(
            changedListener: _onSelectionChanged,
          )
        ],
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }

  List<charts.Series<TimeSeriesStocks, DateTime>> _createSampleData(
      AppState appState) {
    final appStateSelectionData = Provider.of<AppState>(context);
    return [
      new charts.Series<TimeSeriesStocks, DateTime>(
        id: 'stock',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesStocks stocks, _) => stocks.time,
        measureFn: (TimeSeriesStocks stocks, _) => stocks.stocks,
        data: appState.getStockData(_datasize.value),
      ),
      new charts.Series<TimeSeriesStocks, DateTime>(
        id: 'select point',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        fillColorFn: (_, __) => charts.MaterialPalette.white,
        strokeWidthPxFn: (_, __) => 2.0,
        domainFn: (TimeSeriesStocks stocks, _) => stocks.time,
        measureFn: (TimeSeriesStocks stocks, _) => stocks.stocks,
        data: appStateSelectionData.getSelectionData(),
      )..setAttribute(charts.rendererIdKey, 'custom point')
    ];
  }
}

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  final String label;
  CustomCircleSymbolRenderer({this.label});
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      charts.Color fillColor,
      charts.Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle((bounds.left + bounds.width / 2 - label.length * 3.7).round(),
            bounds.top - 30, label.length * 8, bounds.height + 10),
        fill: charts.Color(r: 52, g: 73, b: 94, a: 30));
    var textStyle = style.TextStyle();
    textStyle.color = charts.Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(
        TextElement(label, style: textStyle),
        (bounds.left + bounds.width / 2 - label.length * 3.5).round(),
        (bounds.top - 28).round());
  }
}
