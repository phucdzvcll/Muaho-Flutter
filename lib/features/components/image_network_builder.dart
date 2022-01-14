import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muaho/generated/assets.gen.dart';

class ImageNetworkBuilder extends StatelessWidget {
  final String imgUrl;
  final bool isSquare;
  final Size size;

  ImageNetworkBuilder({
    Key? key,
    required this.imgUrl,
    required this.size,
  })  : this.isSquare = size.width == size.height,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      errorWidget: (context, e, s) {
        return isSquare
            ? Assets.images.placeholderSquare.image()
            : Assets.images.placeholder.image();
      },
      fadeOutDuration: Duration(milliseconds: 400),
      fadeInDuration: Duration(milliseconds: 400),
      width: size.width,
      height: size.height,
      placeholder: (context, url) => isSquare
          ? Assets.images.placeholderSquare.image()
          : Assets.images.placeholder.image(),
      imageUrl: imgUrl,
      fit: BoxFit.fill,
    );
  }
}
