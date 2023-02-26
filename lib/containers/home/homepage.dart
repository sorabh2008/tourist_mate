import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tourist_mate/services/location_service.dart';

import '../gallery/gallery_widget.dart';


const whitecolor = Colors.white;
const blackcolor = Colors.black;
class GalleryHomePage extends StatefulWidget {
  const GalleryHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<GalleryHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<GalleryHomePage> {
  String currentLocation = 'test';
  LocationService locationService = new LocationService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      locationService.getCurrentPosition().then((position) => {
        currentLocation = position.toString()
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whitecolor,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(color: blackcolor),
        ),
        iconTheme: const IconThemeData(color: blackcolor),
      ),
      // Body area
      body: Center(
        child: Column(
          children: [
            Text("Searching near " +currentLocation),
            Image(image: AssetImage("assets/images/a.jpg"))
          ],
        ),
      )
    );
  }
}