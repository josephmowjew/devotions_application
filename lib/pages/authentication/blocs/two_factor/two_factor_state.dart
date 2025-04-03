part of 'two_factor_bloc.dart';

sealed class TwoFactorState extends Equatable {
  const TwoFactorState();

  @override
  List<Object> get props => [];
}

final class TwoFactorInitial extends TwoFactorState {}

final class TwoFactorLoading extends TwoFactorState {}

final class TwoFactorSuccess extends TwoFactorState {}

final class TwoFactorFailure extends TwoFactorState {
  final String errorMessage;
  const TwoFactorFailure({required this.errorMessage});
}
