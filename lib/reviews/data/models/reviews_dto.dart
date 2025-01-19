class ReviewsDto {
  final String reviewid;
  final String contractorId;
  final String reviewerId;
  final String comment;
  final int rating;
  final int upvote;
  final int downvote;
  final String date;

  ReviewsDto(
      {required this.reviewid,
      required this.contractorId,
      required this.reviewerId,
      required this.comment,
      required this.rating,
      required this.upvote,
      required this.downvote,
      required this.date});

//i forgot what factory was for and why are we using ?? ''
  factory ReviewsDto.fromJson(Map<String, dynamic> json) {
    var rawdate = json['created_at'];
    print("Raw date: $rawdate");
    final dateparsed = DateTime.parse(rawdate);
    print("Parsed date: $dateparsed");
    final dateOnly =
        DateTime(dateparsed.year, dateparsed.month, dateparsed.day);
    return ReviewsDto(
        reviewerId: json['reviewer_id'] ?? '',
        contractorId: json['contractor_id'] ?? '',
        reviewid: json['reviewer_id'] ?? '',
        comment: json['comment'] ?? '',
        rating: json['rating'] ?? 0,
        upvote: json['up_vote'] ?? 0,
        downvote: json['down_vote'] ?? 0,
        date: dateOnly.toString());
  }
  @override
  String toString() =>
      'ReviewsDto(reviewerid: $reviewerId, contractorid: $contractorId, comment: $comment, rating: $rating)';
}
