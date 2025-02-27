class ListBook {
  final String bookId;
  final String title;
  final String description;
  final double price;
  final int stock;
  final String category;
  final String types;
  final String imageUrl;
  final String heightThickness;
  final String pages;
  final String language;
  final String size;
  final DateTime date;

  ListBook({
    required this.bookId,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.types,
    required this.imageUrl,
    required this.heightThickness,
    required this.pages,
    required this.language,
    required this.size,
    required this.date,
  });

  factory ListBook.fromMap(Map<String, dynamic> map) {
  return ListBook(
    bookId: map['bookId'] ?? '',
    title: map['title'] ?? 'No Title',
    description: map['description'] ?? 'No Description',
    price: (map['price'] ?? 0).toDouble(),
    stock: map['stock'] ?? 0,
    category: map['category'] ?? 'Unknown',
    types: map['types'] ?? 'Unknown',
    imageUrl: map['imageUrl'] ?? '',
    heightThickness: map['height_thickness'] ?? '',
    pages: map['pages'] ?? '',
    language: map['language'] ?? 'Unknown',
    size: map['size'] ?? 'N/A',
    date: DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
  );
}

}
