part of 'reviews_bloc.dart';

enum ReviewsStateStatus {
  initial,
  loading,
  failure,
  success,
  valid,
  invalid,
  passed,
  unpassed
}

class ReviewsState extends Equatable {
  const ReviewsState({
    this.imageFile, //see what to do abt required here
    this.reviewerId = '',
    this.rating = 0,
    this.comment = '',
    this.upvote = 0,
    this.downvote = 0,
    this.contractorId = '',
    this.errormsg = '',
    this.reviews = const [],
    this.status = ReviewsStateStatus.initial,
    this.date = '',
    this.username = '',
    this.imageUrls = const [],
  });
  final ReviewsStateStatus status;
  final String contractorId;
  final String errormsg;
  final String reviewerId;
  final int rating;
  final String comment;
  final int upvote;
  final int downvote;
  final List<ReviewsDto> reviews;
  final String date;
  final String username;
  final List<String> imageUrls;
  final File? imageFile;

  ReviewsState copyWith({
    String? contractorId,
    String? errormsg,
    String? reviewerId,
    int? rating,
    String? comment,
    int? upvote,
    int? downvote,
    List<ReviewsDto>? reviews,
    ReviewsStateStatus? status,
    String? date,
    String? username,
    List<String>? imageUrls,
    File? imageFile,
  }) {
    return ReviewsState(
        contractorId: contractorId ?? this.contractorId,
        errormsg: errormsg ?? this.errormsg,
        reviews: reviews ?? this.reviews,
        status: status ?? this.status,
        reviewerId: reviewerId ?? this.reviewerId,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        upvote: upvote ?? this.upvote,
        downvote: downvote ?? this.downvote,
        date: date ?? this.date,
        username: username ?? this.username,
        imageUrls: imageUrls ?? this.imageUrls,
        imageFile: imageFile ?? this.imageFile);
  }

  @override
  List<Object?> get props => [
        status,
        contractorId,
        errormsg,
        reviews,
        reviewerId,
        rating,
        comment,
        upvote,
        downvote,
        date,
        username,
        imageUrls,
        imageFile
      ];

  @override
  String toString() =>
      'ReviewState(contractorId: $contractorId, errormsg: $errormsg,'
      ' reviews: $reviews,'
      ' status: $status, username: $username)';
}
