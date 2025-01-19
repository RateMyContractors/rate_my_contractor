import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';
import 'package:rate_my_contractor/reviews/data/reviews_data_provider.dart';

class ReviewsRepository {
  const ReviewsRepository(this._reviewsDataProvider);
  final ReviewsDataProvider _reviewsDataProvider;

  Future<void> createReview(String contractorId, String reviewerId, int rating,
      String comment, int upvote, int downvote) async {
    await _reviewsDataProvider.createReview(
        contractorId, reviewerId, rating, comment, upvote, downvote);
  }

  Future<List<ReviewsDto>> getReviews(String contractorId) async {
    List<ReviewsDto> dataSetReviews =
        await _reviewsDataProvider.getReviews(contractorId);
    for (var review in dataSetReviews) {
      print('Review: $review');
    }
    return dataSetReviews;
  }
  //do a loop or some to get the list of the rating to send to dto and widget
}
