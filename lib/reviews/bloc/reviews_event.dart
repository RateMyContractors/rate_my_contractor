part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object> get props => [];
}

class ReviewsRequest extends ReviewsEvent {
  const ReviewsRequest({required this.contractorId});

  final String contractorId;
  @override
  List<Object> get props => [contractorId];
  @override
  String toString() => 'Reviews requested {contractorId: $contractorId}';
}

class ReviewsFormButtonPressed extends ReviewsEvent {
  const ReviewsFormButtonPressed();
}
