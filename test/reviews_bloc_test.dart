import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rate_my_contractor/reviews/bloc/reviews_bloc.dart';
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
