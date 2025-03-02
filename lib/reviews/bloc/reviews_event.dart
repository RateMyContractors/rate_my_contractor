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

class ReviewsCommentChanged extends ReviewsEvent {
  const ReviewsCommentChanged({required this.comment});
  final String comment;

  @override
  List<Object> get props => [comment];
}

class ReviewsFormButtonPressed extends ReviewsEvent {
  const ReviewsFormButtonPressed({
    required this.contractorid,
    required this.reviewerid,
    required this.rating,
    required this.comment,
    required this.upvote,
    required this.downvote,
    required this.username,
    required this.usertype,
  });

  final String contractorid;
  final String reviewerid;
  final int rating;
  final String comment;
  final int upvote;
  final int downvote;
  final String username;
  final String usertype;

  @override
  List<Object> get props => [
        contractorid,
        reviewerid,
        rating,
        comment,
        upvote,
        downvote,
        username,
        usertype,
      ];
}

class ReviewsRequest extends ReviewsEvent {
  const ReviewsRequest({required this.contractorId});

  final String contractorId;
  @override
  List<Object> get props => [contractorId];
  @override
  String toString() => 'Reviews requested {contractorId: $contractorId}';
}

class ReviewsDownButtonPressed extends ReviewsEvent {
  const ReviewsDownButtonPressed({
    required this.downbutton,
    required this.contractorid,
    required this.reviewerid,
    required this.reviewid,
    required this.downbuttonClicked,
  });

  final String contractorid;
  final String reviewerid;
  final int downbutton;
  final String reviewid;
  final bool downbuttonClicked;

  @override
  List<Object> get props =>
      [downbutton, contractorid, reviewerid, reviewid, downbuttonClicked];

  @override
  String toString() => 'ReviewsDownButtonPressed $downbutton}';
}

class ReviewsUpButtonPressed extends ReviewsEvent {
  const ReviewsUpButtonPressed({
    required this.upbutton,
    required this.contractorid,
    required this.reviewerid,
    required this.reviewid,
    required this.upbuttonClicked,
  });

  final String contractorid;
  final String reviewerid;
  final int upbutton;
  final String reviewid;
  final bool upbuttonClicked;

  @override
  List<Object> get props =>
      [upbutton, contractorid, reviewerid, reviewid, upbuttonClicked];

  @override
  String toString() => 'ReviewsUpButtonPressed $upbutton}';
}
