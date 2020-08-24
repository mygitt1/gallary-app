import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../gallery_view.dart';

class ImageItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;
  const ImageItem({
    Key key,
    this.imageUrl,
    this.title,
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        cacheManager: baseCacheManager,
      ),
    );
  }
}
