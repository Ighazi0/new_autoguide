import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final Color? color;

  const CustomShimmer({
    super.key,
    required this.isLoading,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: color ?? Colors.grey.withAlpha(70),
            highlightColor: color ?? Colors.grey.withAlpha(50),
            child: child,
          )
        : child;
  }
}
