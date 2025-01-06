import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewsDataProvider {
  const ReviewsDataProvider(this._supabaseClient);

  final SupabaseClient _supabaseClient;

  /// Make query to get all reviews
  Future<List<ReviewsDto>> getReviews(String query) async {
      //String query
      try{
        final reviewJson = await _supabaseClient
        .from('Reviews')  
        .select('*')        
        .eq('contractor_id', query);
        print(query);
        
        List<ReviewsDto> ReviewObjList = reviewJson.map<ReviewsDto>((review) => ReviewsDto.fromJson(review)).toList();
        return ReviewObjList;
      } catch(error){
        return throw(Exception("data fetch failed: review table"));
      }
  }
  
  Future<void> createReview(String contractorid, String reviewerid, String reviewid, String comment, int rating) async {
    try{
      await _supabaseClient 
        .from('Reviews')
        .insert({
          'contractor_id':contractorid,
          'reviewer_id':reviewerid,
          'review_id':reviewid,
          'comment':comment,
          'rating':rating,
          });
    } catch(error){
        throw(Exception('data insert failed: review table'));
    }
  }
}
