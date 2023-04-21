import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:diet_schedule_app/Controllers/db.dart';
import 'package:diet_schedule_app/Controllers/notifications.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/Widgets/customCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

import 'package:shimmer/shimmer.dart';

class SetScheduleScreen extends StatefulWidget {
  const SetScheduleScreen({Key? key}) : super(key: key);

  @override
  State<SetScheduleScreen> createState() => _SetScheduleScreenState();
}

class _SetScheduleScreenState extends State<SetScheduleScreen> {
  DatePickerController _controller = DatePickerController();
  DateTime scheduleDate = DateTime.now();
  DateTime scheduleFromTime = DateTime.now();

  Database db = Database();
  int selectedIndex = 0;
  Constant cs = Constant();

  @override
  void initState() {
    NotificationService().requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
            "Set Schedule",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.w600, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('categories').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: cs.primaryColor,
                      ),
                    ),
                  ],
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),

                      // Date picker
                      DatePicker(
                        height: 100,
                        DateTime.now(),
                        controller: _controller,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: cs.primaryColor,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            scheduleDate = date;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // select time
                      Text(
                        "Select Time",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15),
                          color: cs.secondaryColor,
                        ),
                        child: TimePickerSpinner(
                          is24HourMode: false,
                          normalTextStyle:
                              TextStyle(fontSize: 16, color: Colors.grey),
                          highlightedTextStyle: TextStyle(
                            fontSize: 22,
                          ),
                          spacing: 30,
                          itemHeight: 25,
                          isForce2Digits: true,
                          onTimeChange: (time) {
                            setState(() {
                              scheduleFromTime = time;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // select category
                      const Text(
                        "Select Category",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // category list view
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            final json = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                            // final myList

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });

                                print("Pressed" + json['name']);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  width: 95,
                                  decoration: BoxDecoration(
                                      color: selectedIndex == index
                                          ? cs.primaryColor
                                          : null,
                                      border: Border.all(
                                          color: selectedIndex == index
                                              ? cs.secondaryColor
                                              : Colors.black),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: json['image'],
                                          placeholder: (context, url) =>
                                              Shimmer(
                                            child: SizedBox(),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.grey,
                                                Colors.white
                                              ],
                                            ),
                                          ),
                                          height: 57,
                                          width: 57,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Text(
                                            json['name'] ?? "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: selectedIndex == index
                                                    ? cs.white
                                                    : Colors.black),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      // select meals
                      const Text(
                        "Select Meals",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // category meals
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot
                              .data!.docs[selectedIndex]['dishes'].length,
                          itemBuilder: ((context, index) {
                            final json = snapshot.data!.docs[selectedIndex]
                                .data() as Map<String, dynamic>;

                            final mylist = json['dishes'] as List<dynamic>;

                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 15.0, top: 10),
                              child: CustomCard(
                                name: mylist[index]['name'],
                                calorie: mylist[index]['calorie'],
                                quantity: mylist[index]['quantity'],
                                image: mylist[index]['image'],
                                veg: mylist[index]['veg'],
                                onPress: () async {
                                  bool isallowed = await AwesomeNotifications()
                                      .isNotificationAllowed();

                                  int selectedDay = int.parse(
                                      DateFormat.d().format(scheduleDate));
                                  int selectedMonth = int.parse(
                                      DateFormat.M().format(scheduleDate));
                                  int selectedYear = int.parse(
                                      DateFormat.y().format(scheduleDate));
                                  int selectedHour = int.parse(
                                      DateFormat.H().format(scheduleFromTime));
                                  int selectedMin = int.parse(
                                      DateFormat.m().format(scheduleFromTime));
                                  int currentHour = int.parse(
                                      DateFormat.H().format(DateTime.now()));
                                  int currentMin = int.parse(
                                      DateFormat.m().format(DateTime.now()));
                                  int currentDay = int.parse(
                                      DateFormat.d().format(DateTime.now()));

                                  if (isallowed) {
                                    if (selectedDay == currentDay) {
                                      if ((selectedHour > currentHour) ||
                                          (selectedHour == currentHour &&
                                              selectedMin > currentMin)) {
                                        NotificationService()
                                            .showScheduledNotification(
                                                1,
                                                'main_channel',
                                                "Hey, fitness freaks!",
                                                "Your favorite ${mylist[index]['name']} from the ${json['name']} category is all set to be savored.",
                                                selectedDay,
                                                selectedMonth,
                                                selectedYear,
                                                selectedHour,
                                                selectedMin,
                                                mylist[index]['image']);
                                        db.addScheduleNotificationdata(scheduleDate , scheduleFromTime, mylist[index]['name'] , mylist[index]['quantity']);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            "Schedule your diet successfully",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          backgroundColor: cs.secondaryColor,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                        ));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Failed to schedule notification: please select valid time",
                                              style:
                                                  TextStyle(color: cs.white)),
                                          backgroundColor: cs.alert,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, bottom: 10),
                                        ));
                                      }
                                    } else {
                                      NotificationService()
                                          .showScheduledNotification(
                                              1,
                                              'main_channel',
                                              "Hey, fitness freaks!",
                                              "Your favorite ${mylist[index]['name']} from the ${json['name']} category is all set to be savored.",
                                              selectedDay,
                                              selectedMonth,
                                              selectedYear,
                                              selectedHour,
                                              selectedMin,
                                              mylist[index]['image']);
                                      db.addScheduleNotificationdata(scheduleDate , scheduleFromTime , mylist[index]['name'],
                                          mylist[index]['quantity']);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "Schedule your diet successfully",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        backgroundColor: cs.secondaryColor,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                      ));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Please granted the permission.",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      backgroundColor: cs.secondaryColor,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                    ));
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
