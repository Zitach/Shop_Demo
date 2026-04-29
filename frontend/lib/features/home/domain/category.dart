import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String iconUrl;
  final bool isNew;

  const Category({
    required this.id,
    required this.name,
    required this.iconUrl,
    this.isNew = false,
  });

  @override
  List<Object?> get props => [id, name, iconUrl, isNew];
}
