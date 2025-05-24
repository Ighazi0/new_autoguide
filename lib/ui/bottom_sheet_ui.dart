import 'package:flutter/material.dart';

class BottomSheetUI {
  static showSimpleBottomSheet(Widget child, BuildContext context) {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 10),
              child: child);
        });
  }

  static showDragBottomSheet(
      Widget Function(ScrollController) child, BuildContext context,
      {double initialChildSize = 0.6, bool enableDrag = true}) {
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        enableDrag: enableDrag,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: initialChildSize,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              expand: false,
              builder: (context, scrollController) {
                return child(scrollController);
              });
        });
  }
}
