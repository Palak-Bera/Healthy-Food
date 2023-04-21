import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_schedule_app/Controllers/auth.dart';
import 'package:diet_schedule_app/Controllers/db.dart';
import 'package:diet_schedule_app/Screens/AuthenticationScreen/loginScreen.dart';
import 'package:diet_schedule_app/Widgets/customButton.dart';
import 'package:diet_schedule_app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Auth auth = Auth();
  List goal = ["Loss", "Gain", "Keep"];
  List allergy = ["Yes", "No"];
  List bodyShape = ["Super Fit", "Fit", "Average", "Bottom", "Central"];
  List physicalLevel = [1.2, 1.375, 1.55, 1.725, 1.90];
  String? _goalValue;
  String? allergyValue;
  String? bodyShapeValue;
  double? physicalLevelValue;
  Database db = Database();
  String? collectionId = FirebaseAuth.instance.currentUser!.email;
  TextEditingController _name = TextEditingController(text: "");
  TextEditingController _email = TextEditingController(text: "");
  TextEditingController _age = TextEditingController(text: "");
  TextEditingController _height = TextEditingController(text: "");
  TextEditingController _weight = TextEditingController(text: "");
  TextEditingController _calorie = TextEditingController(text: "");
  String profileimage = "";
  bool palak = true;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(collectionId)
        .snapshots()
        .listen((snapshot) {
      UserData data = UserData.fromJson(snapshot.data()!);
      _name.text = data.name!;
      _email.text = data.email!;
      _height.text = data.bodydata!.height.toString();
      _weight.text = data.bodydata!.weight.toString();
      _calorie.text = data.bodydata!.calorie.toString();
      _goalValue = "loss";
      print("❤️❤️❤️" + _name.text);
    });

    super.initState();
  }

  Future checkImageExists() async {
    bool exists = false;
    final path = 'users/${collectionId!}/profilepic.jpg';
    try {
      final ref = FirebaseStorage.instance.refFromURL(path);
      String url = await ref.getDownloadURL();
      setState(() {
        profileimage = url;
      });
    } catch (e) {
      print('Error checking image existence: $e');
    }
    return exists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "My Profile",
          style: TextStyle(color: Colors.green),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: cs.primaryColor,
                        width: 10.0,
                      ),
                    ),
                    child: ClipOval(
                      child: profileimage != ""
                          ? Image.network(
                              profileimage,
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            )
                          : Image.asset(
                              "assets/person.png",
                              fit: BoxFit.cover,
                              width: 150,
                              height: 150,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.green,
                        child: Icon(CupertinoIcons.camera),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                _name.text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                _email.text,
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(
              height: 20,
            ),

            buildField("Name", _name, true),

            buildField("Email", _email, false),

            builddoubleField("Height", _height, "Weight", _weight),

            buildField("Calorie", _calorie, false),

            const SizedBox(
              height: 20,
            ),

            ///  Goal of weight
            const Text(
              "Goal of weight",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: <Widget>[
                addGoalRadioButton(0, 'Loss'),
                addGoalRadioButton(1, 'Gain'),
                addGoalRadioButton(2, 'Keep'),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            /// allergy
            const Text(
              "Allergy",
              style: TextStyle(fontSize: 20),
              softWrap: true,
            ),
            Row(
              children: <Widget>[
                addAllergyRadioButton(0, 'Yes'),
                addAllergyRadioButton(1, 'No'),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            /// body shape
            const Text(
              "Body Shape",
              style: TextStyle(fontSize: 20),
              softWrap: true,
            ),
            const SizedBox(
              height: 10,
            ),

            Wrap(
              children: [
                addBodyShapeRadioButton(0, "assets/superfit.png", "Super Fit"),
                addBodyShapeRadioButton(1, "assets/fit.png", "Fit"),
                addBodyShapeRadioButton(2, "assets/average.png", "Average"),
                addBodyShapeRadioButton(3, "assets/bottom.png", "Bottom"),
                addBodyShapeRadioButton(4, "assets/central.png", "Central"),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                CustomButton(
                    buttonName: Text("LOGOUT" , style: TextStyle(color: cs.white , fontSize: 20 , fontWeight: FontWeight.w600),),
                    buttonColor: cs.primaryColor,
                    onTap: () {
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Confirm Logout",
                        desc: "Are you sure want to logout ?",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              auth.logout();
                              Navigator.of(context, rootNavigator: true)
                                  .pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const LoginScreen();
                                  },
                                ),
                                (_) => false,
                              );
                            },
                            color: Colors.green,
                          ),
                          DialogButton(
                            child: const Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.green, fontSize: 20),
                            ),
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true)
                                    .pop(),
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.green),
                          )
                        ],
                      ).show();
                    }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController _value, bool isEnable) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: TextFormField(
            style: TextStyle(color: isEnable ? Colors.black : Colors.grey),
            enabled: isEnable,
            controller: _value,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
              border: OutlineInputBorder(),
            ),
          ))
        ],
      ),
    );
  }

  Widget builddoubleField(String label1, TextEditingController _value1,
      String label2, TextEditingController _value2) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            label1,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextFormField(
              controller: _value1,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            label2,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextFormField(
              controller: _value2,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addGoalRadioButton(int btnValue, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            activeColor: Theme.of(context).primaryColor,
            value: goal[btnValue],
            groupValue: _goalValue,
            onChanged: (value) {
              setState(() {
                // print(goalValue);
                _goalValue = value;
              });
            },
          ),
          Text(title)
        ],
      ),
    );
  }

  addAllergyRadioButton(int btnValue, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
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
      ),
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
                height: 60,
                width: 35,
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

  void uploadImage(File image) async {
    final path = 'users/${collectionId!}/profilepic.jpg';
    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadtask = ref.putFile(image);

    final snapshot = await uploadtask.whenComplete(() {});
    print(snapshot);
    final urldownload = await snapshot.ref.getDownloadURL();

    setState(() {
      profileimage = urldownload;
    });
  }

  pickImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 512, maxHeight: 512);
    final file = File(image!.path);

    uploadImage(file);
  }
}
