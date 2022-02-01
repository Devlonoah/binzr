part of 'verify_phrase_cubit.dart';

class VerifyPhraseState extends Equatable {
  VerifyPhraseState(
      {this.passedPhrase,
      this.shuffledPhrase,
      this.selectedPhrase,
      this.isMatched = false});

  List<String>? passedPhrase;

  List<String>? shuffledPhrase;
  List<String>? selectedPhrase;

  bool? isMatched;

  // static VerifyPhraseState initialState() {
  //   return VerifyPhraseState(
  //     passedPhrase: []..length = 12,
  //     shuffledPhrase: []..length = 12,
  //     selectedPhrase: []..length = 12,
  //     isMatched: false,
  //   );
  // }

  copyWith(
      {List<String>? passedPhrase,
      List<String>? shuffledPhrase,
      List<String>? selectedPhrase,
      bool? isMatched}) {
    return VerifyPhraseState(
        passedPhrase: passedPhrase ?? this.passedPhrase,
        shuffledPhrase: shuffledPhrase ?? this.shuffledPhrase,
        selectedPhrase: selectedPhrase ?? this.selectedPhrase,
        isMatched: isMatched ?? this.isMatched);
  }

  @override
  List<Object> get props => [selectedPhrase!];
}
