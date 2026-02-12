import 'package:flutter/material.dart';
import 'dart:math';

class CaloriesScreen extends StatefulWidget {
  const CaloriesScreen({super.key});

  @override
  State<CaloriesScreen> createState() => _CaloriesScreenState();
}

class _CaloriesScreenState extends State<CaloriesScreen>
    with SingleTickerProviderStateMixin {
  final Color orange = const Color(0xFFFF06500);
  final Color bg = const Color(0xFF1A1A1A);
  final Color card = const Color(0xFF161512);
  final double totalCalories = 3600;

  String selectedTime = "This week";
  final TextEditingController caloriesController = TextEditingController();

  // Animation
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animate the progress circle
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 0.75,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
          "Calories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔵 Circular Calories Card with animation
            SizedBox(
              height: 180,
              child: Center(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, _) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Circular background with subtle shadow
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: card,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                offset: const Offset(4, 4),
                                blurRadius: 8,
                              ),
                              BoxShadow(
                                color: Colors.white12,
                                offset: const Offset(-2, -2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),

                        // Animated Circular progress arc
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CustomPaint(
                            painter: _CircularCaloriesPainter(
                              progress: _animation.value,
                              color: orange,
                              strokeWidth: 17,
                              gradient: true,
                            ),
                          ),
                        ),

                        // Calories text
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${totalCalories.toInt()}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "cal",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Total calories burned text
            Column(
              children: const [
                Text(
                  "Total Calories burned",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  "These numbers are based on distance and weight",
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Add calories input
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: orange),
                    ),
                    child: TextField(
                      controller: caloriesController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Add calories",
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

            // Time dropdown
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: selectedTime,
                dropdownColor: card,
                underline: const SizedBox(),
                iconEnabledColor: orange,
                style: const TextStyle(color: Colors.white),
                items: ["This week", "This month", "Today"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    selectedTime = v!;
                  });
                },
              ),
            ),

            const SizedBox(height: 16),

            // Exercise cards
            _exerciseCard("Push ups", 150, "Today", 10, 10),
            _exerciseCard("Squats", 85, "Tuesday", 7, 10),
            _exerciseCard("Deadlift", 165, "Monday", 10, 20),
          ],
        ),
      ),
    );
  }

  // Exercise card widget
  Widget _exerciseCard(
    String title,
    double calories,
    String date,
    int repsDone,
    int repsTotal,
  ) {
    double progress = calories / 200; // example progress
    if (progress > 1) progress = 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Circular progress indicator for exercise
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white10,
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: CustomPaint(
                  painter: _CircularCaloriesPainter(
                    progress: progress,
                    color: orange,
                    strokeWidth: 8,
                  ),
                ),
              ),
              Text(
                "${calories.toInt()}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Exercise title and reps
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Reps completed: $repsDone/$repsTotal",
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),

          // Date at top right
          Text(
            date,
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// Custom painter for circular progress
class _CircularCaloriesPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final bool gradient;

  _CircularCaloriesPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 5,
    this.gradient = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final Paint background = Paint()
      ..color = Colors.white12
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Paint foreground = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (gradient)  {
      foreground.shader = SweepGradient(
        startAngle: -pi / 2,
        endAngle: 3 * pi / 2,
        colors: [color.withOpacity(0.7), color],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    } else {
      foreground.color = color;
    }

    // Draw background circle
    canvas.drawCircle(center, radius, background);

    // Draw foreground progress arc
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      foreground,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
