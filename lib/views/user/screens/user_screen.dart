import 'package:autoguide/views/user/friends/screens/friends_screen.dart';
import 'package:autoguide/views/user/home/screens/home_screen.dart';
import 'package:autoguide/views/user/landing/screens/landing_screen.dart';
import 'package:autoguide/views/user/menu/screens/menu_screen.dart';
import 'package:autoguide/views/user/notifications/screens/notifications_screen.dart';
import 'package:autoguide/views/user/widgets/user_app_bar.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: UserAppBar(),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            LandingScreen(),
            HomeScreen(),
            FriendsScreen(),
            NotificationsScreen(),
            MenuScreen(),
          ],
        ),
      ),
    );
  }
}
