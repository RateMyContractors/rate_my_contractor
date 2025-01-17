class ReviewsDto {
  final String reviewid;
  final String contractorid;
  final String reviewerid;
  final String comment;
  final int rating;
  final int upvote;
  final int downvote;
  final String date;

  ReviewsDto(
      {required this.reviewid,
      required this.contractorid,
      required this.reviewerid,
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
        reviewerid: json['reviewer_id'] ?? '',
        contractorid: json['contractor_id'] ?? '',
        reviewid: json['reviewer_id'] ?? '',
        comment: json['comment'],
        rating: json['rating'],
        upvote: json['up_vote'],
        downvote: json['down_vote'],
        date: dateOnly.toString());
  }
  @override
  String toString() =>
      'ReviewsDto(reviewerid: $reviewerid, contractorid: $contractorid, reviewerid: $reviewerid, comment: $comment, rating: $rating)';
}
