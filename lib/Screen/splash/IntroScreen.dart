import 'dart:async'; // Add this import

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
  Timer? _timer;

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
      "image": "assets/images/introfour.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < steps.length - 1) {
        _currentPage++;
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildPage(Map<String, String> step, bool isLastPage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(step["image"]!, height: 300),
        const SizedBox(height: 20),
        Text(step["step"]!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text(
          step["title"]!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff5db491),
          ),
        ),
        const SizedBox(height: 30),
        if (isLastPage)
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: const StadiumBorder()),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                child: Text(
                  "BOOK NOW",
                  style: TextStyle(color: Colors.white),
                ),
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage('assets/images/bacKImage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
                itemBuilder: (context, index) =>
                    _buildPage(steps[index], index == steps.length - 1),
              ),
            ),
            const SizedBox(height: 10),
            _buildDots(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
