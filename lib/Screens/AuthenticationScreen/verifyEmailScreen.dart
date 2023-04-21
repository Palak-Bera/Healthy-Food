import 'dart:async';
import 'package:diet_schedule_app/Controllers/db.dart';
import 'package:diet_schedule_app/Screens/AuthenticationScreen/registerScreen.dart';
import 'package:diet_schedule_app/Screens/BodydetailsScreen/bodyDataScreen.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/Widgets/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailScreen extends StatefulWidget {
  VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final User user = FirebaseAuth.instance.currentUser!;
  bool isEmailVerified = false;
  Database database = Database();
  Timer? timer;
  Constant cs = Constant();
  bool isloading = false;

  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkEmailVerified();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Verification email has sent to your email address",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: cs.secondaryColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      ));
      setState(() {
        isloading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: cs.alert,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      ));
      setState(() {
        isloading = false;
      });
    }
  }

  Future checkEmailVerified() async {
    await user.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Email Verification Completed",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: cs.secondaryColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      ));
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? BodyDataScreen()
      : SafeArea(
          child: Scaffold(
            backgroundColor: cs.primaryColor,
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 12.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.75,
                            // width: MediaQuery.of(context).size.width * 0.80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "CHECK",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 30,
                                              color: Colors.green),
                                        ),
                                        Text("YOUR EMAIL",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 30,
                                                color: Colors.green)),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Lottie.asset("assets/Verify_your_email.json",
                                    height: 200, width: 200),
                                Text(
                                  'We have sent you a Email on ${FirebaseAuth.instance.currentUser!.email}. please verify your email.',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomButton(
                                    buttonName: Text(
                                      "Resend",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isloading = true;
                                      });
                                      sendVerificationEmail();
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
}
