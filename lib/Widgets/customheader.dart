import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  CustomHeader({this.leadicon, required this.header , this.onTap ,});

  Icon? leadicon;
  Function()? onTap;
  Text header;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              onPressed: onTap ?? () {
                Navigator.of(context).pop();
              },
              icon: leadicon ?? Icon(CupertinoIcons.back),
              iconSize: 40,
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width * 0.3,
            child: header
          ),
        ],
      ),
    );
  }
}
