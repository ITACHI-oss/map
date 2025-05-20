import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dars_13/veiw_model/firestore_service.dart';

class RouteMapView extends StatefulWidget {
  const RouteMapView({super.key});

  @override
  State<RouteMapView> createState() => _RouteMapViewState();
}

class _RouteMapViewState extends State<RouteMapView> {
  late GoogleMapController mapController;
  final FirestoreService service = FirestoreService();

  Set<Marker> _markers = {};
  List<LatLng> _polylinePoints = [];

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(41.3111, 69.2797), // Tashkent markazi
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    service.getLocations().listen((locations) {
      final List<LatLng> points = [];
      final Set<Marker> markers = {};

      for (var loc in locations) {
        final LatLng point = LatLng(loc['lat'], loc['lng']);
        points.add(point);
        markers.add(
          Marker(
            markerId: MarkerId(loc['name']),
            position: point,
            infoWindow: InfoWindow(title: loc['name']),
          ),
        );
      }

      setState(() {
        _polylinePoints = points;
        _markers = markers;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sotti yurgan yo‘li'),
        backgroundColor: Colors.green,
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (controller) => mapController = controller,
        mapType: MapType.normal,
        markers: _markers,
        polylines: {
          Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            width: 5,
            points: _polylinePoints,
          ),
        },
      ),
    );
  }
}
