import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
// import 'package:device_info/device_info.dart';
import 'package:equatable/equatable.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';
import 'package:devotions_app/shared/models/authentication/login_dto.dart';
import 'package:devotions_app/shared/models/authentication/user_profile.dart';
import 'package:devotions_app/shared/models/branch_configs.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_repository/authentication_repository.dart';
import 'package:local_auth/local_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;
  final TokenCubit tokenCubit;
  final LocalAuthentication auth;

  LoginBloc({
    required this.authenticationRepository,
    required this.tokenCubit,
    required this.auth,
  }) : super(LoginInitial()) {
    on<LoginSubmitted>(_loginSubmitted);
    on<BiometricLogin>(_biometricLogin);
    on<LogoutUserEvent>((event, emit) async {
      // emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 10));
      log('Logout user');
      emit(LoginInitial());
    });
  }

  Future<void> _loginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());
      final result = await authenticationRepository.loginUser(
        LoginDto(username: event.email, password: event.password),
      );

      result.fold(
        (failure) {
          emit(LoginFailure(errorMessage: failure.message));
          // if (msg.contains("2fa_code_sent")) {
          //   _handleLoginResponse(emit);
          // } else {

          // }
        },
        (loginResponse) async {
          if (loginResponse != null) {
            authenticationRepository.saveToken(loginResponse);
            //TODO add Branch Bloc and set bloc data

            if (loginResponse.accessTicket.roles.isEmpty) return;
            String orgId =
                loginResponse.accessTicket.roles.first.organisationalId;

            String branchId = loginResponse.accessTicket.roles.first.branchId;
            tokenCubit.saveToken(
              loginResponse.token,
              branchId,
              int.parse(orgId),
              loginResponse.accessTicket.firstName,
              loginResponse.accessTicket,
            );
            BranchConfigs.initialize(orgId: orgId, brnchId: branchId);

            emit(const LoginSuccess(userProfile: null));
            // _handleLoginResponse(emit);
          } else {
            emit(const LoginFailure(errorMessage: "Invalid login credentials"));
          }
        },
      );
    } catch (e) {
      emit(LoginFailure(errorMessage: "Unexpected error: ${e.toString()}"));
    }
  }

  Future<void> _handleLoginResponse(Emitter<LoginState> emit) async {
    final result = await authenticationRepository.getUserProfile();
    result.fold(
      (failure) {
        emit(LoginFailure(errorMessage: failure.message));
      },
      (userProfile) {
        if (!_shouldLogin(userProfile)) {
          emit(
            const LoginFailure(
              errorMessage:
                  "This account is dissabled or locked, Contact your administrator to re-enable your account",
            ),
          );
        } else {
          emit(LoginSuccess(userProfile: userProfile));
        }
      },
    );
  }

  bool _shouldLogin(UserProfile userProfile) {
    final isLocked = userProfile.isLocked == "true";
    if (isLocked || userProfile.deletedAt != null) {
      return false;
    }
    return true;
  }

  Future<void> _biometricLogin(
    BiometricLogin event,
    Emitter<LoginState> emit,
  ) async {
    // return null;
    emit(LoginLoading());
    try {
      // Trigger the biometric authentication prompt
      bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        final deviceId = await deviceIdGenerator(); // Now defined
        emit(const LoginSuccess());
      } else {
        emit(const LoginFailure(errorMessage: 'Authentication failed'));
      }
    } catch (e) {
      print(e);
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }

  Future<String> deviceIdGenerator() async {
    // final deviceInfo = await DeviceInfoPlugin().androidInfo;
    // final macAddress = deviceInfo.id;
    const userDetails =
        'username@example.com'; // Replace with actual user details
    final combinedString = DateTime.now().toString() + userDetails;
    final bytes = utf8.encode(combinedString);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
