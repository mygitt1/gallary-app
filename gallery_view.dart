// import 'dart:html';

import 'package:flutter/material.dart';
import './widget/gallery_when_internet_connected.dart';
import './widget/gallery_when_internet_not_connected.dart';
import "package:flutter_cache_manager/flutter_cache_manager.dart";

import 'package:connectivity/connectivity.dart';

final BaseCacheManager baseCacheManager = DefaultCacheManager();

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool isConnectedToInternet = false;

  @override
  void didChangeDependencies() async {
    print("in change dependency");
    var connectivityResult = await Connectivity().checkConnectivity();
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      setState(() {
        isConnectedToInternet = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      setState(() {
        isConnectedToInternet = true;
      });
    } else {
      print("No Interent Connection");
      setState(() {
        isConnectedToInternet = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var cache = await DefaultCacheManager();
    // final orientation = MediaQuery.of(context).orientation;
    return isConnectedToInternet ? GalleyItems() : CachedGalleryItems();
  }
}
