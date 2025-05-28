import 'package:autoguide/app/app_assets.dart';
import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/get_data_services.dart';
import 'package:autoguide/services/navigator_services.dart';
import 'package:autoguide/views/ai/screens/chat_ai_screen.dart';
import 'package:autoguide/views/general/widgets/icon_badge.dart';
import 'package:autoguide/views/user/chats/screens/chats_screen.dart';
import 'package:autoguide/views/user/plus/widgets/plus_widget.dart';
import 'package:autoguide/views/user/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      title: const PlusWidget(),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 0.5,
      actions: [
        IconButton(
          onPressed: () async {
            NavigatorServices.push(ChatAiScreen());
          },
          icon: Image.asset(ImagesAssets.ai),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Align(
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              onTap: () {
                NavigatorServices.push(SearchScreen());
              },
              child: const Icon(Icons.search, color: Colors.black),
            ),
          ),
        ),
        StreamBuilder(
          stream: GetDataServices().getChatCount(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      NavigatorServices.push(ChatsScreen());
                    },
                    icon: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(
                        FontAwesome.comment_dots,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                  if (snapshot.data!.docs.isNotEmpty)
                    Positioned(
                      top: -2,
                      right: 5,
                      child: BadgeIcon(
                        badgeText: snapshot.data!.docs.toString(),
                      ),
                    ),
                ],
              );
            }
            return IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: const Icon(
                  FontAwesome.comment_dots,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            );
          },
        ),
      ],
      bottom: TabBar(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: AppStyle.primaryColor),
          insets: const EdgeInsets.symmetric(horizontal: 12),
        ),
        tabs: [
          Tab(
            icon: Icon(
              Iconsax.shop_bold,
              size: 30,
              color: AppStyle.primaryColor,
            ),
          ),
          Tab(
            icon: Icon(
              Iconsax.home_2_bold,
              size: 30,
              color: AppStyle.primaryColor,
            ),
          ),
          StreamBuilder(
            stream: GetDataServices().getFriendsCount(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    Tab(
                      icon: Icon(
                        Icons.group,
                        size: 30,
                        color: AppStyle.primaryColor,
                      ),
                    ),
                    if (snapshot.data!.docs.isNotEmpty)
                      Positioned(
                        right: 0,
                        child: BadgeIcon(
                          badgeText: snapshot.data!.docs.length.toString(),
                        ),
                      ),
                  ],
                );
              }
              return Tab(
                icon: Icon(Icons.group, size: 30, color: AppStyle.primaryColor),
              );
            },
          ),
          StreamBuilder(
            stream: GetDataServices().getNotificationsCount(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    Tab(
                      icon: Icon(
                        Iconsax.notification_bold,
                        size: 30,
                        color: AppStyle.primaryColor,
                      ),
                    ),
                    if (snapshot.data!.docs.isNotEmpty)
                      Positioned(
                        right: 0,
                        child: BadgeIcon(
                          badgeText: snapshot.data!.docs.length.toString(),
                        ),
                      ),
                  ],
                );
              }
              return Tab(
                icon: Icon(
                  Iconsax.notification_bold,
                  size: 30,
                  color: AppStyle.primaryColor,
                ),
              );
            },
          ),
          Tab(icon: Icon(Icons.menu, size: 30, color: AppStyle.primaryColor)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
