import 'package:flutter/material.dart';
import 'package:helios/screens/bodyWeight.dart';


class MetricsScreen extends StatelessWidget {
  const MetricsScreen({super.key});

  final Color gradientOrange = const Color(0xFFFFA05C);
  final Color gradientBlack = const Color(0xFF161512);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: const Text(
          "Metrics",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
          physics: const BouncingScrollPhysics(),
          children: [
            // 🔥 BODY WEIGHT (CLICKABLE)
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BodyWeightScreen()),
                );
              },
              child: _metricCard(
                imagePath: "assets/images/bodyWeight.png",
                title: "Body Weight",
                description: "Input weight weekly to track progress",
              ),
            ),

            _metricCard(
              imagePath: "assets/images/bodyWeight.png",
              title: "Calories Burned",
              description: "Based on distance and weight",
            ),
            _metricCard(
              imagePath: "assets/images/goals.png",
              title: "Goals",
              description: "List of all goals created",
            ),
            _metricCard(
              imagePath: "assets/images/TUT.png",
              title: "T.U.T",
              description: "Time under tension",
            ),
            _metricCard(
              imagePath: "assets/images/bodyWeight.png",
              title: "Form Tracking",
              description: "Track your form and technique",
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricCard({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientOrange, gradientBlack, gradientBlack],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🟠 Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 📝 Title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),

          // 📄 Description
          Text(
            description,
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
