class RatingDto {
  final String id;
  final double? rating;

  RatingDto({
    required this.id,
    this.rating,
  });

  factory RatingDto.fromJson(Map<String, dynamic> json) {
    return RatingDto(
      id: json['contractor_id'] ?? '',
      rating: json['rating'],
    );
  }
  @override
  String toString() => 'ContractorDto(id: $id, companyname: $rating';
}
