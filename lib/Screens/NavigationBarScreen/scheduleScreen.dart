import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/setScheduleScreen.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/Widgets/customButton.dart';
import 'package:diet_schedule_app/Widgets/customCard.dart';
import 'package:diet_schedule_app/Widgets/customappBar.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  Constant cs = Constant();
  List _scheduledNotifications = [];

  @override
  void initState() {
    super.initState();
    _getScheduledNotifications();
  }

  void _getScheduledNotifications() async {
    List scheduledNotifications =
        await AwesomeNotifications().listScheduledNotifications();
    setState(() {
      _scheduledNotifications = scheduledNotifications;
    });
    print(_scheduledNotifications);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomAppBar(),
              const SizedBox(
                height: 15,
              ),
              DatePicker(
                height: 80,
                DateTime.now(),
                controller: _controller,
                initialSelectedDate: DateTime.now(),
                selectionColor: cs.primaryColor,
                monthTextStyle: TextStyle(fontSize: 0),
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedValue = date;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "{$_selectedValue}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                color: cs.secondaryColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Reminder",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Dont'forget schedule for tomorrow",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              Container(
                height: 200,
                color: cs.secondaryColor,
                child: ListView.builder(
                  itemCount: _scheduledNotifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    NotificationModel notification =
                        _scheduledNotifications[index];
                    return ListTile(
                      title: Text(notification.content!.title ?? ''),
                      
                     
                      trailing: Text(notification.content!.displayedDate.toString()),
                    );
                  },
                ),
              ),
              CustomButton(
                  buttonName: Text("Set Schedule"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SetScheduleScreen();
                      },
                    ));
                  })
            ]),
          ),
        ),
      ),
    );
  }
}
