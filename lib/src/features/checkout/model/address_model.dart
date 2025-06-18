import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String id;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final Timestamp? addedAt;

  Address({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.addedAt,
  });

  factory Address.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Address(
      id: doc.id,
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      zipCode: data['zipCode'] ?? '',
      country: data['country'] ?? '',
      addedAt: data['addedAt'],
    );
  }
}
