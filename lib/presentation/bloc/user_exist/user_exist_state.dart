part of 'user_exist_cubit.dart';

abstract class UserExistState extends Equatable {
  const UserExistState();

  @override
  List<Object> get props => [];
}

class UserExistLoading extends UserExistState {}

class UserExist extends UserExistState {}

class UserNotFound extends UserExistState {}
