import 'package:amazon_clone/screens/auth/auth_screen.dart';
import 'package:amazon_clone/services/SharedServices/Sharedservices.dart';
import 'package:amazon_clone/services/provider/api_services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticScreen extends StatefulWidget {
  const AnalyticScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip = TooltipBehavior(enable: true);

  @override
  void initState() {
    super.initState();
    Provider.of<ApiProviderServices>(context, listen: false)
        .fetchAnalytics(context);
    data = []; // Initialize data list
  }

  @override
  Widget build(BuildContext context) {
    final getData = context.watch<ApiProviderServices>().data;
    if (getData == null) {
      return const CircularProgressIndicator();
    } else {
      final earnings = getData['earnings'];
      final mobileEarnings = earnings['mobileEarnings'];
      final essentialEarnings = earnings['essentialEarnings'];
      final applianceEarnings = earnings['applianceEarnings'];
      final booksEarnings = earnings['booksEarnings'];
      final fashionEarnings = earnings['fashionEarnings'];

      // Populate data list with earnings data
      data = [
        _ChartData('Mobile', mobileEarnings.toDouble()),
        _ChartData('Essential', essentialEarnings.toDouble()),
        _ChartData('Appliance', applianceEarnings.toDouble()),
        _ChartData('Books', booksEarnings.toDouble()),
        _ChartData('Fashion', fashionEarnings.toDouble()),
      ];

      return Column(
        children: [
          Text(
            'Total Earnings: ${earnings['totalEarning']}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 250,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
              tooltipBehavior: _tooltip,
              series: <CartesianSeries<_ChartData, String>>[
                ColumnSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Earnings',
                  color: Color.fromRGBO(8, 142, 255, 1),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                SharedServices.logout(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, AuthScreen.routeName, (route) => false);
              },
              child: const Text("Log Out")),
        ],
      );
    }
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
