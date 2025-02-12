import 'package:intl/intl.dart';

class ReviewsDto {
  ReviewsDto({
    required this.reviewid,
    required this.contractorId,
    required this.reviewerId,
    required this.comment,
    required this.rating,
    required this.upvote,
    required this.downvote,
    required this.date,
    required this.username,
    this.imageUrls = const [''],
  });

  factory ReviewsDto.fromJson(Map<String, dynamic> json) {
    final rawdate = json['created_at'] as String? ?? '';
    final dateparsed = DateTime.parse(rawdate);

    final dateOnly = DateFormat('MMMM d, yyyy').format(dateparsed);
    return ReviewsDto(
      reviewerId: json['reviewer_id'] as String? ?? '',
      contractorId: json['contractor_id'] as String? ?? '',
      reviewid: json['reviewer_id'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      rating: json['rating'] as int? ?? 0,
      upvote: json['up_vote'] as int? ?? 0,
      downvote: json['down_vote'] as int? ?? 0,
      date: dateOnly,
      username: json['username'] as String? ?? '',
      imageUrls: (json['image_urls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          <String>[], // json['image_urls'] as List<String>? ?? '',
    );
  }
  final String reviewid;
  final String contractorId;
  final String reviewerId;
  final String comment;
  final int rating;
  final int upvote;
  final int downvote;
  final String date;
  final String username;
  final List<String> imageUrls;
  @override
  String toString() =>
      'ReviewsDto(reviewerid: $reviewerId, contractorid: $contractorId,'
      ' comment: $comment, rating: $rating, username: $username)';
}
