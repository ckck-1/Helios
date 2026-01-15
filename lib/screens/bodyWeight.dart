import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BodyWeightScreen extends StatefulWidget {
  const BodyWeightScreen({super.key});

  @override
  State<BodyWeightScreen> createState() => _BodyWeightScreenState();
}

class _BodyWeightScreenState extends State<BodyWeightScreen> {
  final Color orange = const Color(0xFFFFA05C);
  final Color black = const Color(0xFF161512);
  final Color bg = const Color(0xFF1A1A1A);
  final Color gradientOrange = const Color(0xFFFFA05C);
  final Color gradientBlack = const Color(0xFF161512);

  String selectedYear = "2025";

  // Demo data
  final List<double> weeklyWeights = [78, 77.5, 77, 76.5, 76, 75.8];
  final double goalWeight = 72;

  Duration timeLeft = const Duration(
    days: 18,
    hours: 4,
    minutes: 32,
    seconds: 10,
  );
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timeLeft.inSeconds > 0) {
        setState(() {
          timeLeft -= const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Body Weight",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _topControls(),
            const SizedBox(height: 24),
            _weightChart(),
            const SizedBox(height: 24),
            _goalCard(),
          ],
        ),
      ),
    );
  }

  // 🔝 YEAR DROPDOWN + CALENDAR
  Widget _topControls() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: orange),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: selectedYear,
            dropdownColor: black,
            underline: const SizedBox(),
            iconEnabledColor: orange,
            style: TextStyle(color: orange),
            items: ["2024", "2025", "2026"]
                .map((year) => DropdownMenuItem(value: year, child: Text(year)))
                .toList(),
            onChanged: (val) {
              setState(() => selectedYear = val!);
            },
          ),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.calendar_month, color: orange),
          onPressed: () {},
        ),
      ],
    );
  }

  // 📊 BAR GRAPH + GOAL LINE
  Widget _weightChart() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          backgroundColor: black,
          gridData: FlGridData(show: false, horizontalInterval: 0.5),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, _) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) => Text(
                  "W${value.toInt() + 1}",
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            weeklyWeights.length,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: weeklyWeights[index],
                  color: orange,
                  width: 16,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            ),
          ),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(
                y: goalWeight,
                color: Colors.redAccent,
                strokeWidth: 2,
                dashArray: [8, 4],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🟧 H62 GOAL CARD
  Widget _goalCard() {
    return Container(
      height: 62,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientOrange, gradientBlack, gradientBlack],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Left
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Weight goal",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                "${goalWeight.toStringAsFixed(1)} kg",
                style: TextStyle(
                  color: orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),

          // Middle
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Time left to goal",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                "${timeLeft.inDays}d : "
                "${timeLeft.inHours % 24}h : "
                "${timeLeft.inMinutes % 60}m : "
                "${timeLeft.inSeconds % 60}s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),

          // Right
          IconButton(
            icon: Icon(Icons.edit, color: orange),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
