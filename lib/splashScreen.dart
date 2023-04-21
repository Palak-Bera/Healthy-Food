import 'package:diet_schedule_app/Screens/AuthenticationScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacementNamed("/login");

   
   
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => LoginScreen(),
      //   ),
      // );
    
    
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/splash.png"),
                    fit: BoxFit.fill,
                    scale: 1)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image.asset(
                  "assets/home_logo.png",
                  fit: BoxFit.cover,
                  scale: 1.0,
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Image.asset(
          //     "assets/image1.png",
          //     fit: BoxFit.cover,
          //     scale: 1.0,
          //   ),
          // )
        ],
      ),
    ));
  }
}
