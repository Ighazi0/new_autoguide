import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String? title;
  const EmptyWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (title ?? 'no_data_found').tr,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
