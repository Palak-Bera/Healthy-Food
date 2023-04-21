import 'package:diet_schedule_app/Screens/NavigationBarScreen/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    
    super.initState();
  }

  // check() async {
  //   String? collectionId = FirebaseAuth.instance.currentUser!.email;

  //   final path = '${collectionId!}/profilepic.jpg';

  //   final photoRef = FirebaseStorage.instance.ref().child(path);
  //   FullMetadata metadata = await photoRef.getMetadata();
  //   print(metadata.size);
  // }

  bool _isprofile = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(CupertinoIcons.back)),

        Container(
          height: 30,
          width: 150,
          child: Center(child: Text("Search")),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)),
        ),
        Spacer(),
        Icon(CupertinoIcons.bell , size: 30,),
        SizedBox(
          width: 15,
        ),
        Icon(CupertinoIcons.bubble_left , size: 30,),
        SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ProfileScreen();
              },
            ));
          },
          child: Icon(CupertinoIcons.person , size : 30),
        ),
      ],
    );
  }
}
