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
    String username,
  ) async {
    try {
      await _supabaseClient.from('Reviews').insert({
        'contractor_id': contractorId,
        'reviewer_id': reviewerId,
        'rating': rating,
        'comment': comment,
        'username': username,
      });
    } on Exception catch (error) {
      Exception('supabase issue$error');
    }
  }

  Future<List<ReviewsDto>> getReviews(String contractorId) async {
    try {
      final reviewJson = await _supabaseClient
          .from('Reviews')
          .select()
          .eq('contractor_id', contractorId)
          .order('modified_at', ascending: false);
      final reviewsObjList =
          reviewJson.map<ReviewsDto>(ReviewsDto.fromJson).toList();
      return reviewsObjList;
    } on Exception catch (error) {
      return throw Exception('review data fetch failed$error');
    }
  }
}
