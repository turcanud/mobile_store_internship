class Product {
  final int id;
  final int categoryId;
  final String name;
  final String image;
  final String section;
  final String description;
  final double price;
  final List<String>? colours;
  final List<String>? sizes;
  final List<Review>? reviews;
  final String? promotion;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.section,
    this.colours,
    this.sizes,
    this.reviews,
    this.promotion,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['productId']) as int,
      categoryId: (json['categoryId']) as int,
      name: (json['name']) as String,

      /// Maps the JSON key 'imagePath' to the Product field 'image'
      image: (json['imagePath']) as String,
      description: (json['details']) as String,
      price: (json['price'] ?? 0).toDouble(),
      section: (json['section']) as String,
      colours: json['colours'] != null
          ? List<String>.from(json['colours'] as List)
          : <String>[],
      sizes: json['sizes'] != null
          ? List<String>.from(json['sizes'] as List)
          : <String>[],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((r) => Review.fromJson(r)).toList()
          : <Review>[],
      promotion: json['promotion'] as String?,
    );
  }
}

class Review {
  final int id;
  final String author;
  final String content;
  final int rating;

  Review({
    required this.id,
    required this.author,
    required this.content,
    required this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: (json['id'] ?? 0) as int,
      author: (json['author'] ?? '') as String,
      content: (json['content'] ?? '') as String,
      rating: (json['rating'] ?? 0) as int,
    );
  }
}
