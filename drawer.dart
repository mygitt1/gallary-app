import 'package:flutter/material.dart';
import 'package:gallary_app/gallery_view.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
    String title,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        GalleryPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(25),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Gallary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Home',
            Icons.home,
          ),
        ],
      ),
    );
  }
}
