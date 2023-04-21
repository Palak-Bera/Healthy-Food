import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:diet_schedule_app/Widgets/customappBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  Constant cs = Constant();
  String? collectionId = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Favorites",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: cs.primaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('favourite')
                    .doc(collectionId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: cs.primaryColor,
                      ),
                    );
                  } else {
                    List<Map<String, dynamic>> myList =
                        List<Map<String, dynamic>>.from(
                            snapshot.data!.data()!['favdish']);

                    /// Data is not available in list
                    if (snapshot.data!.data()!.isEmpty || myList.isEmpty) {
                      return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("assets/Empty_favourite.json",
                                  height: 300, width: 300),
                              Text(
                                "No Favourites yet !!!",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: cs.primaryColor),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Click the ♡ on meals page to add a favourite.",
                                style: TextStyle(color: cs.primaryColor),
                              )
                            ]),
                      );
                    }

                    /// Data is available in list
                    else {
                      List<Map<String, dynamic>> myList =
                          List<Map<String, dynamic>>.from(
                              snapshot.data!.data()!['favdish']);
                      return Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: myList.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Slidable(
                                key: Key(index.toString()),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) async {
                                        DocumentReference docRef =
                                            FirebaseFirestore.instance
                                                .collection('favourite')
                                                .doc(collectionId);

                                        docRef
                                            .get()
                                            .then((documentSnapshot) async {
                                          myList.removeAt(index);
                                          docRef
                                              .update({'favdish': myList})
                                              .then((value) =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      "Item removed successfully from favourite list.",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    backgroundColor:
                                                        cs.primaryColor,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        bottom: 10),
                                                  )))
                                              .catchError((error) =>
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      "Failed to remove item !!!",
                                                      style: TextStyle(
                                                          color: cs.white),
                                                    ),
                                                    backgroundColor: cs.alert,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        bottom: 10),
                                                  )));
                                        });
                                      },
                                      backgroundColor: cs.alert,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: cs.secondaryColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: favouriteCard(
                                        myList[index]['image'],
                                        myList[index]['name'],
                                        myList[index]['quantity'],
                                        myList[index]['calorie']),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget favouriteCard(
      String image, String name, String quantity, int calorie) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                placeholder: (context, url) => Shimmer(
                  child: SizedBox(),
                  gradient: LinearGradient(
                    colors: [Colors.grey, Colors.white],
                  ),
                ),
                imageUrl: image,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  softWrap: true,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  quantity,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  calorie.toString() + " Kcal",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Spacer(),
            const Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
