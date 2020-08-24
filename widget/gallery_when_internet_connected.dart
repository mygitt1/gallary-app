import 'package:flutter/material.dart';
import './image_item.dart';
import '../models/image_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GalleyItems extends StatefulWidget {
  GalleyItems({Key key}) : super(key: key);

  @override
  _GalleyItemsState createState() => _GalleyItemsState();
}

class _GalleyItemsState extends State<GalleyItems> {
  List<ImageData> allPhotos = [];
  List<String> imagesUrls = [];

  getAndLoadData() async {
    var url =
        'https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&per_page=20&page=1&api_key=6f102c62f41998d151e5a1b48713cf13&format=json&nojsoncallback=1&extras=url_s';
    var response = await http.get(url);
    var body = json.decode(response.body);
    var photosDataGot = body["photos"]["photo"];

    return photosDataGot;
  }

  saveDataToMemory(List<String> imageUrls) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("imageUrls", imageUrls);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        print("the snapshot ${snapshot.data}");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Text('Loading....'),
            );
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              snapshot.data.forEach((item) {
                ImageData data = ImageData(
                  title: item["title"],
                  height: item["height_s"],
                  width: item["width_s"],
                  imageUrl: item["url_s"],
                  id: item["id"],
                );

                allPhotos.add(data);
                imagesUrls.add(item["url_s"]);
              });

              saveDataToMemory(imagesUrls);
              print(allPhotos.length);

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
      future: getAndLoadData(),
    );
  }
}
