class RatingDto {
  RatingDto({
    required this.id,
    this.rating,
  });

  factory RatingDto.fromJson(Map<String, dynamic> json) {
    return RatingDto(
      id: json['contractor_id'] as String? ?? '',
      rating: json['rating'] as double? ?? 0,
    );
  }
  final String id;
  final double? rating;
  @override
  String toString() => 'ContractorDto(id: $id, companyname: $rating';
}
