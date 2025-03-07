import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class ReviewsDto extends Equatable {
  const ReviewsDto({
    required this.reviewid,
    required this.contractorId,
    required this.reviewerId,
    required this.comment,
    required this.rating,
    required this.upvote,
    required this.downvote,
    required this.date,
    required this.username,
    required this.usertype,
    required this.imageurls,
    this.upvoteClicked = false,
    this.downvoteClicked = false,
  });

  factory ReviewsDto.fromJson(Map<String, dynamic> json) {
    final rawdate = json['created_at'] as String? ?? '';
    final dateparsed = DateTime.parse(rawdate);

    final dateOnly = DateFormat('MMMM d, yyyy').format(dateparsed);
    return ReviewsDto(
      reviewerId: json['reviewer_id'] as String? ?? '',
      contractorId: json['contractor_id'] as String? ?? '',
      reviewid: json['review_id'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      rating: json['rating'] as int? ?? 0,
      upvote: json['up_vote'] as int? ?? 0,
      downvote: json['down_vote'] as int? ?? 0,
      date: dateOnly,
      username: json['username'] as String? ?? '',
      usertype: json['user_type'] as String? ?? '',
      imageurls: (json['image_urls'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
    );
  }

  //copyWith method allows us to specify only the fields we want to change,
  //while the rest retain their existing values.
  ReviewsDto copyWith({
    int? upvote,
    int? downvote,
    bool? upvoteClicked,
    bool? downvoteClicked,
  }) {
    return ReviewsDto(
      reviewid: reviewid,
      contractorId: contractorId,
      reviewerId: reviewerId,
      comment: comment,
      rating: rating,
      upvote: upvote ?? this.upvote,
      downvote: downvote ?? this.downvote,
      date: date,
      username: username,
      usertype: usertype,
      upvoteClicked: upvoteClicked ?? this.upvoteClicked,
      downvoteClicked: downvoteClicked ?? this.downvoteClicked,
      imageurls: imageurls,
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
  final String usertype;
  final bool upvoteClicked;
  final bool downvoteClicked;
  final List<String> imageurls;

  @override
  List<Object?> get props => [
        reviewid,
        contractorId,
        reviewerId,
        comment,
        rating,
        upvote,
        downvote,
        date,
        username,
        usertype,
        upvoteClicked,
        downvoteClicked,
        imageurls,
      ];
  @override
  String toString() =>
      'ReviewsDto(reviewerid: $reviewerId, contractorid: $contractorId,'
      ' comment: $comment, rating: $rating, name: $username, type: $usertype,'
      ' upvote: $upvote, downvote: $downvote)';
}
