import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
   CustomSnackBar({Key? key ,  this.background , required this.message}) : super(key: key);

   Color? background;
   Text message;
   Constant cs = Constant();

  @override
  Widget build(BuildContext context) {
    return SnackBar(
       content: message,
      backgroundColor: background ?? cs.secondaryColor,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
    );
  }
}