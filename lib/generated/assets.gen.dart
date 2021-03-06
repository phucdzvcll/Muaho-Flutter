/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/crown-svgrepo-com.svg
  SvgGenImage get crownSvgrepoCom =>
      const SvgGenImage('assets/images/crown-svgrepo-com.svg');

  /// File path: assets/images/delivery_dining_black_24dp.svg
  SvgGenImage get deliveryDiningBlack24dp =>
      const SvgGenImage('assets/images/delivery_dining_black_24dp.svg');

  /// File path: assets/images/flash_screen_high_quality.png
  AssetGenImage get flashScreenHighQuality =>
      const AssetGenImage('assets/images/flash_screen_high_quality.png');

  /// File path: assets/images/flash_screen_higt_quality.png
  AssetGenImage get flashScreenHigtQuality =>
      const AssetGenImage('assets/images/flash_screen_higt_quality.png');

  /// File path: assets/images/logo_square.png
  AssetGenImage get logoSquare =>
      const AssetGenImage('assets/images/logo_square.png');

  /// File path: assets/images/placeholder.png
  AssetGenImage get placeholder =>
      const AssetGenImage('assets/images/placeholder.png');

  /// File path: assets/images/placeholder_square.png
  AssetGenImage get placeholderSquare =>
      const AssetGenImage('assets/images/placeholder_square.png');

  /// File path: assets/images/shopping_cart_checkout_black_24dp.svg
  SvgGenImage get shoppingCartCheckoutBlack24dp =>
      const SvgGenImage('assets/images/shopping_cart_checkout_black_24dp.svg');
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/add_address.json
  String get addAddress => 'assets/json/add_address.json';

  /// File path: assets/json/error.json
  String get error => 'assets/json/error.json';

  /// File path: assets/json/lf30_editor_fthawjry.json
  String get lf30EditorFthawjry => 'assets/json/lf30_editor_fthawjry.json';

  /// File path: assets/json/maintenance_background.json
  String get maintenanceBackground => 'assets/json/maintenance_background.json';

  /// File path: assets/json/page_empty.json
  String get pageEmpty => 'assets/json/page_empty.json';

  /// File path: assets/json/page_error.json
  String get pageError => 'assets/json/page_error.json';

  /// File path: assets/json/waiting.json
  String get waiting => 'assets/json/waiting.json';
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
