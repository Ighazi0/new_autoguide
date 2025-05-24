import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/navigator_services.dart';
import 'package:autoguide/views/user/plus/screens/auto_plus_screen.dart';
import 'package:flutter/material.dart';

class PlusWidget extends StatelessWidget {
  final bool inPlus;
  const PlusWidget({super.key, this.inPlus = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration:
          inPlus
              ? null
              : BoxDecoration(
                border: Border.all(color: AppStyle.primaryColor),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
      child: GestureDetector(
        onTap: () {
          if (!inPlus) {
            NavigatorServices.push(AutoPlusScreen());
          }
        },
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'AUTOGUIDE ',
                style: TextStyle(
                  color: AppStyle.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: 'PLUS',
                style: TextStyle(
                  color: AppStyle.secondryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
