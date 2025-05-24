import 'package:autoguide/models/post_model.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:autoguide/views/general/widgets/numbers_converter.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class PostContainer extends StatefulWidget {
  const PostContainer({
    super.key,
    required this.postData,
    this.fromChat = false,
  });
  final PostModel postData;
  final bool fromChat;

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
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
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              // leading:
              //     widget.postData.groupData == null
              //         ? GestureDetector(
              //           onTap: () {
              //             // if (widget.postData.uid != 'admin') {
              //             //   Get.to(
              //             //     () => ProfileScreen(
              //             //       userData: widget.postData.userData!,
              //             //     ),
              //             //   );
              //             // }
              //           },
              //           child: Avatar(
              //             image: widget.postData.userData!.profile,
              //             admin: widget.postData.uid == 'admin',
              //             size: 40,
              //           ),
              //         )
              //         : SizedBox(
              //           width: 40,
              //           height: 40,
              //           child: Stack(
              //             children: [
              //               Avatar(
              //                 // image: widget.postData.groupData!.cover,
              //                 admin: widget.postData.uid == 'admin',
              //                 size: 40,
              //               ),
              //               Positioned(
              //                 bottom: 0,
              //                 right: 0,
              //                 child: Avatar(
              //                   image: widget.postData.userData!.profile,
              //                   admin: widget.postData.uid == 'admin',
              //                   size: 25,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              title: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      widget.postData.uid == 'admin'
                          ? 'AUTOGUIDE'
                          : ('${widget.postData.userData!.firstName} ${widget.postData.userData!.lastName}'),
                    ),
                    const SizedBox(width: 10),
                    // if (widget.postData.uid == 'admin')
                    //   Image.asset(assets.blackStar, height: 15),
                  ],
                ),
              ),
              // subtitle: Row(
              //   children: [
              //     Text(
              //       customFormats.formatElapsedTime(widget.postData.timestamp),
              //       style: const TextStyle(fontSize: 12),
              //     ),
              //     if (widget.postData.groupData != null)
              //       GestureDetector(
              //         onTap: () {},
              //         child: Text(
              //           ', ${widget.postData.groupData!.name}',
              //           style: const TextStyle(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ),
              //   ],
              // ),
              trailing:
                  widget.fromChat
                      ? null
                      : IconButton(
                        onPressed: () {
                          // customBottomSheet.simpleBottomSheet(
                          //   OptionsBottomSheet(post: widget.postData),
                          // );
                        },
                        icon: const Icon(Icons.more_horiz),
                      ),
            ),
            // if (widget.postData.caption.isNotEmpty)
            //   Padding(
            //     padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
            //     child: ReadMoreText(caption: widget.postData.caption, size: 18),
            //   ),
            // if (widget.postData.media != null)
            //   if (widget.postData.media!.isNotEmpty)
            //     PhotoGrid(mediaUrls: widget.postData.media!),
            // if (!widget.fromChat)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Get.to(
                          //   () => FriendsListScreen(
                          //     users: widget.postData.likes!,
                          //   ),
                          // );
                        },
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 8,
                              child: Icon(AntDesign.like_fill, size: 10),
                            ),
                            const SizedBox(width: 5),
                            NumbersConverter(
                              number: widget.postData.like,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // customBottomSheet.dragAbleBottomSheet(
                          //   BottomSheetComment(postData: widget.postData),
                          // );
                        },
                        child: Row(
                          children: [
                            NumbersConverter(
                              number: widget.postData.comments,
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'comments'.tr,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 0, color: Colors.grey),
                ],
              ),
            ),
            if (!widget.fromChat)
              Row(
                children: [
                  // // Expanded(
                  // //   child: SizedBox(
                  // //     height: 40,
                  // //     child: StreamBuilder(
                  // //       stream:
                  // //           firestore
                  // //               .collection('posts')
                  // //               .doc(widget.postData.id)
                  // //               .snapshots(),
                  // //       builder: (context, snapshot) {
                  // //         if (snapshot.hasData) {
                  // //           if (!snapshot.data!.exists) {
                  // //             return const SizedBox();
                  // //           }
                  // //           List likes = snapshot.data!.get('likes') ?? [];
                  // //           return InkWell(
                  // //             onTap: () async {
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
                  // //             },
                  // //             child: Row(
                  // //               crossAxisAlignment: CrossAxisAlignment.center,
                  // //               mainAxisAlignment: MainAxisAlignment.center,
                  // //               children: [
                  // //                 Icon(
                  // //                   likes.contains(auth.userData.uid)
                  // //                       ? AntDesign.like_fill
                  // //                       : AntDesign.like_outline,
                  // //                   color:
                  // //                       likes.contains(auth.userData.uid)
                  // //                           ? AppStyle.primaryColor
                  // //                           : null,
                  // //                 ),
                  // //                 const SizedBox(width: 5),
                  // //                 Text(
                  // //                   'like'.tr,
                  // //                   style: TextStyle(
                  // //                     color:
                  // //                         likes.contains(auth.userData.uid)
                  // //                             ? AppStyle.primaryColor
                  // //                             : null,
                  // //                   ),
                  // //                 ),
                  // //               ],
                  // //             ),
                  // //           );
                  // //         }
                  // //         return InkWell(
                  // //           onTap: () async {},
                  // //           child: Row(
                  // //             crossAxisAlignment: CrossAxisAlignment.center,
                  // //             mainAxisAlignment: MainAxisAlignment.center,
                  // //             children: [
                  // //               Icon(
                  // //                 widget.postData.likes!.contains(
                  // //                       auth.userData.uid,
                  // //                     )
                  // //                     ? AntDesign.like_fill
                  // //                     : AntDesign.like_outline,
                  // //                 color:
                  // //                     widget.postData.likes!.contains(
                  // //                           auth.userData.uid,
                  // //                         )
                  // //                         ? AppStyle.primaryColor
                  // //                         : null,
                  // //               ),
                  // //               const SizedBox(width: 5),
                  // //               Text(
                  // //                 'like'.tr,
                  // //                 style: TextStyle(
                  // //                   color:
                  // //                       widget.postData.likes!.contains(
                  // //                             auth.userData.uid,
                  // //                           )
                  // //                           ? AppStyle.primaryColor
                  // //                           : null,
                  // //                 ),
                  // //               ),
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // Expanded(
                  //   child: SizedBox(
                  //     height: 40,
                  //     child: InkWell(
                  //       onTap: () {
                  //         // customBottomSheet.dragAbleBottomSheet(
                  //         //   BottomSheetComment(postData: widget.postData),
                  //         // );
                  //       },
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           const Icon(FontAwesome.comment),
                  //           const SizedBox(width: 5),
                  //           Text('comment'.tr),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Expanded(
                  //   child: SizedBox(
                  //     height: 40,
                  //     child: InkWell(
                  //       onTap: () {
                  //         // customBottomSheet.dragAbleBottomSheet(
                  //         //   ShareBottomSheet(
                  //         //     list: auth.userData.followingUp ?? [],
                  //         //     postData: widget.postData,
                  //         //   ),
                  //         // );
                  //       },
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           const Icon(MingCute.share_forward_line),
                  //           const SizedBox(width: 5),
                  //           Text('share'.tr),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
          ],
        ),
        if (widget.fromChat)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {},
              child: Container(color: Colors.black.withValues(alpha: 0)),
            ),
          ),
      ],
    );
  }
}
