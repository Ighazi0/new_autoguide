import 'package:autoguide/models/post_model.dart';
import 'package:autoguide/views/general/widgets/firestore_pagination_list.dart';
import 'package:autoguide/views/post/widgets/post_container.dart';
import 'package:autoguide/views/user/plus/widgets/plus_widget.dart';
import 'package:flutter/material.dart';

class AutoPlusScreen extends StatefulWidget {
  const AutoPlusScreen({super.key});

  @override
  State<AutoPlusScreen> createState() => _AutoPlusScreenState();
}

class _AutoPlusScreenState extends State<AutoPlusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: PlusWidget(inPlus: true)),
      body: FirestorePaginationList(
        collection: 'posts',
        orderByField: 'timestamp',
        itemBuilder: (doc) {
          PostModel post = PostModel.fromJson(
            doc.data() as Map<String, dynamic>,
          );

          return PostContainer(postData: post);
        },
      ),
      // body: SafeArea(
      //   child: RefreshWidget(
      //     function: () async {
      //       await Future.delayed(Durations.long1);
      //       setState(() {});
      //     },
      //     child: PaginateFirestore(
      //       onEmpty: Center(child: Text('no_data_found'.tr)),
      //       itemBuilder: (context, documentSnapshot, index) {
      //         PostModel post = PostModel.fromJson(
      //           documentSnapshot[index].data() as Map<String, dynamic>,
      //         );

      //         return PostContainer(postData: post);
      //       },
      //       separator: const Divider(thickness: 3),
      //       bottomLoader: const CustomLoading(size: 50),
      //       initialLoader: const CustomLoading(),
      //       physics: const AlwaysScrollableScrollPhysics(),
      //       itemsPerPage: 20,
      //       isLive: true,
      //       query: firestore
      //           .collection('posts')
      //           .where('uid', isEqualTo: 'admin')
      //           .orderBy('timestamp', descending: true),
      //       itemBuilderType: PaginateBuilderType.listView,
      //     ),
      //   ),
      // ),
    );
  }
}
