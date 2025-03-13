import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';
import 'package:test/test.dart';

void main() {
  group('testing ReviewsDto', () {
    test('ReviewsDto works successfully using toString', () {
      const reviews = ReviewsDto(
        reviewid: '1',
        contractorId: '2',
        reviewerId: '3',
        comment: '4',
        rating: 1,
        upvote: 2,
        downvote: 3,
        date: '1',
        username: '1',
        usertype: '1',
        imageurls: ['1'],
      );

      expect(
          reviews.toString(),
          'ReviewsDto(reviewerid: 3, contractorid: 2,'
          ' comment: 4, rating: 1, name: 1, type: 1,'
          ' upvote: 2, downvote: 3)');
    });

    test('factory Reviews Dto', () {
      final jsonReview = {
        'reviewer_id': '1',
        'contractor_id': '2',
        'review_id': '3',
        'comment': '4',
        'rating': 5,
        'up_vote': 6,
        'down_vote': 7,
        'created_at': '2024-03-12T14:30:00Z',
        'username': '8',
        'user_type': '9',
        'image_urls': ['10'],
      };

      final review = ReviewsDto.fromJson(jsonReview);

      expect(review.reviewerId, '1');
      expect(review.contractorId, '2');
      expect(review.reviewid, '3');
      expect(review.comment, '4');
      expect(review.rating, 5);
      expect(review.upvote, 6);
      expect(review.downvote, 7);
      expect(review.username, '8');
      expect(review.date, 'March 12, 2024');
    });
  });
}
