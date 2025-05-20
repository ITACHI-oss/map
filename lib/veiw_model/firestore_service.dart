import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addLocation(String name, double lat, double lng) async {
    await _db.collection('locations').add({
      'name': name,
      'lat': lat,
      'lng': lng,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> getLocations() {
    return _db
        .collection('locations')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                final data = doc.data();
                data['id'] = doc.id; // <-- doc id ni ham qo‘shamiz
                return data;
              }).toList(),
        );
  }

  Future<void> deleteLocation(String docId) async {
    await FirebaseFirestore.instance
        .collection('locations')
        .doc(docId)
        .delete();
  }
}
