import 'package:dars_13/veiw_model/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMapView extends StatefulWidget {
  const RouteMapView({super.key});

  @override
  RouteMapViewState createState() => RouteMapViewState();
}

class RouteMapViewState extends State<RouteMapView> {
  late GoogleMapController mapController;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(41.3111, 69.2797),
    zoom: 10,
  );

  final List<LatLng> _routePoints = [
    LatLng(41.2643, 69.2038),
    LatLng(41.2609, 69.1872),
    LatLng(41.3663, 69.2999),
    LatLng(41.2995, 69.2634),
    LatLng(41.2579, 69.2810),
  ];

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId("chilonzor"),
      position: LatLng(41.2643, 69.2038),
      infoWindow: InfoWindow(title: "Chilonzor 20"),
    ),
    Marker(
      markerId: MarkerId("maktab"),
      position: LatLng(41.2609, 69.1872),
      infoWindow: InfoWindow(title: "202-maktab"),
    ),
    Marker(
      markerId: MarkerId("yunusobod"),
      position: LatLng(41.3663, 69.2999),
      infoWindow: InfoWindow(title: "Yunusobod 14"),
    ),
    Marker(
      markerId: MarkerId("magic"),
      position: LatLng(41.2995, 69.2634),
      infoWindow: InfoWindow(title: "Magic City"),
    ),
    Marker(
      markerId: MarkerId("aeroport"),
      position: LatLng(41.2579, 69.2810),
      infoWindow: InfoWindow(title: "Toshkent Aeroport"),
    ),
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final service = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sotti Yurgan Yo‘li'),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _initialPosition,
        onMapCreated: (controller) => mapController = controller,
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            width: 5,
            points: _routePoints,
          ),
        },
        markers: {
          ..._markers,
          Marker(
            markerId: MarkerId("start"),
            position: _routePoints.first,
            infoWindow: InfoWindow(title: "Boshlanish"),
          ),
          Marker(
            markerId: MarkerId("end"),
            position: _routePoints.last,
            infoWindow: InfoWindow(title: "Tugash"),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          for (var marker in _markers) {
            await service.addLocation(
              marker.infoWindow.title ?? "Noma'lum joy",
              marker.position.latitude,
              marker.position.longitude,
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Joylar Firestore ga qo‘shildi')),
          );
        },
        child: Icon(Icons.add_location),
        tooltip: 'Joylarni saqlash',
      ),
    );
  }
}
