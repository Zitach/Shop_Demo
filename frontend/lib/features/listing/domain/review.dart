import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String userName;
  final String userAvatarUrl;
  final int rating;
  final String comment;
  final DateTime date;

  const Review({
    required this.id,
    required this.userName,
    required this.userAvatarUrl,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  List<Object?> get props => [id, userName, rating, comment, date];
}
