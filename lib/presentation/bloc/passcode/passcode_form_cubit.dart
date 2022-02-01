import 'dart:async';

import 'package:bloc/bloc.dart';

import 'passcode_cubit.dart';

part 'passcode_form_state.dart';

class PasscodeFormCubit extends Cubit<ValidationState> {
  PasscodeFormCubit(
    this.cubit,
  ) : super(InitialState([])) {
    passcodeStream = cubit.stream.listen((event) {
      isFormValid(event);
    });
  }

  final PasscodeCubit cubit;

  late StreamSubscription passcodeStream;

  void isFormValid(ValidationState validation) {
    print("=-=---------$validation");

    emit(ValidState(validation.data));
  }

  @override
  Future<void> close() {
    passcodeStream.cancel();
    return super.close();
  }
}
