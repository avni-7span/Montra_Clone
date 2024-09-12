import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/routes/router/router.dart';
import 'package:montra_clone/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // final authenticationRepository = AuthenticationRepository();
  runApp(App(
      // authenticationRepository: authenticationRepository,
      ));
}

class App extends StatelessWidget {
  App({
    super.key,
    // required AuthenticationRepository authenticationRepository
  });
  // : _authenticationRepository = authenticationRepository;

  final _router = AppRouter();
  // final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: MaterialApp.router(
        routerConfig: _router.config(),
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(fontFamily: 'Inter'),
      ),
    );
  }
}
