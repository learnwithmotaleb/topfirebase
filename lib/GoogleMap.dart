

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
        25.943239467030992, 88.84586909432912),
    zoom: 14.4746,

  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
        centerTitle: true,
      ),
      body:Container(
        color: Colors.grey,
        child: const GoogleMap(
          initialCameraPosition: _kGooglePlex,

        ),
      )
    );
  }
}


