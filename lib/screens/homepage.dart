import 'package:flutter/material.dart';
import 'package:helios/screens/metrics.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final Color gradientStart = const Color(0xFFFFA05C);
  final Color gradientEnd = const Color(0xFFF06500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset("assets/images/Logo.png"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Connect bluetooth device
            },
            icon: const Icon(Icons.bluetooth, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _notificationCard(
            message: "Welcome back, John",
            appName: "Helios",
            logoPath: "assets/images/Logo.png",
            rightImagePath: "assets/images/welcome.png",
          ),
          const SizedBox(height: 20),
          const Text(
            "Overall Progress: 65%",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          _progressBar(0.65),
          const SizedBox(height: 24),
          _workoutCard(
            title: "Your next workout",
            workout: "Push Ups",
            duration: "10 min",
            reps: "12",
            sets: "3",
            exercise: "Full body",
            buttonText: "Start Workout",
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          _workoutCard(
            title: "Your last workout",
            workout: "Squats",
            duration: "12 min",
            reps: "15",
            sets: "3",
            exercise: "Legs",
            buttonText: "Redo Workout",
            onPressed: () {},
          ),
          const SizedBox(height: 30),

          // Create New Plan Button
          GestureDetector(
            onTap: () {
              // TODO: Create new plan
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gradientStart, gradientEnd]),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                "+ Create New Plan",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // See Metrics Button (border gradient)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MetricsScreen()),
              );
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: gradientStart),
              ),
              alignment: Alignment.center,
              child: const Text(
                "See Metrics",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- Widgets --------------------

  Widget _notificationCard({
    required String message,
    required String appName,
    required String logoPath,
    String? rightImagePath,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          colors: [Color(0xFFEA8945), Color(0xFF161512)],
          radius: 1.5,
          center: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(logoPath, height: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appName,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (rightImagePath != null)
            Image.asset(rightImagePath, width: 90, height: 93),
        ],
      ),
    );
  }

  Widget _progressBar(double progress) {
    return Container(
      height: 12,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(6),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFA05C), Color(0xFFF06500)],
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _workoutCard({
    required String title,
    required String workout,
    required String duration,
    required String reps,
    required String sets,
    required String exercise,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            workout,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Duration:", style: TextStyle(color: Colors.white70)),
              Text("Reps:", style: TextStyle(color: Colors.white70)),
              Text("Sets:", style: TextStyle(color: Colors.white70)),
              Text("Exercise:", style: TextStyle(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(duration, style: const TextStyle(color: Colors.white)),
              Text(reps, style: const TextStyle(color: Colors.white)),
              Text(sets, style: const TextStyle(color: Colors.white)),
              Text(exercise, style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                height: 40,
                width: 140,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA05C), Color(0xFFF06500)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
