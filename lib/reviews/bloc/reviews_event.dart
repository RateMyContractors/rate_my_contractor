//user fills out the form and clicks submit (submitting reviews)
//contractor gets selected on -> displays the contractor infomration and the contractors reviews (obtaining reviews)
part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object> get props => [];
}

class ReviewsFormButtonPressed extends ReviewsEvent {
  const ReviewsFormButtonPressed(
      {required this.contractorid,
      required this.reviewerid,
      required this.rating,
      required this.comment,
      required this.upvote,
      required this.downvote});

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
  const ReviewsRequest({required this.contractorid});

  final String contractorid;

  @override
  List<Object> get props => [contractorid];

  @override
  String toString() => 'Search Commenced {contractorid: $contractorid}';
}
