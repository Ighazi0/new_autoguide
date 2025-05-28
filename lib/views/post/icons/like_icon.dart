import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/controllers/main_controller.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LikeIcon extends StatefulWidget {
  final bool? status;
  final String id;
  const LikeIcon({super.key, required this.status, required this.id});

  @override
  State<LikeIcon> createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  bool liked = false;

  @override
  void initState() {
    liked = widget.status ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppStyle.borderRadius,
      onTap: () async {
        final userUId = MainController().userData?.uid;
        setState(() {
          liked = !liked;
        });
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.id)
            .update({
              'like': FieldValue.increment(!liked ? -1 : 1),
              'likes': !liked
                  ? FieldValue.arrayRemove([userUId])
                  : FieldValue.arrayUnion([userUId]),
            });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            liked ? AntDesign.like_fill : AntDesign.like_outline,
            color: liked ? AppStyle.primaryColor : null,
          ),
          const SizedBox(width: 5),
          Text(
            'like'.tr,
            style: TextStyle(color: liked ? AppStyle.primaryColor : null),
          ),
        ],
      ),
    );
  }
}
