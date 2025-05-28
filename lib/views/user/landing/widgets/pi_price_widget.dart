import 'package:autoguide/app/app_assets.dart';
import 'package:autoguide/controllers/main_controller.dart';
import 'package:flutter/material.dart';

class PiPriceWidget extends StatelessWidget {
  const PiPriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double?>(
      future: MainController().getPiPriceInUSD(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Chip(
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(ImagesAssets.pi, width: 30, height: 30),
                SizedBox(width: 5),
                Text(
                  'Pi Network Price: \$${snapshot.data!.toStringAsFixed(4)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
