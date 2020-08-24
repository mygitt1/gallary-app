import 'package:flutter/material.dart';
import './image_item.dart';
import '../models/image_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachedGalleryItems extends StatefulWidget {
  CachedGalleryItems({Key key}) : super(key: key);

  @override
  _CachedGalleryItemsState createState() => _CachedGalleryItemsState();
}

class _CachedGalleryItemsState extends State<CachedGalleryItems> {
  List<ImageData> allPhotos = [];
  // List<String> imagesUrls = [];
  getDataFromCache() async {
    print("getting data from cache");
    final prefs = await SharedPreferences.getInstance();
    List<String> allUrls = prefs.getStringList("imageUrls");

    print(allUrls);

    allPhotos = allUrls
        .map(
          (url) => ImageData(
            imageUrl: url,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Text('Loading....'),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return GridView(
                padding: const EdgeInsets.all(25),
                children: allPhotos
                    .map(
                      (data) => data.imageUrl == null
                          ? null
                          : ImageItem(
                              id: data.id,
                              title: data.title,
                              imageUrl: data.imageUrl,
                            ),
                    )
                    .toList(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              );
            }
        }
      },
      future: getDataFromCache(),
    );
  }
}
