import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:livemap/livemap.dart';
import 'package:latlong/latlong.dart';

class _CustomControlsPageState extends State<CustomControlsPage> {
  static final MapController mapController = MapController();

  static final LiveMapController liveMapController =
      LiveMapController(autoCenter: true, mapController: mapController);

  @override
  void dispose() {
    liveMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        LiveMap(
          liveMapController: liveMapController,
          mapOptions: MapOptions(
            center: LatLng(51.0, 0.0),
            zoom: 17.0,
          ),
          titleLayer: TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
        ),
        Positioned(
          top: 35.0,
          right: 15.0,
          child: Column(
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                color: Colors.blueGrey,
                icon: const Icon(Icons.center_focus_strong),
                tooltip: "Center",
                onPressed: () => liveMapController.centerOnLiveMarker(),
              ),
              IconButton(
                iconSize: 30.0,
                color: Colors.blueGrey,
                icon: Icon(Icons.center_focus_weak),
                tooltip: "Toggle autocenter",
                onPressed: () {
                  liveMapController.toggleAutoCenter();
                  Fluttertoast.showToast(
                    msg: liveMapController.autoCenter
                        ? "Auto center activated"
                        : "Auto center deactivated",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
              ),
              IconButton(
                iconSize: 30.0,
                color: Colors.blueGrey,
                icon: liveMapController.positionStreamEnabled
                    ? Icon(Icons.gps_not_fixed)
                    : Icon(Icons.gps_off),
                tooltip: "Toggle live position updates",
                onPressed: () {
                  _togglePositionStream();
                  Fluttertoast.showToast(
                    msg: (liveMapController.positionStreamEnabled)
                        ? "Position updates enabled"
                        : "Position updates disabled",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
              ),
              IconButton(
                  iconSize: 30.0,
                  color: Colors.blueGrey,
                  icon: Icon(Icons.zoom_in),
                  tooltip: "Zoom in",
                  onPressed: () => liveMapController.zoomIn()),
              IconButton(
                  iconSize: 30.0,
                  color: Colors.blueGrey,
                  icon: Icon(Icons.zoom_out),
                  tooltip: "Zoom out",
                  onPressed: () => liveMapController.zoomOut()),
            ],
          ),
        )
      ],
    ));
  }

  _togglePositionStream() {
    setState(() {
      liveMapController.togglePositionStreamSubscription();
    });
  }
}

class CustomControlsPage extends StatefulWidget {
  @override
  _CustomControlsPageState createState() => _CustomControlsPageState();
}
