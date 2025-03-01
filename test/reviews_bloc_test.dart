import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';
import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';
import 'package:rate_my_contractor/reviews/domain/reviews_repository.dart';

class MockReviewsBlocRepository extends Mock implements ReviewsRepository {}

void main() {
  group(ReviewsBloc, () {
    late ReviewsBloc reviewsBloc;
    late MockReviewsBlocRepository mockRepository;

    setUp(() {
      mockRepository = MockReviewsBlocRepository();
      reviewsBloc = ReviewsBloc(mockRepository);
    });

    test('initial state is ', () {
      expect(reviewsBloc.state, equals(const ReviewsState()));
    });

    blocTest<ReviewsBloc, ReviewsState>(
      'emits comment when reviews comment changed',
      build: () => ReviewsBloc(mockRepository),
      act: (bloc) => bloc.add(const ReviewsCommentChanged(comment: 'hey')),
      expect: () => [const ReviewsState(comment: 'hey')],
    );

    blocTest<ReviewsBloc, ReviewsState>(
      'emits star rating when start is pressed',
      build: () => ReviewsBloc(mockRepository),
      act: (bloc) => bloc.add(const ReviewsStarsPressed(starRating: 5)),
      expect: () =>
          [const ReviewsState(rating: 5, status: ReviewsStateStatus.valid)],
    );

    blocTest<ReviewsBloc, ReviewsState>(
      'emits reviews when reviews request',
      build: () {
        when(() => mockRepository.getReviews(any())).thenAnswer(
          (_) async => [
            const ReviewsDto(
              reviewid: '1',
              contractorId: '122344',
              reviewerId: '',
              comment: 'Great work!',
              rating: 5,
              upvote: 10,
              downvote: 0,
              date: '2024-02-28',
              username: 'JohnDoe',
              usertype: 'Client',
            ),
          ],
        ); // Mock response
        return ReviewsBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const ReviewsRequest(contractorId: '122344')),
      expect: () => [
        const ReviewsState(status: ReviewsStateStatus.loading),
        const ReviewsState(
          reviews: [
            ReviewsDto(
              reviewid: '1',
              contractorId: '122344',
              reviewerId: '',
              comment: 'Great work!',
              rating: 5,
              upvote: 10,
              downvote: 0,
              date: '2024-02-28',
              username: 'JohnDoe',
              usertype: 'Client',
            ),
          ],
          status: ReviewsStateStatus.success,
        ),
      ],
    );

    test('UpButton pressed', () {
      const searchtext = ReviewsUpButtonPressed(
        upbutton: 1,
        contractorid: '',
        reviewerid: '',
        reviewid: '',
        upbuttonClicked: true,
      );

      expect(searchtext.toString(), 'ReviewsUpButtonPressed 1}');
    });

    test('DownButton pressed', () {
      const searchtext = ReviewsDownButtonPressed(
        downbutton: 1,
        contractorid: '',
        reviewerid: '',
        reviewid: '',
        downbuttonClicked: true,
      );

      expect(searchtext.toString(), 'ReviewsDownButtonPressed 1}');
    });
  });
}
