import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LikeIcon extends StatefulWidget {
  final bool? status;
  const LikeIcon({super.key, required this.status});

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
        setState(() {
          liked = !liked;
        });
        // //               await firestore
        // //                   .collection('posts')
        // //                   .doc(widget.postData.id)
        // //                   .update({
        // //                     'like': FieldValue.increment(
        // //                       likes.contains(auth.userData.uid)
        // //                           ? -1
        // //                           : 1,
        // //                     ),
        // //                     'likes':
        // //                         likes.contains(auth.userData.uid)
        // //                             ? FieldValue.arrayRemove([
        // //                               auth.userData.uid,
        // //                             ])
        // //                             : FieldValue.arrayUnion([
        // //                               auth.userData.uid,
        // //                             ]),
        // //                   });
        // //               if (!likes.contains(auth.userData.uid) &&
        // //                   widget.postData.uid != 'admin') {
        // //                 customFunctions.setNotification(
        // //                   NotificationModel(
        // //                     id:
        // //                         'like${auth.userData.uid}${widget.postData.id}',
        // //                     title:
        // //                         '${auth.userData.firstName} ${auth.userData.lastName}',
        // //                     body: 'Like your post',
        // //                     profile: auth.userData.profile,
        // //                     verified: auth.userData.verified,
        // //                     type: 'likeYourPost',
        // //                     timestamp:
        // //                         Timestamp.now()
        // //                             .toDate()
        // //                             .millisecondsSinceEpoch
        // //                             .toString(),
        // //                     id1: widget.postData.id,
        // //                     uid: auth.userData.uid,
        // //                   ),
        // //                   widget.postData.uid,
        // //                   widget.postData.uid,
        // //                 );
        // //               }
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
