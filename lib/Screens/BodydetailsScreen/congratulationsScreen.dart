import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_schedule_app/Controllers/db.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/navBar.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({Key? key}) : super(key: key);

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  double? bmr;
  double? pal;
  double? callories;
  Database db = Database();
  bool? reminder = false;
  bool? waterreminder = false;
  Constant cs = Constant();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cs.primaryColor,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "CONGRATULATIONS",
            style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          Center(
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
                            child: FutureBuilder(
                              future: db.readbodyData(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  UserData data = snapshot.data;
                                  
                                  num weight = data.bodydata!.weight as num;
                                  num height = data.bodydata!.height as num;
                                  num age = data.bodydata!.age as num;
                                  pal = data.bodydata!.physicalActivityLevel;

                                  if (data.bodydata!.gender == "female") {
                                    bmr = 10 * (weight) +
                                        6.25 * (height) -
                                        5 * (age) -
                                        161;
                                    callories = (bmr!) * (pal!);
                                  } else {
                                    bmr = 10 * (weight) +
                                        6.25 * (height) -
                                        5 * (age) +
                                        5;
                                    callories = (bmr!) * (pal!);
                                  }

                                  return bmr == null
                                      ?  Center(
                                          child: CircularProgressIndicator(
                                            color: cs.primaryColor,
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            const Text(
                                              "Your plan is ready and you are one step closer to your goal weight.",
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            const Text(
                                              "Your daily net maintainable calorie goal is :",
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.w700),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Center(
                                              child: Text(
                                                callories.toString() +
                                                    " cal/day",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.green,
                                                  fontSize: 22,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            const Divider(
                                              color: Colors.grey,
                                              thickness: 2,
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              children: [
                                                Checkbox(
                                                  activeColor: Colors.green,
                                                  value: reminder,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      reminder = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Keep me on track with reminders.",
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Checkbox(
                                                  activeColor: Colors.green,
                                                  value: waterreminder,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      waterreminder = value;
                                                    });
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Use my phone to track my steps.",
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 60,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    db.addCaloriedata(
                                                      callories!,
                                                    );
                                                    db.addNotificationdata(
                                                        reminder!,
                                                        waterreminder!);
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return NavigationBarScreen();
                                                      },
                                                    ));
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    child: Center(
                                                        child: Text(
                                                      "Continue",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w700),
                                                    )),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    30)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(color: cs.primaryColor,),
                                  );
                                }
                              },
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
