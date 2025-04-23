import 'package:devotions_app/pages/authentication/blocs/login/login_bloc.dart';
import 'package:devotions_app/pages/authentication/blocs/login/cubit/login_form_cubit.dart';
import 'package:devotions_app/shared/repositories/devotions_repository.dart';
import 'package:devotions_app/shared/repositories/devotions_repository_impl.dart';
import 'package:devotions_app/shared/datasources/devotions_remote_data_source.dart';
import 'package:devotions_app/shared/datasources/devotions_remote_data_source_impl.dart';
import 'package:devotions_app/shared/blocs/token_bloc/token_bloc.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_repository/authentication_repository.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_repository/authentication_repository_impl.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_provider/authentication_provider.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_provider/authentication_provider_impl.dart';
import 'package:devotions_app/shared/repositories/activity_note_repository.dart';
import 'package:devotions_app/shared/repositories/activity_note_repository_impl.dart';
import 'package:devotions_app/shared/datasources/activity_note_remote_data_source_impl.dart';
import 'package:devotions_app/routing/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:lyvepulse_components/blocs/device_type_cubit.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Provide the repository implementation with real data source
        RepositoryProvider<DevotionsRepository>(
          create:
              (context) => DevotionsRepositoryImpl(
                remoteDataSource: DevotionsRemoteDataSourceImpl(
                  client: http.Client(),
                ),
              ),
        ),
        // Add AuthenticationProvider
        RepositoryProvider<AuthenticationProvider>(
          create:
              (context) => AuthenticationProviderImpl(client: http.Client()),
        ),
        // Add AuthenticationRepository provider
        RepositoryProvider<AuthenticationRepository>(
          create:
              (context) => AuthenticationRepositoryImpl(
                provider: context.read<AuthenticationProvider>(),
              ),
        ),
        // Add ActivityNoteRepository provider
        RepositoryProvider<ActivityNoteRepository>(
          create: (context) => ActivityNoteRepositoryImpl(
            ActivityNoteRemoteDataSourceImpl(http.Client()),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DeviceTypeCubit>(create: (context) => DeviceTypeCubit()),
          // Add TokenCubit
          BlocProvider<TokenCubit>(create: (context) => TokenCubit()),
          // Add LoginBloc
          BlocProvider<LoginBloc>(
            create:
                (context) => LoginBloc(
                  authenticationRepository:
                      context.read<AuthenticationRepository>(),
                  tokenCubit: context.read<TokenCubit>(),
                  auth: LocalAuthentication(),
                ),
          ),
          // Add LoginFormCubit
          BlocProvider<LoginFormCubit>(
            create:
                (context) =>
                    LoginFormCubit(loginBloc: context.read<LoginBloc>()),
          ),
        ],
        child: MaterialApp.router(
          title: 'Devotions App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: Routes.router,
        ),
      ),
    );
  }
}

// A mock implementation of DevotionsRemoteDataSource for demo purposes
class MockDevotionsRemoteDataSource implements DevotionsRemoteDataSource {
  // Implement all required methods with mock data
  @override
  dynamic noSuchMethod(Invocation invocation) {
    // Return mock data for any method call
    return Future.value([]);
  }
}
