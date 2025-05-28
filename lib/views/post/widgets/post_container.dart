import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/controllers/main_controller.dart';
import 'package:autoguide/models/post_model.dart';
import 'package:autoguide/models/user_model.dart';
import 'package:autoguide/services/format_services.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:autoguide/services/navigator_services.dart';
import 'package:autoguide/ui/bottom_sheet_ui.dart';
import 'package:autoguide/views/general/widgets/custom_avatar.dart';
import 'package:autoguide/views/general/widgets/custom_read_more.dart';
import 'package:autoguide/views/general/widgets/numbers_converter.dart';
import 'package:autoguide/views/general/widgets/users_bottom_sheet.dart';
import 'package:autoguide/views/general/widgets/verify_icon.dart';
import 'package:autoguide/views/post/icons/comment_icon.dart';
import 'package:autoguide/views/post/icons/like_icon.dart';
import 'package:autoguide/views/post/icons/share_icon.dart';
import 'package:autoguide/views/post/widgets/photo_grid.dart';
import 'package:autoguide/views/user/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class PostContainer extends StatefulWidget {
  const PostContainer({super.key, required this.postData});
  final PostModel postData;

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  final userUid = MainController().userData?.uid;
  // updatePostData() {
  //   firestore.collection('users').doc(widget.postData.uid).get().then((users) {
  //     UsersModel user = UsersModel.fromJson(
  //       users.data() as Map<String, dynamic>,
  //     );

  //     if (user.uid.isNotEmpty && widget.postData.id.isNotEmpty) {
  //       firestore.collection('posts').doc(widget.postData.id).update({
  //         'userData': user.toJson(),
  //       });
  //     }
  //   });
  //   if (widget.postData.groupData != null) {
  //     firestore
  //         .collection('groups')
  //         .doc(widget.postData.groupData!.id)
  //         .get()
  //         .then((groups) {
  //           GroupModel group = GroupModel.fromJson(
  //             groups.data() as Map<String, dynamic>,
  //           );

  //           if (group.uid.isNotEmpty && widget.postData.id.isNotEmpty) {
  //             firestore.collection('posts').doc(widget.postData.id).update({
  //               'groupData': group.toJson(),
  //             });
  //           }
  //         });
  //   }
  // }

  // @override
  // void initState() {
  //   if (widget.postData.uid != 'admin' && !widget.fromChat) {
  //     updatePostData();
  //   }

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  NavigatorServices.push(
                    ProfileScreen(
                      userData: widget.postData.userData ?? UserModel(),
                    ),
                  );
                },
                child: CustomAvatar(
                  image: widget.postData.userData?.profile,
                  admin: widget.postData.uid == 'admin',
                  size: 35,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigatorServices.push(
                          ProfileScreen(
                            userData: widget.postData.userData ?? UserModel(),
                          ),
                        );
                      },
                      child: Wrap(
                        children: [
                          Text(
                            widget.postData.uid == 'admin'
                                ? 'AUTOGUIDE'
                                : '${widget.postData.userData!.name}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (widget.postData.uid == 'admin')
                            VerifiedStarIcon(size: 16),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          FormatServices.formatElapsedTime(
                            widget.postData.timestamp ?? '',
                          ),
                          style: const TextStyle(fontSize: 10),
                        ),
                        if (widget.postData.groupData != null)
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              ', ${widget.postData.groupData!.name}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                borderRadius: AppStyle.borderRadius,
                onTap: () {},
                child: const Icon(Icons.more_horiz),
              ),
            ],
          ),
        ),
        if (widget.postData.caption?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
            child: CustomReadMore(
              text: widget.postData.caption ?? '',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                height: 1.5,
                fontFamily: 'Almarai',
              ),
            ),
          ),
        if (widget.postData.media?.isNotEmpty ?? false)
          PhotoGrid(imageUrls: widget.postData.media?.toList() ?? []),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      BottomSheetUI.showDragBottomSheet(
                        (controller) => UsersBottomSheet(
                          list: widget.postData.likes ?? [],
                          scrollController: controller,
                        ),
                        context,
                      );
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 8,
                          backgroundColor: AppStyle.primaryColor,
                          child: Icon(
                            AntDesign.like_fill,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        NumbersConverter(
                          number: widget.postData.like ?? 0,
                          size: 13,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        NumbersConverter(
                          number: widget.postData.comments ?? 0,
                          size: 13,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'comments'.tr,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LikeIcon(
                status: widget.postData.likes?.contains(userUid),
                id: widget.postData.id ?? '',
              ),
              CommentIcon(),
              ShareIcon(postData: widget.postData),
            ],
          ),
        ),
        SizedBox(height: 5),
        Divider(thickness: 3),
      ],
    );
  }
}
