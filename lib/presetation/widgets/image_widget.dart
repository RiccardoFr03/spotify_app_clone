import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_clone/domain/helpers/assets/app_urls.dart';

class ImageWidget extends StatelessWidget {
  final String artistName;
  final String? songTitle;
  final double height;
  final double width;
  final double borderRadius;
  final bool? borderOnlyLeft;
  final BoxFit fit;
  final String? placeholder;
  final String? link;

  const ImageWidget({
    super.key,
    required this.artistName,
    required this.songTitle,
    this.height = 60,
    this.width = 60,
    this.borderRadius = 8,
    this.borderOnlyLeft,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.link,
  });

  String get _imageUrl => songTitle != null
      ? '${AppURLs.coverFirestorage}$artistName - $songTitle.jpg?${AppURLs.mediaAlt}'
      : '${AppURLs.artistFirestorage}$artistName.jpg?${AppURLs.mediaAlt}';

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderOnlyLeft != null
          ? BorderRadius.horizontal(
              left: Radius.circular(8),
            )
          : BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: link == null ? _imageUrl : link!,
        height: height,
        width: width,
        fit: fit,
        cacheManager: CacheManager(
          Config(
            'firebase_images_cache',
            stalePeriod: const Duration(days: 7),
            maxNrOfCacheObjects: 100,
          ),
        ),
        placeholder: (context, url) => _buildShimmer(),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          child: const Icon(Icons.error),
        ),
        fadeInDuration: const Duration(milliseconds: 300),
        memCacheHeight: (height * MediaQuery.of(context).devicePixelRatio).toInt(),
        memCacheWidth: (width * MediaQuery.of(context).devicePixelRatio).toInt(),
      ),
    );
  }
}
