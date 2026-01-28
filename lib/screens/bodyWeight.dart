import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BodyWeightScreen extends StatefulWidget {
  const BodyWeightScreen({super.key});

  @override
  State<BodyWeightScreen> createState() => _BodyWeightScreenState();
}

class _BodyWeightScreenState extends State<BodyWeightScreen>
    with SingleTickerProviderStateMixin {
  // Colors
  final Color gradientOrange = const Color(0xFFFFA05C);
  final Color gradientBlack = const Color(0xFF161512);

  final Color orange = const Color(0xFFFF06500);
  final Color bg = const Color(0xFF1A1A1A);
  final Color card = const Color(0xFF161512);
  final Color green = const Color(0xFF5EDC87);

  String selectedYear = "2025";

  // Weekly weights
  final List<double> weeklyWeights = [
    150,
    165,
    158,
    170,
    160,
    155,
    145,
    140,
    130,
  ];
  final double goalWeight = 120;

  // Countdown timer
  Duration timeLeft = const Duration(
    days: 10,
    hours: 9,
    minutes: 20,
    seconds: 23,
  );
  Timer? timer;

  // Animation
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    // Countdown timer
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timeLeft.inSeconds > 0) {
        setState(() => timeLeft -= const Duration(seconds: 1));
      }
    });

    // Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));

    _controller!.forward(); // start animation
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Body Weight",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _topControls(),
            const SizedBox(height: 20),
            _animatedChartCard(),
            const SizedBox(height: 16),
            _goalInfoCard(), // card with radial gradient
            const SizedBox(height: 24),
            _weeklyLog(),
          ],
        ),
      ),
    );
  }

  // Top controls
  Widget _topControls() {
    return Row(
      children: [
        _outlinedBox(
          child: DropdownButton<String>(
            value: selectedYear,
            dropdownColor: card,
            underline: const SizedBox(),
            iconEnabledColor: orange,
            style: TextStyle(color: orange),
            items: [
              "2022",
              "2023",
              "2024",
              "2025",
            ].map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
            onChanged: (v) => setState(() => selectedYear = v!),
          ),
        ),
        const Spacer(),
        _outlinedBox(child: Icon(Icons.calendar_month, color: orange)),
      ],
    );
  }

  // Animated chart card
  Widget _animatedChartCard() {
    double maxWeight = weeklyWeights.reduce((a, b) => a > b ? a : b);
    double chartMaxY = (maxWeight * 1.2).ceilToDouble();

    return AnimatedBuilder(
      animation: _animation ?? AlwaysStoppedAnimation(0),
      builder: (context, _) {
        final animValue = _animation?.value ?? 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(18),
          ),
          child: AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                maxY: chartMaxY,
                minY: 0,
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 25,
                      getTitlesWidget: (v, _) => Text(
                        v.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 11,
                        ),
                      ),
                      reservedSize: 36,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) => Text(
                        "Week ${v.toInt() + 1}",
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                barGroups: List.generate(
                  weeklyWeights.length,
                  (i) => BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: weeklyWeights[i] * animValue,
                        width: 14,
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [orange.withOpacity(.6), orange],
                        ),
                      ),
                    ],
                  ),
                ),
                extraLinesData: ExtraLinesData(
                  horizontalLines: [
                    HorizontalLine(
                      y: goalWeight,
                      color: green,
                      strokeWidth: 2,
                      dashArray: [6, 4],
                      label: HorizontalLineLabel(
                        show: true,
                        alignment: Alignment.topLeft,
                        labelResolver: (_) => "Goal: ${goalWeight.toInt()}kg",
                        style: TextStyle(color: green, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Goal card with radial gradient
  // Goal card with smoother radial gradient
  Widget _goalInfoCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            gradientOrange.withOpacity(0.8), // start orange
            gradientBlack, // fade to card color
          ],
          stops: [0.0, 0.45], // orange stops at 50% radius
          center: Alignment.topCenter, // start from top center
          radius: 2, // smooth transition
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _goalColumn("Weight goal", "${goalWeight.toInt()}kg", orange),
          const Spacer(),
          _goalColumn(
            "Time left to goal",
            "${timeLeft.inDays}d : ${timeLeft.inHours % 24}h : ${timeLeft.inMinutes % 60}m : ${timeLeft.inSeconds % 60}s",
            Colors.white,
          ),
          const SizedBox(width: 8),
          Icon(Icons.edit, color: orange),
        ],
      ),
    );
  }

  // Weekly log
  Widget _weeklyLog() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Weekly weight log",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Add new weight",
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(
          4,
          (i) => _logItem("Week ${9 - i}", "${130 + i * 5}kg"),
        ),
      ],
    );
  }

  // Single log item
  Widget _logItem(String week, String weight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text(week, style: const TextStyle(color: Colors.white)),
          const Spacer(),
          Text(weight, style: TextStyle(color: orange)),
          const SizedBox(width: 8),
          Icon(Icons.edit, color: orange, size: 18),
        ],
      ),
    );
  }

  // Outlined box wrapper
  Widget _outlinedBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: orange),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  // Goal column
  Widget _goalColumn(String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
