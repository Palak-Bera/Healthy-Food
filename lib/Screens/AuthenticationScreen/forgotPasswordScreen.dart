import 'package:diet_schedule_app/Screens/AuthenticationScreen/loginScreen.dart';
import 'package:diet_schedule_app/Screens/AuthenticationScreen/registerScreen.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/Widgets/customButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

TextEditingController _email = TextEditingController();
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
Constant cs = Constant();
bool isLoading = false;

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cs.primaryColor,
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(CupertinoIcons.arrow_left),
                                    iconSize: 40,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "RESET",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 30,
                                          color: Colors.green),
                                    ),
                                    Text("PASSWORD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 30,
                                            color: Colors.green)),
                                  ],
                                )
                              ],
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            /// animation +  text
                            Lottie.asset("assets/Forgot_Passward.json",
                                height: 200, width: 200),
                            const Text(
                              "Enter the email address associated with your account and we will send you a link to reset your password.",
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            /// email
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: TextFormField(
                                controller: _email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email address cannot be empty';
                                  } else if (!EmailValidator.validate(value)) {
                                    return 'Please enter a valid email';
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Email",
                                    prefixIcon: Icon(CupertinoIcons.person)),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            /// continue
                            isLoading
                                ? CircularProgressIndicator(
                                    color: cs.primaryColor,
                                  )
                                : CustomButton(
                                    buttonName: Text(
                                      "Continue",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        auth
                                            .resetPassword(
                                          _email.text,
                                        )
                                            .then((value) {
                                          if (value == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Password Reset link sent successfully"),
                                              backgroundColor: Colors.green,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                            ));

                                            setState(() {
                                              isLoading = false;
                                            });

                                            Navigator.of(context).pop();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(value),
                                                backgroundColor:
                                                    Colors.redAccent,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 10),
                                              ),
                                            );
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        });
                                      }
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
