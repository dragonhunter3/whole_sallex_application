class ProductModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final double price;
  final double? minPrice;
  final double? maxPrice;
  final String category;
  final String subCategory;
  final bool isBidding;
  final DateTime? biddingStartTime;
  final DateTime? biddingEndTime;
  final bool isScheduled;
  final DateTime? scheduleTime;
  final int? rating;

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      this.imageUrl,
      required this.price,
      this.minPrice,
      this.maxPrice,
      required this.category,
      required this.subCategory,
      this.isBidding = false,
      this.biddingStartTime,
      this.biddingEndTime,
      this.isScheduled = false,
      this.scheduleTime,
      this.rating});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'category': category,
      'subCategory': subCategory,
      'isBidding': isBidding,
      'biddingStartTime': biddingStartTime?.toIso8601String(),
      'biddingEndTime': biddingEndTime?.toIso8601String(),
      'isScheduled': isScheduled,
      'scheduleTime': scheduleTime?.toIso8601String(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String? ?? 'default_id',
      title: map['title'] as String? ?? 'Untitled',
      description: map['description'] as String? ?? 'No description',
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : map['price'] as double? ?? 0.0,
      minPrice: map['minPrice'] != null
          ? (map['minPrice'] is int)
              ? (map['minPrice'] as int).toDouble()
              : map['minPrice'] as double
          : null,
      maxPrice: map['maxPrice'] != null
          ? (map['maxPrice'] is int)
              ? (map['maxPrice'] as int).toDouble()
              : map['maxPrice'] as double
          : null,
      category: map['category'] as String? ?? 'Uncategorized',
      subCategory: map['subCategory'] as String? ?? 'Uncategorized',
      isBidding: map['isBidding'] as bool? ?? false,
      biddingStartTime: map['biddingStartTime'] != null
          ? DateTime.parse(map['biddingStartTime'] as String)
          : null,
      biddingEndTime: map['biddingEndTime'] != null
          ? DateTime.parse(map['biddingEndTime'] as String)
          : null,
      isScheduled: map['isScheduled'] as bool? ?? false,
      scheduleTime: map['scheduleTime'] != null
          ? DateTime.parse(map['scheduleTime'] as String)
          : null,
    );
  }
}
