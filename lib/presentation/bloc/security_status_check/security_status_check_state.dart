part of 'security_status_check_cubit.dart';

abstract class SecurityStatusCheckState extends Equatable {
  const SecurityStatusCheckState();

  @override
  List<Object> get props => [];
}

class SecurityStatusCheckInitial extends SecurityStatusCheckState {}

class SecurityStatusCheckLoading extends SecurityStatusCheckState {}

class NotSecuredState extends SecurityStatusCheckState {}

class SecuredState extends SecurityStatusCheckState {}
