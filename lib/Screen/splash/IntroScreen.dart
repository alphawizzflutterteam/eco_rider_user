import 'package:eco_rider_user/Screen/auth/loginScreen.dart';
import 'package:flutter/material.dart';

import '../../Helper/Colors.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> steps = [
    {
      "title": "Request A Companion",
      "step": "Step: 1",
      "image": "assets/images/introone.png",
    },
    {
      "title": "Track Your Ride",
      "step": "Step: 2",
      "image": "assets/images/introtwo.png",
    },
    {
      "title": "Enjoy Your Ride",
      "step": "Step: 3",
      "image": "assets/images/introthree.png",
    },
    {
      "title": "Hassle Free Payment",
      "step": "Step: 4",
      "image": "assets/images/introfour.jpg",
    },
  ];

  Widget _buildPage(Map<String, String> step) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(step["image"]!, height: 200),
        const SizedBox(height: 20),
        Text(step["step"]!, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Text(step["title"]!,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green)),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
            // Navigation or action
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, shape: const StadiumBorder()),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            child: Text(
              "BOOK NOW",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        steps.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 12 : 8,
          height: _currentPage == index ? 12 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: steps.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) => _buildPage(steps[index]),
            ),
          ),
          const SizedBox(height: 10),
          _buildDots(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
