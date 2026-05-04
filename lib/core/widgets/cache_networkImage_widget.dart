import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'loading_shimmer.widget.dart';

class CacheNetworkImage extends StatelessWidget {
  const CacheNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isCircular = false,
    this.borderRadius,
    this.placeholderImage,
    this.memCacheWidth,
    this.memCacheHeight,
    this.fadeInDuration = const Duration(milliseconds: 300),
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isCircular;
  final BorderRadius? borderRadius;
  final String? placeholderImage;

  /// Resize in memory to avoid wasting RAM (pass logical pixels × devicePixelRatio)
  final int? memCacheWidth;
  final int? memCacheHeight;
  final Duration fadeInDuration;

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);

    final Widget image = CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      fit: fit,
      width: width,
      height: height,
      memCacheWidth: memCacheWidth ?? _safeMemCache(width, dpr),
      memCacheHeight: memCacheHeight ?? _safeMemCache(height, dpr),
      fadeInDuration: fadeInDuration,
      fadeOutDuration: const Duration(milliseconds: 200),
      useOldImageOnUrlChange: true,
      placeholder: (_, __) => _buildPlaceholder(),
      errorWidget: (_, __, ___) => _buildError(),
    );

    if (isCircular) {
      return ClipOval(child: image);
    } else if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }

  /// Returns null if [size] is null, infinite, or NaN — safe for memCacheWidth/Height.
  static int? _safeMemCache(double? size, double dpr) {
    if (size == null || size.isInfinite || size.isNaN || size <= 0) {
      return null;
    }
    return (size * dpr).round();
  }

  Widget _buildPlaceholder() {
    if (placeholderImage != null) {
      return Image.asset(
        placeholderImage!,
        fit: fit,
        width: width,
        height: height,
      );
    }
    return LoadingShimmer(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      isCircular: isCircular,
      borderRadius: borderRadius,
    );
  }

  Widget _buildError() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: borderRadius,
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Icon(Icons.error, color: Colors.grey.shade400, size: 40),
    );
  }
}
