// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_foreground_task/flutter_foreground_task.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:vendorvibe/homepage.dart/home.dart';
// import 'package:vendorvibe/initialscreen/introscreen.dart'; 
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     // Start Foreground Service
//     startForegroundService();

//     // Animation setup
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 3), // Animation duration
//     )..forward();

//     _animation = Tween<double>(begin: 0.1, end: 9.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//     // Check login status after the animation is done
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _checkLoginStatus();
//       }
//     });
//   }

//   void startForegroundService() {
//     FlutterForegroundTask.startService(
//       notificationTitle: 'Running in Background',
//       notificationText: 'Listening for messages...',
//     );
//   }

//   void _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//     // Delay for a bit before navigating to the appropriate screen
//     Timer(Duration(seconds: 1), () {
//       if (isLoggedIn) {
//         // Navigate to HomeScreen if already logged in
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()),
//         );
//       } else {
//         // Navigate to IntroScreen if not logged in
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => IntroScreen()),
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [const Color.fromARGB(255, 0, 0, 0), const Color.fromARGB(255, 228, 214, 219)], // Gradient colors
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               AnimatedBuilder(
//                 animation: _animation,
//                 builder: (context, child) {
//                   return Transform.scale(
//                     scale: _animation.value,
//                     child: ShaderMask(
//                       shaderCallback: (Rect bounds) {
//                         return LinearGradient(
//                           colors: [const Color.fromARGB(255, 0, 5, 9), const Color.fromARGB(255, 207, 192, 197)], // Gradient colors
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ).createShader(bounds);
//                       },
//                       child: Text(
//                         "V",
//                         style: GoogleFonts.poppins(
//                           fontSize: 120, 
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white, 
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               Text(
//                 "VendorVibe",
//                 style: GoogleFonts.poppins(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
