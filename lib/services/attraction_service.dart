import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/attraction.dart';

/// Service class to handle Firestore operations for attractions
class AttractionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String collectionName = 'attractions';

  /// Streams all attractions from Firestore
  /// Returns a stream of [List<Attraction>] that updates in real-time
  Stream<List<Attraction>> getAttractions() {
    return _firestore.collection(collectionName).snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => Attraction.fromMap(doc.data(), doc.id))
            .toList());
  }

  /// Streams attractions filtered by category
  /// [category] is the category to filter by (e.g., "History", "Shopping")
  /// Returns a stream of [List<Attraction>] containing only attractions in the specified category
  Stream<List<Attraction>> getAttractionsByCategory(String category) {
    return _firestore
        .collection(collectionName)
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Attraction.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Add a new attraction
  Future<void> addAttraction(Attraction attraction, File? imageFile) async {
    String imageUrl = attraction.imageUrl;

    // If there's a new image file, upload it first
    if (imageFile != null) {
      final storageRef = _storage
          .ref()
          .child('attraction_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageRef.putFile(imageFile);
      imageUrl = await storageRef.getDownloadURL();
    }

    // Create attraction with the image URL
    final attractionData = attraction.toMap();
    attractionData['imageUrl'] = imageUrl;

    await _firestore.collection(collectionName).add(attractionData);
  }

  // Update an attraction
  Future<void> updateAttraction(Attraction attraction) async {
    await _firestore
        .collection(collectionName)
        .doc(attraction.id)
        .update(attraction.toMap());
  }

  // Delete an attraction
  Future<void> deleteAttraction(String attractionId) async {
    await _firestore.collection(collectionName).doc(attractionId).delete();
  }
}
