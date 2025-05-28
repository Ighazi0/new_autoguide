import 'package:autoguide/models/post_model.dart';
import 'package:flutter/material.dart';

class BottomSheetComment extends StatefulWidget {
  const BottomSheetComment({super.key, required this.postData});
  final PostModel postData;

  @override
  State<BottomSheetComment> createState() => _BottomSheetCommentState();
}

class _BottomSheetCommentState extends State<BottomSheetComment> {
  final controller = TextEditingController();
  String comment = '', reply = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.expand_more),
            ),
            const SizedBox(height: 5),
            // Expanded(
            //   child: GestureDetector(
            //     onTap: () {
            //       FocusScope.of(context).unfocus();
            //     },
            //     child: StreamBuilder(
            //       stream: firestore
            //           .collection('posts')
            //           .doc(widget.postData.id)
            //           .collection('comments')
            //           .orderBy('timestamp', descending: true)
            //           .snapshots(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           List<CommentModel> commentData = snapshot.data!.docs
            //               .map((doc) => CommentModel.fromJson(doc.data()))
            //               .toList();
            //           if (commentData.isEmpty) {
            //             return Center(child: Text('no_comments'.tr));
            //           }

            //           treeController = TreeController<CommentModel>(
            //             roots: commentData,
            //             childrenProvider: (CommentModel node) =>
            //                 node.replies ?? [],
            //           );
            //           return TreeView<CommentModel>(
            //             controller: customScrollController,
            //             keyboardDismissBehavior:
            //                 ScrollViewKeyboardDismissBehavior.onDrag,
            //             treeController: treeController!,
            //             nodeBuilder:
            //                 (
            //                   BuildContext context,
            //                   TreeEntry<CommentModel> entry,
            //                 ) {
            //                   return CommentTile(
            //                     controller: treeController!,
            //                     key: ValueKey(entry.node),
            //                     entry: entry,
            //                     onTap: (x) {
            //                       focusNode.requestFocus();
            //                       setState(() {
            //                         reply = x;
            //                       });
            //                     },
            //                     postData: widget.postData,
            //                   );
            //                 },
            //           );
            //         }
            //         return const CustomLoading();
            //       },
            //     ),
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 5),
            //   height: 40,
            //   child: TextField(
            //     minLines: 1,
            //     focusNode: focusNode,
            //     maxLines: 5,
            //     controller: controller,
            //     onChanged: (value) {
            //       setState(() {
            //         comment = value;
            //       });
            //     },
            //     autocorrect: false,
            //     decoration: InputDecoration(
            //       contentPadding: const EdgeInsets.symmetric(
            //         vertical: 5,
            //         horizontal: 10,
            //       ),
            //       suffixIcon: IconButton(
            //         icon: Icon(Icons.send, color: AppStyle.primaryColor),
            //         onPressed: () async {
            //           if (comment.isNotEmpty) {
            //             FocusScope.of(context).unfocus();
            //             controller.clear();
            //             var id = DateTime.now().millisecondsSinceEpoch
            //                 .toString();
            //             if (reply.isEmpty) {
            //               await firestore
            //                   .collection(widget.video ? 'videos' : 'posts')
            //                   .doc(widget.postData.id)
            //                   .collection('comments')
            //                   .doc(id)
            //                   .set({
            //                     'comment': comment,
            //                     'timestamp': id,
            //                     'uid': auth.userData.uid,
            //                     'name':
            //                         '${auth.userData.firstName} ${auth.userData.lastName}',
            //                     'verified': auth.userData.verified,
            //                     'profile': auth.userData.profile,
            //                     'likes': 0,
            //                     'like': [],
            //                   });
            //               firestore
            //                   .collection(widget.video ? 'videos' : 'posts')
            //                   .doc(widget.postData.id)
            //                   .update({'comments': FieldValue.increment(1)});
            //               // if (widget.postData.uid != 'admin') {
            //               //   customFunctions.setNotification(
            //               //       NotificationModel(
            //               //           id:
            //               //               'comment${auth.userData.uid}${widget.postData.id}',
            //               //           title:
            //               //               '${auth.userData.firstName} ${auth.userData.lastName}',
            //               //           body:
            //               //               'Comment on your ${widget.video ? 'video' : 'post'}',
            //               //           profile: auth.userData.profile,
            //               //           verified: auth.userData.verified,
            //               //           type: widget.video
            //               //               ? 'commentInYourVideo'
            //               //               : 'commentInYourPost',
            //               //           timestamp: Timestamp.now()
            //               //               .toDate()
            //               //               .millisecondsSinceEpoch
            //               //               .toString(),
            //               //           id1: widget.postData.id,
            //               //           uid: auth.userData.uid),
            //               //       widget.postData.uid);
            //               // }
            //             } else {
            //               await firestore
            //                   .collection(widget.video ? 'videos' : 'posts')
            //                   .doc(widget.postData.id)
            //                   .collection('comments')
            //                   .doc(reply)
            //                   .update({
            //                     'replies': FieldValue.arrayUnion([
            //                       {
            //                         'comment': comment,
            //                         'timestamp': id,
            //                         'uid': auth.userData.uid,
            //                         'name':
            //                             '${auth.userData.firstName} ${auth.userData.lastName}',
            //                         'verified': auth.userData.verified,
            //                         'profile': auth.userData.profile,
            //                         'likes': 0,
            //                         'like': [],
            //                       },
            //                     ]),
            //                   });

            //               // if (widget.postData.uid != 'admin') {
            //               //   customFunctions.setNotification(
            //               //       NotificationModel(
            //               //           id:
            //               //               'reply${auth.userData.uid}${widget.postData.id}',
            //               //           title:
            //               //               '${auth.userData.firstName} ${auth.userData.lastName}',
            //               //           body: 'Reply in your comment',
            //               //           profile: auth.userData.profile,
            //               //           verified: auth.userData.verified,
            //               //           type: 'replyInYourComment',
            //               //           timestamp: Timestamp.now()
            //               //               .toDate()
            //               //               .millisecondsSinceEpoch
            //               //               .toString(),
            //               //           id1: widget.postData.id,
            //               //           uid: auth.userData.uid),
            //               //       widget.postData.uid);
            //               // }
            //             }

            //             setState(() {
            //               comment = '';
            //               reply = '';
            //             });
            //           }
            //         },
            //       ),
            //       hintText: 'write_comment'.tr,
            //       border: const OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(10)),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
