import 'package:bloc/bloc.dart';
import 'passcode_form_cubit.dart';

part 'passcode_state.dart';

class PasscodeCubit extends Cubit<ValidationState> {
  PasscodeCubit() : super(InitialState(["-", "-", "-", "-", "-"]));

  void updateValue(String value) {
    var presentState = (state.data as List<String>);
    if (presentState.contains("-")) {
      var currentValue = presentState;

      var index = currentValue.indexWhere((element) => element == "-");

      currentValue[index] = value;

      if (presentState.contains('-')) {
        emit(InvalidState(currentValue));
      } else {
        emit(ValidState(currentValue));
      }
    }

    emit(state);
  }

  void clearValue() {
    var currentValue = (state.data as List<String>);
    var index = currentValue.lastIndexWhere((element) => element != "-");

    currentValue[index] = "-";

    if (currentValue.contains('-')) {
      emit(InvalidState(currentValue));
    }
    emit(ValidState(currentValue));
  }
}
