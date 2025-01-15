/// Data model representing a tourist attraction in Konya
class Attraction {
  /// Unique identifier from Firestore
  final String id;

  /// Name of the attraction
  final String name;

  /// Detailed description of the attraction
  final String description;

  /// URL to the attraction's image
  final String imageUrl;

  /// Category of the attraction (e.g., 'History', 'Shopping', 'Parks', 'Food')
  final String category;

  /// Physical location/address of the attraction
  final String location;

  Attraction({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.location,
  });

  /// Converts the attraction data to a Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'location': location,
    };
  }

  /// Creates an Attraction instance from Firestore data
  /// [map] is the document data from Firestore
  /// [documentId] is the document ID from Firestore
  factory Attraction.fromMap(Map<String, dynamic> map, String documentId) {
    return Attraction(
      id: documentId,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
      location: map['location'] ?? '',
    );
  }
}
