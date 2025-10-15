import 'package:flutter/material.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/features/steps/domain/step_model.dart';
import 'package:fl_chart/fl_chart.dart';


class WeeklyChart extends StatelessWidget {
  final List<StepModel> stepsList;
  const WeeklyChart({required this.stepsList, });

  @override
  Widget build(BuildContext context) {
    final start = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).subtract(const Duration(days: 6));
    final days = List.generate(7, (i) => start.add(Duration(days: i)));
    final maxSteps = stepsList.isEmpty
        ? 0
        : stepsList.map((e) => e.steps).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 40.h,
      child: BarChart(
        BarChartData(
          maxY: (maxSteps > 0 ? maxSteps + 1000 : 2000).toDouble(),
          barGroups: days.asMap().entries.map((e) {
            final day = e.value;
            final steps = stepsList.firstWhere(
                  (x) => x.dateTime.day == day.day && x.dateTime.month == day.month,
              orElse: () => StepModel( dateTime: day, steps: 0,  goal: 15000),
            ).steps;
            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: steps.toDouble(),
                  width: 3.w,
                  color: AppColors.primaryColor(context),
                )
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (v, _) {
                    final date = days[v.toInt()];
                    final shortDay = ['s', 'm', 't', 'w', 'th', 'f', 'st'][date.weekday % 7];
                    return Text(shortDay.tr);
                  }
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
        ),
      ),
    );
  }
}