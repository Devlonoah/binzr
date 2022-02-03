part of 'configure_cubit.dart';

abstract class ConfigureState extends Equatable {
  const ConfigureState();

  @override
  List<Object> get props => [];
}

class ConfigureInitial extends ConfigureState {}

class ConfigureLoading extends ConfigureState {}

class ConfigureSuccess extends ConfigureState {}

class ConfigureStateFailure extends ConfigureState {}
