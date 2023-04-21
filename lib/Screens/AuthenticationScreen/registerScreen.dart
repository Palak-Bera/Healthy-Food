import 'package:diet_schedule_app/Controllers/db.dart';
import 'package:diet_schedule_app/Screens/AuthenticationScreen/loginScreen.dart';
import 'package:diet_schedule_app/Screens/AuthenticationScreen/verifyEmailScreen.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/Widgets/customButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../Controllers/auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterState();
}

TextEditingController _fname = TextEditingController();
TextEditingController _lname = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool _passwordVisible = true;
bool _confirmpasswordVisible = true;
Auth auth = Auth();
Constant cs = Constant();
Database database = Database();
bool isLoading = false;

class _RegisterState extends State<RegisterScreen> {
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
              child: Stack(
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
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),

                              /// Button switch
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/login');
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7 /
                                          2,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          border: Border.all(width: 1)),
                                      child: Center(
                                          child: Text(
                                        "Login",
                                        style:
                                            TextStyle(color: cs.primaryColor),
                                      )),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.7 /
                                        2,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: cs.primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("Register",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  )
                                ],
                              ),

                              const SizedBox(
                                height: 30,
                              ),

                              /// first name
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: TextFormField(
                                  controller: _fname,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "First name cannot be empty";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(CupertinoIcons.person),
                                      hintText: "First Name"),
                                ),
                              ),

                              /// Last name
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _lname,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Last name cannot be empty";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(CupertinoIcons.person),
                                      hintText: "Last Name"),
                                ),
                              ),

                              /// email address
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: _email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email address cannot be empty';
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      return 'Please enter a valid email';
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(CupertinoIcons.mail),
                                      hintText: "Email"),
                                ),
                              ),

                              /// pwd
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password cannot be empty";
                                    }
                                    return null;
                                  },
                                  controller: _password,
                                  obscureText: _passwordVisible,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    prefixIcon: Icon(CupertinoIcons.lock),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
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
                              ),

                              /// confirm pwd
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password cannot be empty";
                                  } else if (value != _password.text) {
                                    return "Password does not match";
                                  }
                                  return null;
                                },
                                obscureText: _confirmpasswordVisible,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  prefixIcon: Icon(CupertinoIcons.lock),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _confirmpasswordVisible =
                                              !_confirmpasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _confirmpasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey)),
                                ),
                              ),

                              const SizedBox(
                                height: 30,
                              ),

                              /// Register Button
                              isLoading
                                  ? CircularProgressIndicator(
                                      color: cs.primaryColor,
                                    )
                                  : CustomButton(
                                      buttonName: Text(
                                        "Register",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoading = true;
                                          });

                                          auth
                                              .register(
                                                  _email.text, _password.text)
                                              .then((value) {
                                            if (value == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "Registration Successfully",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                backgroundColor:
                                                    cs.secondaryColor,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 10),
                                              ));
                                              final name = _fname.text +
                                                  " " +
                                                  _lname.text;
                                              final email = FirebaseAuth
                                                  .instance.currentUser!.email;

                                              database.createUser(name, email);
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.pushReplacementNamed(
                                                  context, '/verifyemail');
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(value),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  margin: EdgeInsets.only(
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
