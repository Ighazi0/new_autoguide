import 'dart:developer';
import 'package:autoguide/app/app_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit? boxFit;
  final bool shimmer;
  final bool noLoading;
  final bool profile;
  final double? placeSize;
  final double? height;
  final double? width;

  const CustomNetworkImage({
    super.key,
    required this.url,
    this.boxFit,
    this.shimmer = false,
    this.noLoading = false,
    this.profile = false,
    this.placeSize,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return url.isEmpty
        ? noLoading
              ? SizedBox()
              : profile
              ? Container(
                  decoration: BoxDecoration(
                    color: AppStyle.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    size: placeSize ?? 35,
                    color: Colors.white,
                  ),
                )
              : shimmer
              ? Container(color: AppStyle.lightGrey)
              : CircularProgressIndicator()
        : CachedNetworkImage(
            imageUrl: url,
            fit: boxFit,
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            errorListener: (value) {
              log('📷 $url ⛔');
            },
            memCacheWidth: width == null ? null : (width! * 3).toInt(),
            memCacheHeight: height == null ? null : (height! * 3).toInt(),
            placeholder: (context, url) => noLoading
                ? SizedBox()
                : shimmer
                ? Container(color: AppStyle.lightGrey)
                : CircularProgressIndicator(),
            errorWidget: (context, url, error) => noLoading
                ? SizedBox()
                : profile
                ? Container(
                    decoration: BoxDecoration(
                      color: AppStyle.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      size: placeSize ?? 35,
                      color: Colors.white,
                    ),
                  )
                : shimmer
                ? Container(color: AppStyle.lightGrey)
                : CircularProgressIndicator(),
          );
  }
}
