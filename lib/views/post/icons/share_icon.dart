import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/controllers/main_controller.dart';
import 'package:autoguide/models/post_model.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:autoguide/views/general/widgets/users_bottom_sheet.dart';
import 'package:autoguide/ui/bottom_sheet_ui.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ShareIcon extends StatelessWidget {
  final PostModel postData;
  const ShareIcon({super.key, required this.postData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppStyle.borderRadius,
      onTap: () async {
        BottomSheetUI.showDragBottomSheet(
          (controller) => UsersBottomSheet(
            postData: postData,
            list: MainController().userData?.followingUp ?? [],
            scrollController: controller,
          ),
          context,
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(MingCute.share_forward_line),
          const SizedBox(width: 5),
          Text('like'.tr),
        ],
      ),
    );
  }
}
