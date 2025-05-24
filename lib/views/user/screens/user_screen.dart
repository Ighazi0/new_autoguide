import 'package:autoguide/views/user/widgets/user_app_bar.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(appBar: UserAppBar()),
    );
  }
}
