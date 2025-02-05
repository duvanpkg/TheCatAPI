class Breed {
  // String id;
  String name;
  String description;
  String? imageReferenceId;
  String? imageUrl;

  String originCountry;
  int intelligence;
  int adaptability;
  String lifeSpan;

  Breed({
    // required this.id,
    required this.name,
    required this.description,
    this.imageReferenceId,
    this.imageUrl,
    required this.originCountry,
    required this.intelligence,
    required this.adaptability,
    required this.lifeSpan,
  });

  factory Breed.fromJsonMap(Map<String, dynamic> json) {
    return Breed(
      // id: json['id'],
      name: json['name'],
      description: json['description'],
      imageReferenceId: json['reference_image_id'],
      imageUrl: json['image'],
      originCountry: json['origin'],
      intelligence: json['intelligence'],
      adaptability: json['adaptability'],
      lifeSpan: json['life_span'],
    );
  }
}
