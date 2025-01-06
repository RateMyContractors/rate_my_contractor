class ReviewsDto {
  final String contractorid;
  final String reviewerid;
  final String reviewid;
  final String comment;
  final int rating;

  ReviewsDto({
    required this.contractorid,
    required this.reviewerid, 
    required this.reviewid, 
    required this.comment, 
    required this.rating, 
    
  });


  factory ReviewsDto.fromJson(Map<String,dynamic> json){
    return ReviewsDto(
      contractorid:  json['contractorid'] ?? '',
      reviewerid: json['reviewerid'],
      reviewid: json['reviewid'],
      comment:json['comment'],
      rating:json['rating'],
    );
  }

  @override
  String toString() => 
      'ContractorDto(contractorid: $contractorid, reviwerid: $reviewerid, reviewerid: $reviewerid, comment: $comment, rating: $rating)';
}
