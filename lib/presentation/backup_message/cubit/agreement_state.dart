part of 'agreement_cubit.dart';

class AgreementState extends Equatable {
  const AgreementState(
    this.isAddedToService,
  );

  final bool isAddedToService;

  @override
  List<Object> get props => [isAddedToService];
}
