import 'package:rate_my_contractor/contractor_list/domain/models/contractor.dart';
import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/reviews/domain/reviews_repository.dart';
part 'reviews_state.dart';
part 'reviews_event.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewsRepository repository;

  ReviewsBloc(this.repository)
      : super(const ReviewsState(
          contractorId: '',
          errormsg: '',
          reviews: [],
          status: ReviewsStateStatus.initial,
        )) {
    on<ReviewsRequest>((event, emit) async {
      //print('this is $event.contractorId');
      try {
        emit(state.copyWith(status: ReviewsStateStatus.loading));
        final reviews =
            await repository.getReviews(event.contractorId); //state.query
        emit(state.copyWith(
            reviews: reviews, status: ReviewsStateStatus.success));
      } catch (error) {
        emit(state.copyWith(
            errormsg: '$error', status: ReviewsStateStatus.failure));
      }
    });

    on<ReviewsFormButtonPressed>((event, emit) async {
      try {
        await repository.createReview(
          state.contractorId,
          state.reviewerId,
          state.rating,
          state.comment,
          state.upvote,
          state.downvote,
        );
        emit(state.copyWith(status: ReviewsStateStatus.success));
      } catch (error) {
        emit(state.copyWith(
            errormsg: '$error', status: ReviewsStateStatus.failure));
      }
    });
  }
}
