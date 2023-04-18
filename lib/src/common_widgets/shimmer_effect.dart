import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImage extends StatelessWidget {
  final double? width;
  final double? height;
  final bool? isCircle;
  const ShimmerImage({super.key, this.width, this.height, this.isCircle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: SizedBox(
          height: height ?? 30,
          width: width ?? 50,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                shape: isCircle != null ? BoxShape.circle : BoxShape.rectangle,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
