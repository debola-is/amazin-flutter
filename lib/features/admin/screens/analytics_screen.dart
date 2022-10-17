import 'package:amazin/features/admin/model/sales.dart';
import 'package:amazin/features/admin/services/admin_services.dart';
import 'package:amazin/features/admin/widgets/admin_appbar.dart';
import 'package:amazin/features/admin/widgets/category_earnings_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:amazin/features/admin/widgets/loader.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  double? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAdminAppbar(titleText: 'Analytics'),
      body: earnings == null || totalSales == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                children: [
                  Text(
                    '\$$totalSales',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 200,
                    child: CategoryEarningsChart(seriesList: [
                      charts.Series(
                        data: earnings!,
                        id: 'Sales',
                        domainFn: (Sales sales, _) => sales.label,
                        measureFn: (Sales sales, _) => sales.earning,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
    );
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context: context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    if (mounted) {
      setState(() {});
    }
  }
}
