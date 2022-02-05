part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final BalanceModel balanceModel;

  const HomeLoaded(this.balanceModel);
}

class HomeFailed extends HomeState {
  final String errorMessage;

  const HomeFailed({required this.errorMessage});
}
