import 'package:equatable/equatable.dart';

class Amenity extends Equatable {
  final String id;
  final String name;
  final String iconKey;

  const Amenity({required this.id, required this.name, required this.iconKey});

  @override
  List<Object?> get props => [id, name, iconKey];
}
