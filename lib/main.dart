import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:diet_schedule_app/Controllers/notifications.dart';
import 'package:diet_schedule_app/Screens/AuthenticationScreen/forgotPasswordScreen.dart';
import 'package:diet_schedule_app/Screens/AuthenticationScreen/loginScreen.dart';
import 'package:diet_schedule_app/Screens/AuthenticationScreen/registerScreen.dart';
import 'package:diet_schedule_app/Screens/AuthenticationScreen/verifyEmailScreen.dart';
import 'package:diet_schedule_app/Screens/BodydetailsScreen/bodyDataScreen.dart';
import 'package:diet_schedule_app/Screens/BodydetailsScreen/congratulationsScreen.dart';
import 'package:diet_schedule_app/Screens/BodydetailsScreen/yourGoal.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/dishDetailScreen.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/homeScreen.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/navBar.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/setScheduleScreen.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/stepsScreen.dart';
import 'package:diet_schedule_app/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // NotificationService().initNotification();
  User? user = FirebaseAuth.instance.currentUser;

  
  NotificationService().initAwesomeNotification();
  
  runApp(MyApp(user: user));
     
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({Key? key, this.user}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home: user == null ? SplashScreen() : NavigationBarScreen(),
      // SetScheduleScreen(),
      // PedometerScreen(),
     

      routes: {
        // '/': (context) => LoginScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/verifyemail': (context) => VerifyEmailScreen(),
        '/forgotpassword': (context) => ForgotPasswordScreen(),
        '/navigationbar': (context) => NavigationBarScreen(),
        '/goal': (context) => YourGoalScreen(),
        '/bodydata': (context) => BodyDataScreen(),
        '/congratulation': (context) => CongratulationScreen(),

        // other routes
      },
    );
  }
}
