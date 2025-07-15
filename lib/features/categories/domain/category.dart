class Category {
  final int id;
  final String name;
  final String svgPath;

  const Category({required this.id, required this.name, required this.svgPath});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['categoryId'] as int,
      name: json['name'] as String,
      svgPath: json['svgPath'] as String,
    );
  }
}
