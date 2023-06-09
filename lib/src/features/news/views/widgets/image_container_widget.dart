import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    this.height = 125,
    this.borderRadius = 20,
    required this.width,
    required this.imageUrl,
    this.padding,
    this.margin,
    this.child,
    this.overlay = false,
    this.isLoading = false,
    super.key,
  });

  final double width;
  final double height;
  final String imageUrl;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final Widget? child;
  final bool overlay;
  final bool isLoading;

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     height: height,
  //     width: width,
  //     padding: padding,
  //     margin: margin,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(borderRadius),
  //       image: overlay
  //           ? DecorationImage(
  //               image: NetworkImage(imageUrl),
  //               fit: BoxFit.cover,
  //               colorFilter: ColorFilter.mode(
  //                   Colors.black.withOpacity(0.5), BlendMode.srcOver))
  //           : DecorationImage(
  //               image: NetworkImage(imageUrl),
  //               fit: BoxFit.cover,
  //             ),
  //     ),
  //     child: child,
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            Skeleton(
              isLoading: isLoading,
              skeleton: const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    width: double.infinity, height: double.infinity),
              ),
              child: overlay
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.grey, BlendMode.modulate),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade400,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade400,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fadeInDuration: const Duration(milliseconds: 0),
                      fadeOutDuration: const Duration(milliseconds: 0),
                    ),
            ),
            Container(padding: padding, child: child),
          ],
        ),
      ),
    );
  }
}
