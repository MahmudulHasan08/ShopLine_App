import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/common/widgets/loader.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/admin/models/sales_model.dart';
import 'package:shopline_app/features/admin/services/product_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticleScreen extends StatefulWidget {
  const AnalyticleScreen({super.key});

  @override
  State<AnalyticleScreen> createState() => _AnalyticleScreenState();
}

class _AnalyticleScreenState extends State<AnalyticleScreen> {
  ProductService productService = ProductService();
  Map<String,dynamic>? earningData;
  TooltipBehavior? _tooltipBehavior;
  int? totalEarnings;
  List<Sales>? earnSales;
  @override
  void initState() {
   getAllEarnings();
    super.initState();
  }
  void getAllEarnings()async {
   earningData = await productService.getAllEarnings(context: context);
   totalEarnings = earningData!['totalEarnings'];
   earnSales = earningData!['earnSales'];
   _tooltipBehavior = TooltipBehavior(enable: true);
   setState(() {
     
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:totalEarnings == null || earnSales == null ? const Loader() : Column(children: [
      Text(totalEarnings.toString()),
      height(18.h),
       SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
             title: ChartTitle(text: 'Half yearly sales analysis'),
            // Enable legend
            // legend: Legend(isVisible: true),
             tooltipBehavior: _tooltipBehavior,
            

            series: <LineSeries<Sales, String>>[
              LineSeries<Sales, String>(
                // Bind data source
                dataSource: earnSales!,
                xValueMapper: (Sales sales, _) => sales.label,
                yValueMapper: (Sales sales, _) => sales.earnings,
                // dataLabelSettings:const DataLabelSettings(isVisible: true)
              )
            ]
          ),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 1000, maximum: 1000000, interval: 500),
            tooltipBehavior: _tooltipBehavior,
            series: <CartesianSeries<Sales, String>>[
              ColumnSeries<Sales, String>(
                  dataSource: earnSales!,
                  xValueMapper: (Sales data, _) => data.label,
                  yValueMapper: (Sales data, _) => data.earnings,
                  name: 'Gold',
                  color:const Color.fromRGBO(8, 142, 255, 1))
            ]),
      ]),
    );
  }
}