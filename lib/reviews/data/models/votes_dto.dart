class VotesDto {
  VotesDto({
    required this.upvote,
    required this.downvote,
  });

  factory VotesDto.fromJson(Map<String, dynamic> json) {
    return VotesDto(
      upvote: json['up_vote'] as int? ?? 0,
      downvote: json['down_vote'] as int? ?? 0,
    );
  }

  final int upvote;
  final int downvote;

  @override
  String toString() => 'VotesDto(upvote $upvote)';
}
