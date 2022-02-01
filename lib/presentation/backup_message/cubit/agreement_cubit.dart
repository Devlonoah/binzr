import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'agreement_state.dart';

class AgreementCubit extends Cubit<AgreementState> {
  AgreementCubit() : super(const AgreementState(false));

  void updateCondition(bool value) {
    emit(AgreementState(value));
  }
}
