import 'package:diet_schedule_app/Screens/NavigationBarScreen/favouriteScreen.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/homeScreen.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/mealsScreen.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/progressScreen.dart';
import 'package:diet_schedule_app/Screens/NavigationBarScreen/scheduleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavigationBarScreen extends StatefulWidget {
  NavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}


List<Widget> _buildScreens() {
  return [ProgressScreen(), MealsScreen() , HomeScreen() , FavouriteScreen() , ScheduleScreen()];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.play_rectangle),
      title: ("Progress"),
      activeColorPrimary:  Colors.green,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.square),
      title: ("Meals"),
      activeColorPrimary: Colors.green,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),

        PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Home"),
      activeColorPrimary:  Colors.green,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),

        PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.heart),
      title: ("Favourite"),
      activeColorPrimary:  Colors.green,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),

        PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.clock),
      title: ("Schedule"),
      activeColorPrimary: Colors.green,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),

  ];
}


class _NavigationBarScreenState extends State<NavigationBarScreen> {
 
 PersistentTabController _controller = PersistentTabController(initialIndex: 2);

 
  @override
  Widget build(BuildContext context) {
     return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}