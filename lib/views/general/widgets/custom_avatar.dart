import 'package:autoguide/app/app_assets.dart';
import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/views/general/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    this.image,
    this.size = 50,
    this.admin = false,
    this.type = 'user',
  });
  final String? image, type;
  final double size;
  final bool admin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: AppStyle.primaryColor,
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(500)),
        child: admin
            ? Image.asset(ImagesAssets.icon)
            : image?.isEmpty ?? true
            ? Icon(Icons.person, color: Colors.white, size: 30)
            : CustomNetworkImage(
                url: image ?? '',
                width: size,
                height: size,
                boxFit: BoxFit.cover,
              ),
      ),
    );
  }
}
