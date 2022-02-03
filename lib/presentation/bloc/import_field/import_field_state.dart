part of 'import_field_cubit.dart';

abstract class ImportFieldState extends Equatable {
  const ImportFieldState();

  @override
  List<Object> get props => [];
}

class ValidatedState extends ImportFieldState {
  final String value;
  const ValidatedState({
    required this.value,
  });
}

class InValidatedState extends ImportFieldState {
  final String value;

  const InValidatedState(this.value);
}
