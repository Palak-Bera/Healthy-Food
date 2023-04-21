import 'package:diet_schedule_app/Controllers/db.dart';
import 'package:diet_schedule_app/Screens/BodydetailsScreen/congratulationsScreen.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';

class YourGoalScreen extends StatefulWidget {
  YourGoalScreen({Key? key}) : super(key: key);

  @override
  State<YourGoalScreen> createState() => _YourGoalScreenState();
}

class _YourGoalScreenState extends State<YourGoalScreen> {
  List goal = ["Loss", "Gain", "Keep"];
  List allergy = ["Yes", "No"];
  List bodyShape = ["Super Fit", "Fit", "Average", "Bottom", "Central"];
  List physicalLevel = [1.2, 1.375, 1.55, 1.725, 1.90];
  int meals = 0;
  int snacks = 0;
  int drinks = 0;
  String? goalValue;
  String? allergyValue;
  String? bodyShapeValue;
  double? physicalLevelValue;
  Database db = Database();
  Constant cs = Constant();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cs.primaryColor,
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "YOUR GOAL",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),

                            ///  Goal of weight
                            const Text(
                              "Goal of weight",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: <Widget>[
                                addGoalRadioButton(0, 'Loss'),
                                addGoalRadioButton(1, 'Gain'),
                                addGoalRadioButton(2, 'Keep'),
                              ],
                            ),

                            /// number of meals
                            const Text(
                              "Number of Meals",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Meals"),
                                Text("Snacks"),
                                Text("Drinks")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                QuantityInput(
                                  buttonColor: Colors.green,
                                  iconColor: Colors.white,
                                  inputWidth: 30,
                                  value: meals,
                                  onChanged: (value) => setState(
                                    () => meals = int.parse(
                                      value.replaceAll(',', ''),
                                    ),
                                  ),
                                ),
                                QuantityInput(
                                  buttonColor: Colors.white,
                                  iconColor: Colors.green,
                                  inputWidth: 30,
                                  value: snacks,
                                  onChanged: (value) => setState(
                                    () => snacks = int.parse(
                                      value.replaceAll(',', ''),
                                    ),
                                  ),
                                ),
                                QuantityInput(
                                  buttonColor: Colors.green,
                                  inputWidth: 30,
                                  value: drinks,
                                  onChanged: (value) => setState(
                                    () => drinks = int.parse(
                                      value.replaceAll(',', ''),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            /// allergy
                            const Text(
                              "Do you have an allergy to a certain Food ? ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                              softWrap: true,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                addAllergyRadioButton(0, 'Yes'),
                                addAllergyRadioButton(1, 'No'),
                              ],
                            ),

                            /// body shape
                            const Text(
                              "Choose your Body Shape? ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                              softWrap: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              children: [
                                addBodyShapeRadioButton(
                                    0, "assets/superfit.png", "Super Fit"),
                                addBodyShapeRadioButton(
                                    1, "assets/fit.png", "Fit"),
                                addBodyShapeRadioButton(
                                    2, "assets/average.png", "Average"),
                                addBodyShapeRadioButton(
                                    3, "assets/bottom.png", "Bottom"),
                                addBodyShapeRadioButton(
                                    4, "assets/central.png", "Central"),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            /// body shape
                            const Text(
                              "Choose your Physical Activity Level ? ",
                              style: TextStyle(fontWeight: FontWeight.w700),
                              softWrap: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            addPhysicalLevelRadioButton(
                                0, "Sednetary (Little or No Excercise)"),
                            addPhysicalLevelRadioButton(1,
                                "Light Active (light Excercise/sports 1-3 days/week)"),
                            addPhysicalLevelRadioButton(2,
                                "Moderately active (Moderate Excercise/sports 3-5 days/week)"),
                            addPhysicalLevelRadioButton(3,
                                "Very active (Hard Excercise/sports 6-7 days/week)"),
                            addPhysicalLevelRadioButton(4,
                                "Extra active (Very Hard Excercise/sports 6-7 days/week)"),

                            const SizedBox(
                              height: 20,
                            ),

                            isLoading
                                ? CircularProgressIndicator(
                                    color: cs.primaryColor,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (goalValue == null ||
                                              allergyValue == null ||
                                              bodyShapeValue == null ||
                                              physicalLevelValue == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Please Enter all details"),
                                                backgroundColor: cs.alert,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 10),
                                              ),
                                            );
                                          } else {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            db.addgoaldata(
                                              goalValue!,
                                              meals,
                                              snacks,
                                              drinks,
                                              allergyValue!,
                                              bodyShapeValue!,
                                              physicalLevelValue!,
                                            );
                                           
                                            Navigator.pushNamed(
                                                context, '/congratulation');
                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Center(
                                              child: Text(
                                            "Proceed",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          )),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                        ),
                                      ),
                                    ],
                                  ),

                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  addGoalRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: goal[btnValue],
          groupValue: goalValue,
          onChanged: (value) {
            setState(() {
              goalValue = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  addAllergyRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: allergy[btnValue],
          groupValue: allergyValue,
          onChanged: (value) {
            setState(() {
              allergyValue = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  addBodyShapeRadioButton(int btnValue, String title, String label) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            activeColor: Theme.of(context).primaryColor,
            value: bodyShape[btnValue],
            groupValue: bodyShapeValue,
            onChanged: (value) {
              setState(() {
                bodyShapeValue = value;
              });
            },
          ),
          Column(
            children: [
              Image(
                image: AssetImage(title),
                height: 55,
                width: 30,
              ),
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
    );
  }

  addPhysicalLevelRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: physicalLevel[btnValue],
          groupValue: physicalLevelValue,
          onChanged: (value) {
            setState(() {
              physicalLevelValue = value;
            });
          },
        ),
        Expanded(
            child: Text(
          title,
          softWrap: true,
        ))
      ],
    );
  }
}
