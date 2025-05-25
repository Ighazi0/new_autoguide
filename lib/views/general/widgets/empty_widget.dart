import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'no_data_found'.tr,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
