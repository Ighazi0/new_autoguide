import 'package:autoguide/views/user/landing/nashmi/nashmi_view.dart';
import 'package:autoguide/views/user/landing/sooq/sooq_view.dart';
import 'package:autoguide/views/user/landing/stores/stores_view.dart';
import 'package:autoguide/views/user/landing/widgets/banners_widget.dart';
import 'package:autoguide/views/user/landing/widgets/types_widget.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Column(
      children: [
        BannersWidget(),
        TypesWidget(pageController: pageController),
        Expanded(
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [StoresView(), SooqView(), NashmiView()],
          ),
        ),
      ],
    );
  }
}
