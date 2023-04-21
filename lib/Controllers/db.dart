import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_schedule_app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class Database {
  String? collectionId = FirebaseAuth.instance.currentUser!.email;

  /// add user data
  Future createUser(String? name, String? email) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(email);
    final user = UserData(name: name ?? "Null", email: email ?? "Null");
    final json = user.toJson();
    await docUser.set(json);
  }

  /// add body data
  Future addbodydata(
      String gender, int age, double weight, double height) async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(collectionId!);

    Map<String, dynamic> newData = {
      "bodydata": {
        "gender": gender,
        "age": age,
        "height": height,
        "weight": weight,
      }
    };
    await docUser.set(newData, SetOptions(merge: true));
  }

  /// add goal data
  Future addgoaldata(
      String goalValue,
      int meals,
      int snacks,
      int drinks,
      String allergyValue,
      String bodyShapeValue,
      double physicalLevelValue) async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(collectionId);

    Map<String, dynamic> newData = {
      "bodydata": {
        "goal of Weight": goalValue,
        "meals": meals,
        "snacks": snacks,
        "drinks": drinks,
        "allergy": allergyValue,
        "body shape": bodyShapeValue,
        "physical activity level": physicalLevelValue,
      }
    };
    await docUser.set(newData, SetOptions(merge: true));
  }

  /// add calorie data
  Future addCaloriedata(
    double calorie,
  ) async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(collectionId);
    Map<String, dynamic> newData = {
      "bodydata": {
        "maintainable Calorie": calorie,
      }
    };
    await docUser.set(newData, SetOptions(merge: true));
  }

  /// add notification data
  Future addNotificationdata(bool reminder, bool waterreminder) async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(collectionId);

    Map<String, dynamic> newData = {
      "notification": {"reminder": reminder, "water reminder": waterreminder}
    };
    await docUser.set(newData, SetOptions(merge: true));
  }

  /// add schedule notification data
  Future addScheduleNotificationdata(
      DateTime scheduleDate, DateTime scheduletime , String name , String quantity) async {
    String date = DateFormat("dd-MM-yyyy").format(scheduleDate);
    String time = DateFormat( "hh:mm").format(scheduletime);


    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(collectionId)
        .collection('reminder')
        .doc(date);

    Map<String, dynamic> newData = {
      'scheduledDish': FieldValue.arrayUnion([
        {"name": name, 
         "quantity" : quantity, 
        "time": time
        }
      ])
    };

    await docUser.set(newData, SetOptions(merge: true));
  }

  /// update favorite list data
  Future updatefavourite(
      String name, int calorie, String quantity, String image) async {
    final collectionRef =
        FirebaseFirestore.instance.collection('favourite').doc(collectionId);
    await collectionRef.set({
      'favdish': FieldValue.arrayUnion([
        {"name": name, "calorie": calorie, "quantity": quantity, "image": image}
      ])
    }, SetOptions(merge: true));
  }

  /// update profile
  Future updateprofile(String name, double height, double weight) async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(collectionId);

    Map<String, dynamic> newData = {
      "name": name,
      "bodydata": {
        "weight": weight,
        "height": height,
        "maintainable Calorie": 2000.0
      }
    };

    await docUser.update(newData);
  }

  /// Read User data
  Future readbodyData() async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc(collectionId);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserData.fromJson(snapshot.data()!);
    }
  }
}
