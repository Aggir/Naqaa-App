import 'package:equatable/equatable.dart';

class Gender extends Equatable {
  final String id;
  final String name;
  const Gender({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
