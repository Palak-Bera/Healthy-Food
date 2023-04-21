import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {required this.buttonName, required this.onTap, this.buttonColor});

  Text buttonName;
  Function() onTap;
  Color? buttonColor;
  Constant cs = Constant();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Center(child: buttonName),
        decoration: BoxDecoration(
            color: buttonColor ?? cs.primaryColor,
            borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
