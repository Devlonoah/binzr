import 'package:crypto_wallet/injection.dart';
import 'package:crypto_wallet/presentation/bloc/user_exist/user_exist_cubit.dart';
import 'package:crypto_wallet/presentation/global_widgets/custom_loading_widget.dart';
import 'package:crypto_wallet/presentation/home/home.dart';
import 'package:crypto_wallet/presentation/launch/launch_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStart extends StatelessWidget {
  static String id = "AppStart";
  const AppStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AppStartBody());
  }
}

class AppStartBody extends StatefulWidget {
  const AppStartBody({Key? key}) : super(key: key);

  @override
  State<AppStartBody> createState() => _AppStartBodyState();
}

class _AppStartBodyState extends State<AppStartBody> {
  late UserExistCubit userExistCubit;

  @override
  void initState() {
    super.initState();

    userExistCubit = getIt<UserExistCubit>()..checkUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserExistCubit, UserExistState>(
      bloc: userExistCubit,
      listener: (context, state) {
        if (state is UserNotFound) {
          _navigateToLaunch(context);
        }

        if (state is UserExist) {
// navigate to Home

          _navigateToHome(context);
        }
      },
      builder: (context, state) {
        return _loadingWidget();
      },
    );
  }

  Center _loadingWidget() {
    return const Center(
      child: CustomLoadingWidget(),
    );
  }

  void _navigateToLaunch(BuildContext context) =>
      Navigator.pushNamed(context, LaunchPage.id);
}

void _navigateToHome(BuildContext context) =>
    Navigator.pushNamed(context, HomePage.id);


//** ----check if wallet exist / has been created

//** ------how-------
//* states----
//* 1. loading
//----check configuration isSetupDone
//* 2 . true- WalletExist || false - WalletNotExist