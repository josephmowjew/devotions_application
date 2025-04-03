import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:devotions_app/shared/models/authentication/auth_modals.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_repository/authentication_repository.dart';

part 'two_factor_event.dart';
part 'two_factor_state.dart';

class TwoFactorBloc extends Bloc<TwoFactorEvent, TwoFactorState> {
  final AuthenticationRepository authenticationRepository;

  TwoFactorBloc({required this.authenticationRepository})
    : super(TwoFactorInitial()) {
    on<TwoFactorSubmitted>(_submitTwoFactorAuth);
  }

  Future<void> _submitTwoFactorAuth(
    TwoFactorSubmitted event,
    Emitter<TwoFactorState> emit,
  ) async {
    try {
      emit(TwoFactorLoading());
      final result = await authenticationRepository.twoFactorCode(
        TwoFactorDto(
          username: event.username,
          securityCode: event.securityCode,
        ),
      );
      result.fold(
        (failure) {
          emit(TwoFactorFailure(errorMessage: failure.message));
        },
        (success) {
          emit(TwoFactorSuccess());
        },
      );
    } catch (e) {
      emit(TwoFactorFailure(errorMessage: e.toString()));
    }
  }
}
