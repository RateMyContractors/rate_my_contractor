part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object> get props => [];
}

class ReviewsStarsPressed extends ReviewsEvent {
  const ReviewsStarsPressed({required this.starRating});

  final int starRating;

  @override
  List<Object> get props => [starRating];
}

class ReviewsFormButtonPressed extends ReviewsEvent {
  const ReviewsFormButtonPressed({
    required this.contractorid,
    required this.reviewerid,
    required this.rating,
    required this.comment,
    required this.upvote,
    required this.downvote,
  });

  final String contractorid;
  final String reviewerid;
  final int rating;
  final String comment;
  final int upvote;
  final int downvote;

  @override
  List<Object> get props =>
      [contractorid, reviewerid, rating, comment, upvote, downvote];
}

class ReviewsRequest extends ReviewsEvent {
  const ReviewsRequest({required this.contractorId});

  final String contractorId;
  @override
  List<Object> get props => [contractorId];
  @override
  String toString() => 'Reviews requested {contractorId: $contractorId}';
}
