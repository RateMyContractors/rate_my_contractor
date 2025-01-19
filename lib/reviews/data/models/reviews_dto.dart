class ReviewsDto {
  final String reviewid;
  final String contractorId;
  final String reviewerId;
  final String comment;
  final int rating;
  final int upvote;
  final int downvote;

  ReviewsDto(
      {required this.reviewid,
      required this.contractorId,
      required this.reviewerId,
      required this.comment,
      required this.rating,
      required this.upvote,
      required this.downvote});

//i forgot what factory was for and why are we using ?? ''
  factory ReviewsDto.fromJson(Map<String, dynamic> json) {
    return ReviewsDto(
        reviewerId: json['reviewer_id'] ?? '',
        contractorId: json['contractor_id'] ?? '',
        reviewid: json['reviewer_id'] ?? '',
        comment: json['comment'] ?? '',
        rating: json['rating'] ?? 0,
        upvote: json['up_vote'] ?? 0,
        downvote: json['down_vote'] ?? 0);
  }
  @override
  String toString() =>
      'ReviewsDto(reviewerid: $reviewerId, contractorid: $contractorId, comment: $comment, rating: $rating)';
}
