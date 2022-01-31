part of 'passcode_form_cubit.dart';

///Describes the current state of a FormBloc or FieldBloc
///
///Validation is tracked though class type and data is
///carried as a member.
abstract class ValidationState<T> {
  final T data;

  ValidationState(this.data);
}

class InitialState<T> extends ValidationState<T> {
  InitialState(data) : super(data);

  @override
  String toString() => 'Initial';
}

class InvalidState<T> extends ValidationState<T> {
  InvalidState(data) : super(data);

  @override
  String toString() => 'Invalid';
}

class ValidState<T> extends ValidationState<T> {
  ValidState(data) : super(data);

  @override
  String toString() => 'Valid';
}
