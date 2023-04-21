import 'package:diet_schedule_app/Controllers/db.dart';

import 'package:diet_schedule_app/Screens/AuthenticationScreen/registerScreen.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/navBar.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/Widgets/customButton.dart';
import 'package:diet_schedule_app/Screens/BodydetailsScreen/bodyDataScreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();
Database database = Database();
bool isLoading = false;
Constant cs = Constant();
bool _passwordVisible = true;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cs.primaryColor,
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              /// card
              child: Padding(
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
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),

                          /// Switch Login
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.7 / 2,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: cs.primaryColor,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                ),
                                child: const Center(
                                    child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/register');
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.7 /
                                      2,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      border: Border.all(width: 1)),
                                  child: Center(
                                    child: Text("Register",
                                        style:
                                            TextStyle(color: cs.primaryColor)),
                                  ),
                                ),
                              )
                            ],
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
                                  hintText: "Email",
                                  prefixIcon: Icon(CupertinoIcons.person)),
                            ),
                          ),

                          /// password
                          TextFormField(
                            controller: _password,
                            obscureText: _passwordVisible,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password cannot be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(CupertinoIcons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          /// forgot password
                          Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/forgotpassword');
                                  },
                                  child: Text("Forgot Password ?"))),
                          const SizedBox(
                            height: 60,
                          ),

                          /// login button
                         isLoading ? CircularProgressIndicator(color: cs.primaryColor,) : CustomButton(
                            buttonName: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                // check for login...
                                setState(() {
                                  isLoading = true;
                                });
                                auth
                                    .login(_email.text, _password.text)
                                    .then((value) {
                                  if (value == null) {
                                    /// check email verified...
                                    if (FirebaseAuth
                                        .instance.currentUser!.emailVerified) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "LoggedIn Successfully",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        backgroundColor: cs.secondaryColor,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                      ));
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pushReplacementNamed(
                                          context, '/navigationbar');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text("Please Verify your email"),
                                        backgroundColor: cs.alert,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                      ));
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pushReplacementNamed(
                                          context, '/verifyemail');
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(value),
                                        backgroundColor: cs.alert,
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
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

                          const SizedBox(
                            height: 20,
                          ),

                          const Text("OR"),

                          /// google signIn
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SignInButton(
                                Buttons.googleDark,
                                onPressed: () {
                                  auth.signWithGoogle().then(
                                    (value) {
                                      if (value == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "LoggedIn Successfully",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            backgroundColor: cs.secondaryColor,
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                          ),
                                        );

                                        Navigator.pushReplacementNamed(
                                            context, '/bodydata');
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(value),
                                            backgroundColor: cs.alert,
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
