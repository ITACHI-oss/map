import 'package:dars_13/veiw_model/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class RouteMapView extends StatefulWidget {
  const RouteMapView({super.key});

  @override
  State<RouteMapView> createState() => RouteMapViewState();
}

class RouteMapViewState extends State<RouteMapView> {
  final FirestoreService firestoreService = FirestoreService();
  late GoogleMapController mapController;
  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(41.3111, 69.2797),
    zoom: 10,
  );

  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sotti Yurgan Yo‘li")),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: firestoreService.getLocations(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final locations = snapshot.data!;
          _markers.clear();
          for (var loc in locations) {
            _markers.add(
              Marker(
                markerId: MarkerId(loc['id']),
                position: LatLng(loc['lat'], loc['lng']),
                infoWindow: InfoWindow(title: loc['name']),
              ),
            );
          }

          return GoogleMap(
            initialCameraPosition: _initialPosition,
            mapType: MapType.normal,
            markers: _markers,
            onMapCreated: (controller) => mapController = controller,
            onTap: (LatLng position) async {
              String placeName = 'Noma\'lum joy';
              try {
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  position.latitude,
                  position.longitude,
                );
                if (placemarks.isNotEmpty) {
                  placeName = placemarks.first.street ?? 'Noma\'lum';
                }
              } catch (_) {}

              await firestoreService.addLocation(
                placeName,
                position.latitude,
                position.longitude,
              );
            },
          );
        },
      ),
    );
  }
}
