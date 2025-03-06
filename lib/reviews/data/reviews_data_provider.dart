import 'dart:convert';
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
    String reviewerId,
    String contractorId,
    int upvote,
    int downVote,
    String reviewid,
  ) async {
    try {
      final votesJson = await _supabaseClient
          .from('Reviews')
          .select()
          .eq('contractor_id', contractorId)
          .eq('reviewer_id', reviewerId)
          .eq('review_id', reviewid);
      final reviewsObjList =
          votesJson.map<ReviewsDto>(ReviewsDto.fromJson).toList().first;
      if (upvote == 0) {
        final supaDownVotes = reviewsObjList.downvote;
        await _supabaseClient
            .from('Reviews')
            .update({'down_vote': supaDownVotes + downVote})
            .eq('contractor_id', contractorId)
            .eq('reviewer_id', reviewerId)
            .eq('review_id', reviewid);
      } else if (downVote == 0) {
        final supaUpVotes = reviewsObjList.upvote;
        final vote = supaUpVotes + upvote;
        await _supabaseClient
            .from('Reviews')
            .update({'up_vote': vote})
            .eq('contractor_id', contractorId)
            .eq('reviewer_id', reviewerId)
            .eq('review_id', reviewid);
      }
    } on Exception catch (error) {
      throw Exception('updating review $error');
    }
  }

  Future<String> uploadImageToSupabase(
    String baseString,
    String reviewerid,
    String contractorid,
  ) async {
    try {
      final imageFile = base64Decode(baseString);
      await _supabaseClient.storage
          .from('images')
          .uploadBinary('reviews/$contractorid/$reviewerid', imageFile);
      return _supabaseClient.storage
          .from('reviews')
          .getPublicUrl('reviews/$contractorid/$reviewerid');
    } on Exception catch (error) {
      return throw Exception('upload to supabase failed $error');
    }
  }
}
