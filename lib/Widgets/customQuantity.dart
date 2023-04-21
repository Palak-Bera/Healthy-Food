import 'package:flutter/material.dart';

class QuantityButton extends StatefulWidget {
  const QuantityButton({super.key});

  @override
  State<QuantityButton> createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Ink(
       
          decoration: const ShapeDecoration(
            color: Colors.green,
            shape: CircleBorder(),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Colors.black,
            
          ),
        ),
        Text(""),
        IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
      ],
    );
  }
}
