import 'package:bloc/bloc.dart';
import 'package:crypto_wallet/repository/wallet_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_exist_state.dart';

///* Duty -> Check if the app has any wallet setup already
///

class UserExistCubit extends Cubit<UserExistState> {
  UserExistCubit(this.walletRepository) : super(UserExistLoading());

  final IWalletRepository walletRepository;

//check if a walet has been seup
  void checkUserStatus() async {
    final result = await walletRepository.isSetUpDone();

    if (result == true) {
      emit(UserExist());
    } else {
      emit(UserNotFound());
    }
  }
}
