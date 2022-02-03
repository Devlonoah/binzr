import 'package:crypto_wallet/presentation/bloc/configure/configure_cubit.dart';
import 'package:crypto_wallet/presentation/bloc/import_field/import_field_cubit.dart';
import 'package:crypto_wallet/presentation/import/widgets/src.dart';
import 'package:crypto_wallet/repository/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection.dart';

class ImportWalletPage extends StatefulWidget {
  static String id = "ImportWalletPage";
  const ImportWalletPage({Key? key}) : super(key: key);

  @override
  State<ImportWalletPage> createState() => _ImportWalletPageState();
}

class _ImportWalletPageState extends State<ImportWalletPage> {
  late ImportFieldCubit importFieldCubit;

  late ConfigureCubit configureCubit;

  @override
  void initState() {
    super.initState();

    importFieldCubit = ImportFieldCubit();

    configureCubit = ConfigureCubit(
      walletRepository: getIt<IWalletRepository>(),
      importFieldCubit: importFieldCubit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: importFieldCubit),
        BlocProvider(create: (context) => configureCubit)
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Import Ethereum'),
            // bottom: tabBar(),
          ),
          body: const SafeArea(
            child: ImportWalletPageBody(),
          ),
        ),
      ),
    );
  }
}

class ImportWalletPageBody extends StatelessWidget {
  const ImportWalletPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MnemonicImportWidget();
  }

  // tabBarView() {
  //   return const TabBarView(children: [
  //     PrivateKeyImportWidget(),
  //   ]);
  // }
}

// TabBar tabBar() {
//   return const TabBar(indicatorColor: Colors.red, indicatorWeight: 5, tabs: [
//     Tab(
//       text: 'PrivateKey',
//     ),
//     Tab(
//       text: 'Mnemonic',
//     ),
//   ]);
// }
