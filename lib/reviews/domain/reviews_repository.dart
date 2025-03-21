import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';
import 'package:rate_my_contractor/reviews/data/reviews_data_provider.dart';

class ReviewsRepository {
  const ReviewsRepository(this._reviewsDataProvider);
  final ReviewsDataProvider _reviewsDataProvider;

  Future<void> createReview(
    String contractorId,
    String reviewerId,
    int rating,
    String comment,
    int upvote,
    int downvote,
    String username,
    String usertype,
    List<String> imageurls,
  ) async {
    await _reviewsDataProvider.createReview(
      contractorId,
      reviewerId,
      rating,
      comment,
      upvote,
      downvote,
      username,
      usertype,
      imageurls,
    );
  }

  Future<List<ReviewsDto>> getReviews(String contractorId) async {
    final dataSetReviews = await _reviewsDataProvider.getReviews(contractorId);
    return dataSetReviews;
  }

  Future<void> updateReview(
    String reviewerId,
    String contractorId,
    int upvote,
    int downvote,
    String reviewid,
  ) async {
    await _reviewsDataProvider.updateReview(
      reviewerId,
      contractorId,
      upvote,
      downvote,
      reviewid,
    );
  }

  Future<String> uploadImageToSupabase(
    String basestring,
    String reviewerid,
    String contractorid,
  ) async {
    final imageurl = await _reviewsDataProvider.uploadImageToSupabase(
      basestring,
      reviewerid,
      contractorid,
    );
    return imageurl;
  }
}
