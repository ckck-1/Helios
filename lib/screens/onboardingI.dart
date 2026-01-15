import 'package:flutter/material.dart';
import 'package:helios/screens/Login.dart';
// import 'home_screen.dart'; // 👈 replace with your real screen

class Onboardingi extends StatelessWidget {
  const Onboardingi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const SizedBox(height: 150),

          const Center(
            child: Image(
              image: AssetImage("assets/images/Logo.png"),
              height: 80,
            ),
          ),

          const SizedBox(height: 16),

          const Center(
            child: Text(
              "Helios Sports Tech",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),

          const SizedBox(height: 6),

          const Center(
            child: Text(
              "Here To Compete",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
              ),
            ),
          ),

          const Spacer(),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Login(), // change screen here
                ),
              );
            },
            child: Container(
              width: 343,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFA05C), Color(0xFFF06500)],
                ),
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
                "Get Started",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
