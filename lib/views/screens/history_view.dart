import 'package:flutter/material.dart';
import 'package:dars_13/veiw_model/firestore_service.dart';

class HistoryView extends StatelessWidget {
  final FirestoreService service = FirestoreService();

  HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarix')),
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
                leading: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => service.deleteLocation(loc['id']),
                ),
                title: Text(loc['name'] ?? 'Noma\'lum joy'),
                subtitle: Text(
                  'Lat: ${loc['lat']?.toStringAsFixed(4)}, Lng: ${loc['lng']?.toStringAsFixed(4)}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
