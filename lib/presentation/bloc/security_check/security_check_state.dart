part of 'security_check_cubit.dart';

class SecurityCheckState extends Equatable {
  const SecurityCheckState({
    this.header,
    this.isSuccess,
    this.isFailed,
    required this.isChecking,
  });

  final String? header;
  final bool? isSuccess;
  final bool? isFailed;
  final bool isChecking;

  static initialState() {
    return const SecurityCheckState(
        header: '', isSuccess: false, isFailed: false, isChecking: false);
  }

  SecurityCheckState copyWith({
    String? header,
    bool? isSuccess,
    bool? isFailed,
    bool? isChecking,
  }) {
    return SecurityCheckState(
      header: header ?? this.header,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
      isChecking: isChecking ?? this.isChecking,
    );
  }

  @override
  List<Object> get props => [
        isSuccess!,
        isFailed!,
        isChecking,
        header!,
      ];
}
