import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ShareIcon extends StatefulWidget {
  const ShareIcon({super.key});

  @override
  State<ShareIcon> createState() => _ShareIconState();
}

class _ShareIconState extends State<ShareIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppStyle.borderRadius,

      onTap: () async {},
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
