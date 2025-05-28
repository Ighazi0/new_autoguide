import 'dart:async';
import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/device_services.dart';
import 'package:autoguide/services/get_data_services.dart';
import 'package:autoguide/views/general/widgets/custom_network_image.dart';
import 'package:autoguide/views/general/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

class BannersWidget extends StatefulWidget {
  const BannersWidget({super.key});

  @override
  State<BannersWidget> createState() => _BannersWidgetState();
}

class _BannersWidgetState extends State<BannersWidget> {
  final pageController = PageController();
  Timer? timer;

  void startAutoSlide({int count = 0}) {
    if (timer != null) {
      if (count > 1) {
        timer?.cancel();
        timer = Timer.periodic(Duration(seconds: 3), (timer) {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        });
      }
    }
  }

  void stopAutoSlide() {
    timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: DeviceServices.width,
      child: FutureBuilder(
        future: GetDataServices().getBanners(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final banners = snapshot.data!;
            if (banners.isEmpty) {
              return const SizedBox();
            }
            startAutoSlide(count: banners.length);
            return GestureDetector(
              onPanDown: (_) => stopAutoSlide(),
              onPanCancel: () => startAutoSlide(),
              onPanEnd: (_) => startAutoSlide(),
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.axis == Axis.horizontal) {
                    if (notification is ScrollStartNotification) {
                      stopAutoSlide();
                    } else if (notification is ScrollEndNotification) {
                      startAutoSlide();
                    }
                  }

                  return true;
                },
                child: PageView.builder(
                  controller: pageController,
                  allowImplicitScrolling: true,
                  physics: banners.length == 1
                      ? NeverScrollableScrollPhysics()
                      : null,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 10,
                      ),
                      child: ClipRRect(
                        borderRadius: AppStyle.borderRadius,
                        child: GestureDetector(
                          onTap: () {},
                          child: CustomNetworkImage(
                            url: banners[index % banners.length].image,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: CustomShimmer(
              isLoading: true,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: AppStyle.borderRadius,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
