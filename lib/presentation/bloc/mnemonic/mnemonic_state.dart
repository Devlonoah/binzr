part of 'mnemonic_cubit.dart';

class MnemonicState extends Equatable {
  MnemonicState({this.isCopied, this.mnemonics});

  List<String>? mnemonics;
  bool? isCopied;

  static initialState() {
    return MnemonicState(
      mnemonics: const [],
      isCopied: false,
    );
  }

  MnemonicState copyWith({List<String>? mnemonics, bool? isCopied}) {
    return MnemonicState(
      mnemonics: mnemonics ?? this.mnemonics,
      isCopied: isCopied ?? this.isCopied,
    );
  }

  @override
  List<Object> get props => [mnemonics!, isCopied!];
}
