import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rate_my_contractor/reviews/data/models/reviews_dto.dart';
import 'package:rate_my_contractor/reviews/domain/reviews_repository.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  ReviewsBloc(this.repository)
      : super(
          const ReviewsState(),
        ) {
    on<ReviewsRequest>((event, emit) async {
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
      } on Exception catch (error) {
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
        final url = await repository.uploadImageToSupabase(
          state.baseImg,
          event.reviewerid,
          event.contractorid,
        );
        final imageUrl = [url];
        await repository.createReview(
          event.contractorid,
          event.reviewerid,
          state.rating,
          state.comment,
          state.upvote,
          state.downvote,
          event.username,
          event.usertype,
          imageUrl,
        );
        emit(state.copyWith(status: ReviewsStateStatus.passed));
        emit(state.copyWith(status: ReviewsStateStatus.loading));
        final reviews = await repository.getReviews(event.contractorid);
        emit(
          state.copyWith(reviews: reviews, status: ReviewsStateStatus.success),
        );
      } on Exception catch (error) {
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
      } on Exception catch (error) {
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
      } on Exception catch (error) {
        emit(
          state.copyWith(
            errormsg: '$error',
            status: ReviewsStateStatus.invalid,
          ),
        );
      }
    });

    on<ReviewsDownButtonPressed>((event, emit) async {
      try {
        final updateReviews = state.reviews.map((review) {
          if (review.reviewid == event.reviewid) {
            return review.copyWith(
              downvote: review.downvote + event.downbutton,
              downvoteClicked: event.downbuttonClicked,
              upvoteClicked: false,
            );
          }
          return review;
        }).toList();
        emit(
          state.copyWith(
            reviews: updateReviews,
          ),
        );
        await repository.updateReview(
          event.reviewerid,
          event.contractorid,
          0,
          event.downbutton,
          event.reviewid,
        );
      } on Exception catch (error) {
        emit(
          state.copyWith(
            errormsg: '$error',
            status: ReviewsStateStatus.invalid,
          ),
        );
      }
    });

    on<ReviewsUpButtonPressed>((event, emit) async {
      try {
        final updateReviews = state.reviews.map((review) {
          if (review.reviewid == event.reviewid) {
            return review.copyWith(
              upvote: review.upvote + event.upbutton,
              upvoteClicked: event.upbuttonClicked,
              downvoteClicked: false,
            );
          }
          return review;
        }).toList();

        emit(
          state.copyWith(reviews: updateReviews),
        );
        await repository.updateReview(
          event.reviewerid,
          event.contractorid,
          event.upbutton,
          0,
          event.reviewid,
        );
      } on Exception catch (error) {
        emit(
          state.copyWith(
            errormsg: '$error',
            status: ReviewsStateStatus.invalid,
          ),
        );
      }
    });

    on<ReviewsImagePicked>((event, emit) async {
      try {
        emit(
          state.copyWith(
            baseImg: event.base64String,
            status: ReviewsStateStatus.valid,
          ),
        );
      } on Exception catch (error) {
        emit(
          state.copyWith(
            errormsg: '$error',
            status: ReviewsStateStatus.invalid,
          ),
        );
      }
    });
  }
  final ReviewsRepository repository;
}
