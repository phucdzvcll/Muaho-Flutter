import 'package:equatable/equatable.dart';

class CreateAddressResult extends Equatable {
  final Status status;

  const CreateAddressResult({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}

enum Status { Success, Fail }
