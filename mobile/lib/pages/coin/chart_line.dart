import 'package:btc/model/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartLine extends StatelessWidget {
  final double minPrice;
  final double maxPrice;
  final double percentChange;
  final List<ChartData> chartData; 
  final Function(String) setTrackballPrice;
  final int limit;

  const ChartLine({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    required this.chartData,
    required this.setTrackballPrice,
    required this.percentChange,
    required this.limit,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: double.infinity,
      child: SfCartesianChart(
        margin: const EdgeInsets.all(0),
        primaryXAxis: NumericAxis(
          isVisible: false,
          minimum: 1,
          maximum: limit.toDouble(),
        ),
        
        primaryYAxis: NumericAxis(
          isVisible: false,
          minimum: minPrice,
          maximum: maxPrice,
        ),
      
        series: <CartesianSeries<ChartData, int>>[
          SplineAreaSeries(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.index,
            yValueMapper: (ChartData data, _) => data.price,
            splineType: SplineType.monotonic,
            gradient: LinearGradient(
              colors: [
                percentChange > 0 ? const Color(0xff1bb455).withOpacity(1) : const Color(0xffd23c3f).withOpacity(1),
                percentChange > 0 ? const Color(0xff1bb455).withOpacity(0.5) : const Color(0xffd23c3f).withOpacity(0.5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          )
        ],

        tooltipBehavior: TooltipBehavior(
          enable: true,
          tooltipPosition: TooltipPosition.pointer,
          activationMode: ActivationMode.singleTap,
        ),
        plotAreaBorderWidth: 0,

        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          tooltipDisplayMode: TrackballDisplayMode.nearestPoint,
          lineType: TrackballLineType.vertical,
        ),

        onTrackballPositionChanging: (TrackballArgs args) {
          setTrackballPrice(args.chartPointInfo.label ?? '0.0');
        },
      ),
    );
  }
}