import 'package:cached_network_image/cached_network_image.dart';
import 'package:diet_schedule_app/Widgets/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {Key? key,
      this.name,
      this.calorie,
      this.quantity,
      this.image,
      this.veg,
      this.onPress,
      this.onLike , this.like})
      : super(key: key);

  String? name;
  int? calorie;
  String? quantity;
  String? image;
  bool? veg;
  Function()? onPress;
  Function()? onLike;
  IconButton? like;

  @override
  Widget build(BuildContext context) {
    Constant cs = Constant();

    return Container(
      decoration: BoxDecoration(
          color: veg! ? cs.secondaryColor : cs.alert.withOpacity(0.75),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? "",
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700),
                      softWrap: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(quantity ?? ""),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${calorie} Kcal",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: onLike,
                          child: Icon(CupertinoIcons.heart)),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: onPress,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: veg! ? cs.primaryColor : cs.alert),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(children: [
                                Icon(
                                  Icons.add,
                                  size: 15,
                                  color: cs.white,
                                ),
                                Text(
                                  "Schedule",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: cs.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
            const SizedBox(
              width: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                placeholder: (context, url) => Shimmer(
                  child: SizedBox(),
                  gradient: LinearGradient(
                    colors: [Colors.grey, Colors.white],
                  ),
                ),
                imageUrl: image!,
                height: 95,
                width: 95,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
