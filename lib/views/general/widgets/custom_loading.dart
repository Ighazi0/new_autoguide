import 'package:autoguide/app/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.size = 100});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(LottiesAssets.loading, height: size));
  }
}
