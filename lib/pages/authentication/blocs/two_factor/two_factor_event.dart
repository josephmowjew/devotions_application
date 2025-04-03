part of 'two_factor_bloc.dart';

sealed class TwoFactorEvent extends Equatable {
  const TwoFactorEvent();

  @override
  List<Object> get props => [];
}

class TwoFactorSubmitted extends TwoFactorEvent {
  final String username;
  final String securityCode;
  const TwoFactorSubmitted({required this.username, required this.securityCode});
}
