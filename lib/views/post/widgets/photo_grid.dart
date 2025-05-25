import 'package:autoguide/models/media_model.dart';
import 'package:autoguide/views/general/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

class PhotoGrid extends StatelessWidget {
  final List<MediaModel> imageUrls;

  const PhotoGrid({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final count = imageUrls.length;

    if (count == 1) {
      return _buildSingleImage(imageUrls.first);
    } else if (count == 2) {
      return _buildGrid(imageUrls, crossAxisCount: 2);
    } else if (count == 3) {
      return _buildGrid(imageUrls, crossAxisCount: 2);
    } else if (count == 4) {
      return _buildGrid(imageUrls, crossAxisCount: 2);
    } else {
      return _buildGridWithOverlay(imageUrls);
    }
  }

  Widget _buildSingleImage(MediaModel media) {
    return CustomNetworkImage(url: media.path, boxFit: BoxFit.cover);
  }

  Widget _buildGrid(List<MediaModel> images, {int crossAxisCount = 2}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        return CustomNetworkImage(
          url: images[index].path,
          boxFit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildGridWithOverlay(List<MediaModel> images) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        if (index == 3) {
          int remaining = images.length - 4;
          return Stack(
            fit: StackFit.expand,
            children: [
              CustomNetworkImage(url: images[index].path, boxFit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(color: Colors.black45),
                child: Center(
                  child: Text(
                    '+$remaining',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return CustomNetworkImage(
            url: images[index].path,
            boxFit: BoxFit.cover,
          );
        }
      },
    );
  }
}
