import 'dart:async';

import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/Widgets/customButton.dart';
import 'package:diet_schedule_app/Widgets/customappBar.dart';

import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProgressScreen extends StatefulWidget {
  ProgressScreen({Key? key}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  Constant cs = Constant();

  double progressValue = 20;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CustomAppBar(),
                   const SizedBox(
                    height: 15,
                  ),
                  const Center(
                      child: Text(
                    "You have reached 30% of your goals",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  // _getSementedProgressBar3(),
                  circleProgressBar()
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    color: cs.secondaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Your Progress Today",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            smallcircleProgressBar(
                                cs.lightred, cs.red),
                            smallcircleProgressBar(
                                cs.lightblue, cs.blue),
                            smallcircleProgressBar(
                                cs.lightyellow, cs.yellow),
                          ],
                        ),
                        Spacer(),
                        Text(
                          "Keep going you are doing well",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget circleProgressBar() {
    return SizedBox(
      height: 230,
      width: 230,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        animationDuration: 1500,
        axes: <RadialAxis>[
          RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 1,
            axisLineStyle: AxisLineStyle(
              thickness: 0.3,
              color: cs.secondaryColor,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: progressValue,
                width: 0.3,
                sizeUnit: GaugeSizeUnit.factor,
                enableAnimation: true,
                animationDuration: 30,
                animationType: AnimationType.linear,
                cornerStyle: CornerStyle.endCurve,
                color: cs.primaryColor,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                positionFactor: 0.1,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      progressValue.toStringAsFixed(0),
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      "Calorie",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget smallcircleProgressBar(Color background, Color filled) {
    return SizedBox(
      height: 70,
      width: 70,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: <RadialAxis>[
          RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 1,
            axisLineStyle: AxisLineStyle(
              thickness: 0.3,
              color: background,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                value: progressValue,
                width: 0.3,
                sizeUnit: GaugeSizeUnit.factor,
                enableAnimation: true,
                animationDuration: 30,
                animationType: AnimationType.linear,
                cornerStyle: CornerStyle.endCurve,
                color: filled,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                positionFactor: 0.1,
                widget: Container(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
