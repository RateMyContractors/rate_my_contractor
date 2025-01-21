import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewsDataProvider {
  const ReviewsDataProvider(this._supabaseClient);

  final SupabaseClient _supabaseClient;
  Future<void> createReview(
    String contractorId,
    String reviewerId,
    int rating,
    String comment,
    int upvote,
    int downvote,
  ) async {
    try {
      await _supabaseClient.from('Reviews').insert({
        'contractor_id': contractorId,
        'reviewer_id': reviewerId,
        'rating': rating,
        'comment': comment
      });
    } catch (error) {
      Exception("supabase issue$error");
      print(error);
    }
  }

  Future<List<ReviewsDto>> getReviews(String contractorId) async {
    try {
      print('contractor being sent to the provider');
      print(contractorId);
      final reviewJson = await _supabaseClient
          .from('Reviews')
          .select('*')
          .eq("contractor_id", contractorId);
      print('Raw Response: $reviewJson');
      List<ReviewsDto> reviewsObjList = reviewJson
          .map<ReviewsDto>((review) => ReviewsDto.fromJson(review))
          .toList();
      print(reviewsObjList);
      return reviewsObjList;
    } catch (error) {
      print(error);
      return throw (Exception("review data fetch failed"));
    }
  }
}
