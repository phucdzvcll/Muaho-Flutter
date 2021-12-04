import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageNetworkBuilder extends StatelessWidget {
  final String imgUrl;
  final bool isSquare;
  double? width;
  double? height;

  ImageNetworkBuilder(
      {Key? key,
      required this.imgUrl,
      this.width,
      this.height,
      required this.isSquare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      errorWidget: (context, e, s) {
        return isSquare
            ? Image.asset('assets/images/placeholder_square.png')
            : Image.asset('assets/images/placeholder.png');
      },
      fadeOutDuration: Duration(milliseconds: 200),
      fadeInDuration: Duration(milliseconds: 200),
      width: width,
      height: height,
      placeholder: (context, url) => isSquare
          ? Image.asset('assets/images/placeholder_square.png')
          : Image.asset('assets/images/placeholder.png'),
      imageUrl: imgUrl,
      fit: BoxFit.cover,
    );
  }
}
