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
    required this.imageUrls,
  });

  final String contractorid;
  final String reviewerid;
  final int rating;
  final String comment;
  final int upvote;
  final int downvote;
  final String username;
  final List<String> imageUrls;

  @override
  List<Object> get props => [
        contractorid,
        reviewerid,
        rating,
        comment,
        upvote,
        downvote,
        username,
        imageUrls,
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

class ReviewUploadImage extends ReviewsEvent {
  const ReviewUploadImage({required this.imageFile});

  final File imageFile;
  @override
  List<Object> get props => [imageFile];
  @override
  String toString() => 'Reviews requested {imageFile: $imageFile}';
}
