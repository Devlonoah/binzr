import 'package:crypto_wallet/constant.dart';
import 'package:crypto_wallet/presentation/bloc/import_field/import_field_cubit.dart';
import 'package:crypto_wallet/presentation/global_widgets/reusable_button.dart';
import 'package:crypto_wallet/presentation/global_widgets/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivateKeyImportWidget extends StatelessWidget {
  const PrivateKeyImportWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kkHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Private key',
              onChanged: (x) =>
                  context.read<ImportFieldCubit>().inputChanged(x),
            ),
            const SizedBox(height: 35),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ReusableButton(
              label: 'IMPORT',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

const subtitle = "Typically 64 alphanumeric characters";
