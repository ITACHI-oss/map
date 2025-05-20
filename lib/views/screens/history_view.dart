import 'package:flutter/material.dart';
import 'package:dars_13/veiw_model/firestore_service.dart';

class HistoryView extends StatelessWidget {
  HistoryView({super.key});

  final FirestoreService service = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sotti Borgan Joylar Tarixi'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: service.getLocations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tarix bo'sh"));
          }

          final locations = snapshot.data!;

          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final loc = locations[index];
              return ListTile(
                leading: Icon(Icons.location_on),
                title: Text(loc['name'] ?? 'Noma\'lum joy'),
                subtitle: Text(
                    'Latitude: ${loc['lat']?.toStringAsFixed(4)}, Longitude: ${loc['lng']?.toStringAsFixed(4)}'),
                onTap: () {
                },
              );
            },
          );
        },
      ),
    );
  }
}
