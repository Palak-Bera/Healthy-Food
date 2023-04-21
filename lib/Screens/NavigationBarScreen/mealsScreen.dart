import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_schedule_app/Controllers/db.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/dishDetailScreen.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/Widgets/customCard.dart';
import 'package:diet_schedule_app/Widgets/customappBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///  using stream builder to display category

class MealsScreen extends StatefulWidget {
  const MealsScreen({Key? key}) : super(key: key);

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  Constant cs = Constant();
  Database db = Database();
  // bool islike = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('categories').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: cs.primaryColor,
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(),
                    const SizedBox(
                      height: 20,
                    ),
                    // heading
                    Text(
                      "Your Meals",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: cs.primaryColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // listview veritcal
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          /// store data as map from particular index json
                          final json = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;

                          /// convert from map to list
                          final mylist = json['dishes'] as List<dynamic>;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    json['name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(CupertinoIcons.arrow_right))
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 130,

                                /// Listview horizontal
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mylist.length,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // sendidg data of particular index pf dish list
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return DishDetailScreen(
                                                  dish: mylist[index]);
                                            },
                                          ));
                                        },
                                        child: CustomCard(
                                          name: mylist[index]['name'],
                                          calorie: mylist[index]['calorie'],
                                          quantity: mylist[index]['quantity'],
                                          image: mylist[index]['image'],
                                          veg: mylist[index]['veg'],

                                          onLike: () {
                                            db.updatefavourite(
                                                mylist[index]['name'],
                                                mylist[index]['calorie'],
                                                mylist[index]['quantity'],
                                                mylist[index]['image'],
                                                );

                                             ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                "Item added successfully to favourite list.",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              backgroundColor:
                                                  cs.primaryColor,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                            ));

                                            
                                            
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
