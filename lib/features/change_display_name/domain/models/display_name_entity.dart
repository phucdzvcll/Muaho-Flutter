import 'package:equatable/equatable.dart';

class DisplayNameEntity extends Equatable {
  final String displayName;

  const DisplayNameEntity({
    required this.displayName,
  });

  @override
  List<Object?> get props => [displayName];
}
