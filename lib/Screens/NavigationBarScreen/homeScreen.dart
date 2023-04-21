import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_schedule_app/Controllers/db.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/profileScreen.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///  using stream builder to display category

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Database db = Database();
  Constant cs = Constant();
  String? name = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('categories').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(color: cs.primaryColor,),
                    ),
                  ],
                );
              } else {
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///  heading with photo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Good Morning"),
                            Text(
                              name ?? "",
                             style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.bell),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(CupertinoIcons.bubble_left),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ProfileScreen();
                                  },
                                ),);
                              },
                              child: Hero(
                                tag: "my-profile",
                                child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        AssetImage("assets/person.png")),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),

                    /// Choose the food you love
                   const Text("Choose the"),
                   const Text(
                      "Food you love",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                   const SizedBox(
                      height: 10,
                    ),

                    /// Search Field
                    Container(
                      height: 50,
                      child:  Center(child: Text("Search for a food item"),),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// Categories
                    Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700 , color: cs.primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            final json =  snapshot.data!.docs[index].data() as Map<String, dynamic>;

                            return GestureDetector(
                              onTap: () {
                                print("Pressed" +  json['name']);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                 
                                  width: 95,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
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
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            );
                          }),),
                    ),

                  const  SizedBox(
                      height: 10,
                    ),

                    /// upcoming Schedules
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Upcoming Schedules",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700 , color: cs.primaryColor),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.green,
                        )
                      ],
                    ),

                  const  SizedBox(
                      height: 20,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      color: Colors.lightGreen[100],
                      child: Image(image: AssetImage("assets/schedule.png")),
                    ),
                   
                   const  SizedBox(
                      height: 20,
                    ),

                    /// Suggested For you
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Suggested For you",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700 , color: cs.primaryColor),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: cs.primaryColor,
                        )
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 230,
                              decoration: BoxDecoration(
                                  color: cs.secondaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Grilled Vegitables",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "103 cal",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.heart),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print("❤️");
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: cs.primaryColor),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Row(children: [
                                                  Icon(
                                                    Icons.add,
                                                    size: 15,
                                                  ),
                                                  Text(
                                                    "Schedule",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  )
                                                ]),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    ));
  }
}
