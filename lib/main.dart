import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vendorvibe/ask%20screen/ask.dart';
import 'package:vendorvibe/homepage.dart/home.dart';
import 'package:vendorvibe/initialscreen/introscreen.dart';
import 'dart:async';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCl2E9DtEfkpWEdlSHgCBcg8w_JhNR6ORo",
      authDomain: "vendorvibe-vv.firebaseapp.com",
      projectId: "vendorvibe-vv",
      storageBucket: "vendorvibe-vv.firebasestorage.app",
      messagingSenderId: "767780330111",
      appId: "1:767780330111:web:91b739fc29cb8283f4fd4a",
      measurementId: "G-D2J2TSL700",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _zoomAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    startForegroundService();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    );

    
    _zoomAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(end: 0.5, begin: 1.2).chain(CurveTween(curve: Curves.easeOutExpo)), weight: 50),
      
    ]).animate(_controller);

    // Opacity animation: Fades in smoothly
    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkLoginStatus();
      }
    });
  }

  void startForegroundService() {
    FlutterForegroundTask.startService(
      notificationTitle: 'Running in Background',
      notificationText: 'Listening for messages...',
    );
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.10; // Responsive font size

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 238, 238, 218), // Updated background color
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _zoomAnimation.value, // Apply Zoom-in & Zoom-out effect
                child: Opacity(
                  opacity: _opacityAnimation.value, // Apply Fade-in effect
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Color.fromARGB(255, 243, 243, 4), Color.fromARGB(255, 255, 255, 255)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      "VENDORVIBE",
                      style: GoogleFonts.poppins(
                        fontSize: fontSize, // Dynamic Font Size for all screens
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 149, 171, 5),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
