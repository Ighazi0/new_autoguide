import 'dart:developer';
import 'package:autoguide/app/app_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? url;
  final BoxFit? boxFit;
  final bool noLoading;
  final double? height;
  final double? width;

  const CustomNetworkImage({
    super.key,
    required this.url,
    this.boxFit,
    this.noLoading = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return (url?.isEmpty ?? true)
        ? noLoading
              ? SizedBox()
              : Container(color: AppStyle.lightGrey)
        : CachedNetworkImage(
            imageUrl: url ?? '',
            fit: boxFit,
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            errorListener: (value) {
              log('📷 $url ⛔');
            },
            memCacheWidth: width == null ? null : (width! * 3).toInt(),
            memCacheHeight: height == null ? null : (height! * 3).toInt(),
            placeholder: (context, url) =>
                noLoading ? SizedBox() : Container(color: AppStyle.lightGrey),
            errorWidget: (context, url, error) =>
                noLoading ? SizedBox() : Container(color: AppStyle.lightGrey),
          );
  }
}
