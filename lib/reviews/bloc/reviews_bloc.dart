import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';
import 'package:rate_my_contractor/reviews/domain/reviews_repository.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewsRepository repository;

  ReviewsBloc(this.repository)
      : super(
          const ReviewsState(),
        ) {
    on<ReviewsRequest>((event, emit) async {
      //print('this is $event.contractorId');
      try {
        emit(state.copyWith(status: ReviewsStateStatus.loading));
        final reviews =
            await repository.getReviews(event.contractorId); //state.query
        emit(
          state.copyWith(
            reviews: reviews,
            status: ReviewsStateStatus.success,
          ),
        );
      } catch (error) {
        emit(
          state.copyWith(
            errormsg: '$error',
            status: ReviewsStateStatus.failure,
          ),
        );
      }
    });

    on<ReviewsFormButtonPressed>((event, emit) async {
      try {
        await repository.createReview(
          event.contractorid,
          event.reviewerid,
          state.rating,
          state.comment,
          state.upvote,
          state.downvote,
          event.username,
        );
        emit(state.copyWith(status: ReviewsStateStatus.passed));
        emit(state.copyWith(status: ReviewsStateStatus.loading));
        final reviews = await repository.getReviews(event.contractorid);
        emit(
          state.copyWith(reviews: reviews, status: ReviewsStateStatus.success),
        );
      } catch (error) {
        emit(
          state.copyWith(
            errormsg: '$error',
            status: ReviewsStateStatus.unpassed,
          ),
        );
      }
    });

    on<ReviewsCommentChanged>((event, emit) async {
      try {
        emit(state.copyWith(comment: event.comment));
      } catch (error) {
        emit(
          state.copyWith(
            errormsg: '$error',
            status: ReviewsStateStatus.invalid,
          ),
        );
      }
    });

    on<ReviewsStarsPressed>((event, emit) async {
      try {
        emit(
          state.copyWith(
            rating: event.starRating,
            status: ReviewsStateStatus.valid,
          ),
        );
      } catch (error) {
        emit(
          state.copyWith(
            errormsg: '$error',
            status: ReviewsStateStatus.invalid,
          ),
        );
      }
    });
  }
}
