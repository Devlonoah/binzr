import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/presentation/bloc/passcode/passcode_form_cubit.dart';
import 'package:equatable/equatable.dart';

part 'import_field_state.dart';

class ImportFieldCubit extends Cubit<ValidationState> {
  ImportFieldCubit() : super(InvalidState(''));

  void inputChanged(String value) {
    print(value);
    emit(ValidState(value));
  }
}
