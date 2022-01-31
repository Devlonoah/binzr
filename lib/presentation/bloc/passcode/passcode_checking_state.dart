part of 'passcode_checking_cubit.dart';

abstract class PasscodeCheckingState extends Equatable {
  const PasscodeCheckingState();

  @override
  List<Object> get props => [];
}

class PasscodeCheckingInitial extends PasscodeCheckingState {}

class PasscodeCheckingProgress extends PasscodeCheckingState {}

class PasscodeMatched extends PasscodeCheckingState {}

class PasscodeNotMatched extends PasscodeCheckingState {}
