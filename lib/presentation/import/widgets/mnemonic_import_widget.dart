import 'package:crypto_wallet/presentation/bloc/configure/configure_cubit.dart';
import 'package:crypto_wallet/presentation/global_widgets/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../constant.dart';

class MnemonicImportWidget extends StatelessWidget {
  const MnemonicImportWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfigureCubit, ConfigureState>(
      listener: (context, state) {
        if (state is ConfigureStateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to import wallet')));
        }
      },
      builder: (context, state) {
        return LoadingOverlay(
          isLoading: state is ConfigureLoading,
          progressIndicator: const CustomLoadingWidget(),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kkHorizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Mnemonics',
                    onChanged: (x) => print(x),
                    hintText: _hintText,
                  ),
                  const SizedBox(height: 35),
                  Text(
                    _subtitle,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ReusableButton(
                    label: 'IMPORT',
                    onPressed: () {
                      context.read<ConfigureCubit>().setupMnemonicImport();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

const _hintText = "Enter recovery phrase";

const _subtitle =
    "Typically 12 (sometimes 24) words separated by single spaces.";
