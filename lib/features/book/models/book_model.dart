class BookModel {
  String title;
  List<String> authors;
  String publisher;
  String publishedDate;
  String description;
  List<String> categories;
  String imageLink;
  bool isEbook;
  bool isFavorite;

  String get authorsNormalize => authors.join(', ');
  String get descriptionMinimized => description.length > 153 ? '${description.substring(0, 150)}...' : description;
  
  BookModel({
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.categories,
    required this.imageLink,
    required this.isEbook,
    required this.isFavorite,
  });

  factory BookModel.fromMap(Map<String, dynamic> map) {
    final Map volumeInfo = map['volumeInfo'];
    final Map? saleInfo = map['saleInfo'];
    return BookModel(
      title: volumeInfo['title'] ?? '', 
      authors: volumeInfo['authors']?.map<String>((value) => value as String).toList() ?? [],
      publisher: volumeInfo['publisher']?? '',
      publishedDate: volumeInfo['publishedDate'] ?? '', 
      description: volumeInfo['description'] ?? '', 
      categories: volumeInfo['categories']?.map<String>((value) => value as String).toList() ?? [],
      imageLink: volumeInfo['imageLinks']?['thumbnail'] ?? '',
      isEbook: saleInfo?['isEbook'] ?? false,
      isFavorite: saleInfo?['isFavorite'] ?? false,
    );
  }

  BookModel toCopyWith({
    String? title,
    List<String>? authors,
    String? publisher,
    String? publishedDate,
    String? description,
    List<String>? categories,
    String? imageLink,
    bool? isEbook,
    bool? isFavorite,
  }) {
    return BookModel(
      title: title ?? this.title, 
      authors: authors ?? this.authors,
      publisher: publisher ?? this.publisher,
      publishedDate: publishedDate ?? this.publishedDate, 
      description: description ?? this.description, 
      categories: categories ?? this.categories,
      imageLink: imageLink ?? this.imageLink,
      isEbook: isEbook ?? this.isEbook,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}