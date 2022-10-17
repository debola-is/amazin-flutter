import 'package:amazin/features/admin/model/sales.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CategoryEarningsChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;

  const CategoryEarningsChart({super.key, required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
