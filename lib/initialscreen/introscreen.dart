import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vendorvibe/login/loginpage.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void nextPage() {
    if (_currentIndex < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenIntro', true); 

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    buildPage('asset/images/c.webp', '📢 Tired of street noise disturbing you?'),
                    buildPage('asset/images/b.webp', '🔔 Know when a vendor enters your street!'),
                    buildPage('asset/images/a.webp', '🚀 Turn on alerts & never miss an update!', showButton: true),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 15,
                    dotWidth: 15,
                    activeDotColor: const Color.fromARGB(255, 0, 0, 0),
                    dotColor: Colors.grey.shade400,
                  ),
                ),
              ),
            ],
          ),

          // Next Button
          if (_currentIndex < 2)
            Positioned(
              right: 20,
              bottom: 80,
              child: IconButton(
                onPressed: nextPage,
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ),

          // Previous Button
          if (_currentIndex > 0)
            Positioned(
              left: 20,
              bottom: 80,
              child: IconButton(
                onPressed: previousPage,
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }

  Widget buildPage(String imagePath, String text, {bool showButton = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 24,
                    spreadRadius: 3,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.5,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.05),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              if (showButton) ...[
                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(
                  onPressed: _completeIntro,
                  child: Text("Let's Start",style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 106, 109, 59),
                    foregroundColor: Color.fromARGB(255, 230, 185, 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: 15,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
