import 'dart:isolate';

import 'package:diet_schedule_app/Controllers/db.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/Widgets/customButton.dart';
import 'package:diet_schedule_app/Screens/BodydetailsScreen/yourGoal.dart';
import 'package:flutter/material.dart';

class BodyDataScreen extends StatefulWidget {
  const BodyDataScreen({Key? key}) : super(key: key);

  @override
  State<BodyDataScreen> createState() => _BodyDataScreenState();
}

class _BodyDataScreenState extends State<BodyDataScreen> {
  List gender = [
    "Male",
    "Female",
  ];
  List<int> feetList = [1, 2, 3, 4, 5, 6, 7, 8];
  List<int> inchList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  int? selectedFeet;
  int? selectedInch;
  String? selectedGender;
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
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
            child: Column(
              children: [
                const Text(
                  "BODY DATA",
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),

                            /// gender
                            Row(
                              children: <Widget>[
                                const Text(
                                  "Gender",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                addRadioButton(0, 'Male'),
                                addRadioButton(1, 'Female'),
                              ],
                            ),

                            /// age
                            const Text(
                              "Age",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _ageController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "Age",
                                  border: OutlineInputBorder(
                                    gapPadding: 2.0,
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            /// height
                            const Text(
                              "Height",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(child: buildFeetDropdown()),
                                SizedBox(width: 16),
                                Expanded(child: buildInchDropdown()),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            /// weight
                            const Text(
                              "Weight",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _weightController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: "Weight",
                                  border: OutlineInputBorder(
                                    gapPadding: 2.0,
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            /// continue button
                            isLoading
                                ? CircularProgressIndicator(
                                    color: cs.primaryColor,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButton(
                                        buttonName: const Text(
                                          "Proceed",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        onTap: () {
                                          if (selectedFeet == null ||
                                              selectedGender == null ||
                                              selectedInch == null ||
                                              _ageController.text == null ||
                                              _weightController.text == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "Please enter all details"),
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
                                            double feetTocm =
                                                (selectedFeet!.toDouble() *
                                                    30.48);
                                            double inchTocm =
                                                (selectedFeet!.toDouble() *
                                                    2.54);
                                            double height =
                                                (feetTocm + inchTocm);
                                            int age =
                                                int.parse(_ageController.text);
                                            double weight = double.parse(
                                                _weightController.text);
                                            String gender = selectedGender!;
                                            db.addbodydata(
                                                gender, age, weight, height);

                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.pushNamed(
                                                context, '/goal');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 20,
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
    );
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: selectedGender,
          onChanged: (value) {
            setState(() {
              selectedGender = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Widget buildFeetDropdown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            hint: Text("Feet"),
            value: selectedFeet,
            onChanged: (feet) {
              setState(() {
                selectedFeet = feet;
              });
            },
            items: feetList.map((feet) {
              return DropdownMenuItem<int>(
                value: feet,
                child: Text('$feet ft'),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget buildInchDropdown() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            hint: Text("Inch"),
            value: selectedInch,
            onChanged: (inch) {
              setState(() {
                selectedInch = inch;
              });
            },
            items: inchList.map((inch) {
              return DropdownMenuItem<int>(
                value: inch,
                child: Text('$inch in'),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
