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
      decoration: const BoxDecoration(
        color: Color(0xffC3CAD1),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      // child: ClipRRect(
      //     borderRadius: const BorderRadius.all(Radius.circular(1000)),
      //     child:
      // admin
      //     ? Image.asset(assets.icon)
      //     : image.isEmpty
      //         ? Image.asset(type == 'car'
      //             ? assets.carImage
      //             : type == 'store'
      //                 ? assets.store
      //                 : type == 'nashmi'
      //                     ? assets.nashmi
      //                     : assets.person)
      //         : image.isURL
      //             ? NImage(
      //                 image: image,
      //                 w: size,
      //                 h: size,
      //                 fit: BoxFit.cover,
      //               )
      //             : Image.file(
      //                 File(
      //                   image,
      //                 ),
      //                 fit: BoxFit.cover,
      //               )),
    );
  }
}
