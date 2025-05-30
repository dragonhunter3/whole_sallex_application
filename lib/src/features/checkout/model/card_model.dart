import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  final String id;
  final String cardholderName;
  final String cardNumber;
  final String cvc;
  final String expiryDate;
  final bool isDefault;
  final Timestamp addedAt;

  CardModel({
    required this.id,
    required this.cardholderName,
    required this.cardNumber,
    required this.cvc,
    required this.expiryDate,
    required this.isDefault,
    required this.addedAt,
  });

  factory CardModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CardModel(
      id: doc.id,
      cardholderName: data['cardholderName'] ?? '',
      cardNumber: data['cardNumber'] ?? '',
      cvc: data['cvc'] ?? '',
      expiryDate: data['expiryDate'] ?? '',
      isDefault: data['isDefault'] ?? false,
      addedAt: data['addedAt'] ?? Timestamp.now(),
    );
  }
}
