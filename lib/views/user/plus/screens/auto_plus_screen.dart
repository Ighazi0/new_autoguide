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
        // condition: {'uid': 'admin'},
        itemBuilder: (doc) {
          PostModel post = PostModel.fromJson(
            doc.data() as Map<String, dynamic>,
          );

          return PostContainer(postData: post);
        },
      ),
    );
  }
}
