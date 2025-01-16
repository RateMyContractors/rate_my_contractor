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
    //getting the reviews from the database
    final List<ReviewsDto> dataSetReviews =
        await _reviewsDataProvider.getReviews(contractorId);
    return dataSetReviews;
  }
}
