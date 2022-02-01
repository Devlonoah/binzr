import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:collection';

import 'package:flutter/foundation.dart';
part 'verify_phrase_state.dart';

class VerifyPhraseCubit extends Cubit<VerifyPhraseState> {
  VerifyPhraseCubit(List<String> passedPhrase)
      : super(VerifyPhraseState(
            passedPhrase: passedPhrase,
            selectedPhrase: const [],
            shuffledPhrase: List.from(passedPhrase)..shuffle()));

  void phraseSelected(String phrase) {
    var selectedArray = state.selectedPhrase?.toList();
    selectedArray?.add(phrase);
    List<String>? shuffleArray = [];
    for (var sel in selectedArray!) {
      shuffleArray = state.shuffledPhrase?.where((e) {
        return e != sel;
      }).toList();
    }

    var _isMatched = listEquals(selectedArray, state.passedPhrase);
    emit(state.copyWith(
      selectedPhrase: selectedArray,
      shuffledPhrase: shuffleArray,
      isMatched: _isMatched,
    ));

    print("selected phrase is ${state.selectedPhrase}");
    print('');
    print('passed phrase: ${state.passedPhrase}');
    print('is matched ? $_isMatched');
    // state.copyWith(selectedPhrase: );

    // print(state.selectedPhrase);

    // final updatedSelectedPhrases = state.selectedPhrase?..add(phrase);
    // print('updated selected phrases :n$updatedSelectedPhrases');
    // state.shuffledPhrase?.remove(phrase);

    // var updatedState = state.copyWith(selectedPhrase: updatedSelectedPhrases);
  }
}
