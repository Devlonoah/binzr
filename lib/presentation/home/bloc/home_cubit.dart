import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:crypto_wallet/models/balance_model.dart';
import 'package:crypto_wallet/repository/remote_wallet_access.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.remoteWalletAccess,
  ) : super(HomeInitial());

  final RemoteWalletAccess remoteWalletAccess;
  void getBalance() async {
    try {
      emit(HomeLoading());
      var result = await remoteWalletAccess.getBalance();

      emit(HomeLoaded(result));
    } on SocketException {
      emit(const HomeFailed(errorMessage: 'Check your connection'));
    } catch (e) {
      emit(const HomeFailed(errorMessage: 'Error occured'));
    }
  }
}
