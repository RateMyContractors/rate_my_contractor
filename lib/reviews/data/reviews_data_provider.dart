import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';
import 'package:rate_my_contractor/reviews/data/models/votes_dto.dart';
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
    String usertype,
  ) async {
    try {
      await _supabaseClient.from('Reviews').insert({
        'contractor_id': contractorId,
        'reviewer_id': reviewerId,
        'rating': rating,
        'comment': comment,
        'username': username,
        'user_type': usertype,
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

  Future<void> updateReview(
      String reviewerId, String contractorId, int upvote, int downVote) async {
    try {
      //we are eiher sending 1 upvote, -1 upvote, 1 downvote or -1 downvote, or 0 as in no upvote was made, and 0 as in no downvote was made
      final votesJson = await _supabaseClient
          .from('Reviews')
          .select()
          .eq('contractor_id', contractorId)
          .eq('reviewer_id', reviewerId);
      final votesObj = votesJson.map<VotesDto>(VotesDto.fromJson).first;

      if (upvote == 0) {
        final supaDownVotes = votesObj.downvote;
        await _supabaseClient
            .from('Reviews')
            .update({'down_vote': supaDownVotes + downVote});
      } else if (downVote == 0) {
        final supaUpVotes = votesObj.upvote;
        await _supabaseClient
            .from('Reviews')
            .update({'up_vote': supaUpVotes + upvote});
      }
    } on Exception catch (error) {
      throw Exception('updating review $error');
    }
  }
}
