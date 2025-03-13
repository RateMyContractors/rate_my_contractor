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
  });
}
