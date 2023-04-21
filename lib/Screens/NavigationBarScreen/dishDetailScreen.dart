import 'package:cached_network_image/cached_network_image.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:shimmer/shimmer.dart';

class DishDetailScreen extends StatefulWidget {
  const DishDetailScreen({Key? key, required this.dish}) : super(key: key);

  final Map<String, dynamic> dish;

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  Constant cs = Constant();

  final ExpandedTileController _ingredients =
      ExpandedTileController(isExpanded: false);

  final ExpandedTileController _preparation =
      ExpandedTileController(isExpanded: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cs.secondaryColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  // color: cs.secondaryColor,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Shimmer(
                                child: SizedBox(),
                                gradient: LinearGradient(
                                  colors: [Colors.grey, Colors.white],
                                ),
                              ),
                              imageUrl: widget.dish['image'],
                              height: 350,
                              width: 350,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.dish['name'],
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.dish['quantity'],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black45),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${widget.dish['calorie']} Kcal",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black45),
                          ),
                        ]),
                  ),
                ),
              const  SizedBox(
                  height: 20,
                ),
                /// nutritions information
              const  Text(
                  "Nutritional",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black45),
                ),
              const  Text(
                  "Information",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black45),
                ),
               const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    nutritions(
                        "assets/carbs.png", "Carbs", widget.dish['carbs']),
                    nutritions(
                        "assets/fiber.png", "Fiber", widget.dish['fiber']),
                    nutritions("assets/protein.png", "Protein",
                        widget.dish['protein']),
                    nutritions("assets/fat.png", "Fat", widget.dish['fat']),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // ingredients
                ExpandedTile(
                  trailing: Icon(
                    CupertinoIcons.arrowtriangle_down_square_fill,
                    size: 40,
                    color: cs.primaryColor,
                  ),
                  trailingRotation: 180,
                  theme: const ExpandedTileThemeData(
                    headerColor: Colors.white,
                    headerRadius: 15.0,
                    headerPadding: EdgeInsets.all(10.0),
                    contentBackgroundColor: Colors.white,
                    contentRadius: 15.0,
                  ),
                  controller: _ingredients,
                  title: Text("Ingredients",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )),
                  content: Center(
                    child: Text(
                      widget.dish['ingredients'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              // preparation method
                ExpandedTile(
                  trailing: Icon(
                    CupertinoIcons.arrowtriangle_down_square_fill,
                    size: 40,
                    color: cs.primaryColor,
                  ),
                  trailingRotation: 180,
                  theme: const ExpandedTileThemeData(
                    headerColor: Colors.white,
                    headerRadius: 15.0,
                    headerPadding: EdgeInsets.all(10.0),
                    contentBackgroundColor: Colors.white,
                    contentRadius: 15.0,
                  ),
                  controller: _preparation,
                  title: Text(
                    "Preparation Method",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  content: Center(
                    child: Text(
                      widget.dish['preparation'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nutritions(String path, String name, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
            opacity: 1,
            child: Image(
              image: AssetImage(path),
              height: 35,
              width: 35,
            )),
        Text(name),
        const SizedBox(
          height: 3,
        ),
        Text(value,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: cs.primaryColor))
      ],
    );
  }

  Widget customCard(String name) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.black45),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.arrowtriangle_down_square_fill,
                    size: 35,
                  ),
                  color: cs.primaryColor,
                )
              ],
            ),
          )),
    );
  }
}
