import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/models/post_model.dart';
import 'package:autoguide/models/user_model.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:autoguide/services/navigator_services.dart';
import 'package:autoguide/views/general/widgets/custom_avatar.dart';
import 'package:autoguide/views/general/widgets/custom_button.dart';
import 'package:autoguide/views/general/widgets/custom_loading.dart';
import 'package:autoguide/views/general/widgets/empty_widget.dart';
import 'package:autoguide/views/user/profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersBottomSheet extends StatefulWidget {
  final List list;
  final ScrollController scrollController;
  final PostModel? postData;

  const UsersBottomSheet({
    super.key,
    required this.list,
    required this.scrollController,
    this.postData,
  });

  @override
  State<UsersBottomSheet> createState() => _UsersBottomSheetState();
}

class _UsersBottomSheetState extends State<UsersBottomSheet> {
  final controller = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  List<UserModel>? allResults;
  List<UserModel> filteredResults = [];
  bool isLoading = false;
  bool hasMore = true;
  final batchSize = 30;
  List uid = [];

  @override
  void initState() {
    super.initState();
    fetchData();

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels >=
              widget.scrollController.position.maxScrollExtent - 300 &&
          !isLoading) {
        fetchData();
      }
    });

    controller.addListener(() {
      setState(() {
        applySearchFilter();
      });
    });
  }

  Future<void> fetchData() async {
    if (isLoading || !hasMore || widget.list.isEmpty) return;

    setState(() => isLoading = true);

    final List batchIds = widget.list
        .skip(allResults?.length ?? 0)
        .take(batchSize)
        .toList();

    if (batchIds.isEmpty) {
      setState(() => isLoading = false);
      return;
    }

    final QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('uid', whereIn: batchIds)
        .get();

    final newUsers = querySnapshot.docs
        .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    allResults ??= [];
    if (newUsers.isNotEmpty) {
      allResults?.addAll(newUsers);
      applySearchFilter();
    }

    if (batchIds.length < batchSize) {
      hasMore = false;
    }

    setState(() => isLoading = false);
  }

  void applySearchFilter() {
    final query = controller.text.toLowerCase();
    filteredResults =
        allResults?.where((user) {
          return user.name?.toLowerCase().contains(query) ?? false;
        }).toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    if (allResults == null) {
      return CustomLoading();
    }
    return SafeArea(
      child: Column(
        children: [
          if (widget.list.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10),
              child: CupertinoSearchTextField(
                placeholder: 'search'.tr,
                itemColor: AppStyle.primaryColor,
                controller: controller,
              ),
            ),
          if (filteredResults.isEmpty && !isLoading)
            const Expanded(child: EmptyWidget(title: 'no_users')),
          if (filteredResults.isNotEmpty || isLoading)
            Expanded(
              child: ListView.builder(
                controller: widget.scrollController,
                itemCount: filteredResults.length + (hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < filteredResults.length) {
                    final user = filteredResults[index];
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            NavigatorServices.push(
                              ProfileScreen(userData: user),
                            );
                          },
                          leading: CustomAvatar(image: user.profile),
                          title: Text(user.name ?? ''),
                          trailing: widget.postData == null
                              ? null
                              : CustomButton(
                                  minWidth: 80,
                                  height: 33,
                                  title: uid.contains(user.uid)
                                      ? 'sent'.tr
                                      : 'send'.tr,
                                ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  } else {
                    return CustomLoading(size: 60);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }
}
