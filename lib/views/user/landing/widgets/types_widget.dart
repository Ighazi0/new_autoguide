import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/controllers/main_controller.dart';
import 'package:autoguide/data/static_data.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';

class TypesWidget extends StatelessWidget {
  final PageController pageController;
  const TypesWidget({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final mainController = MainController();
    return ValueListenableBuilder<int>(
      valueListenable: mainController.selectedType,
      builder: (context, selectedType, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              StaticData.landing.length,
              (index) => GestureDetector(
                onTap: () async {
                  mainController.selectedType.value = index;
                  pageController.jumpToPage(index);
                },
                child: Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: AppStyle.borderRadius,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: selectedType == index
                      ? Colors.blue.shade100
                      : Colors.grey.shade300,
                  label: Text(StaticData.landing[index].tr),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
