import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dns_test/home/domain/task_repository.dart';
import 'package:dns_test/home/ui/home_page.dart';
import 'package:dns_test/login/domain/login_service.dart';
import 'package:dns_test/login/ui/login_page.dart';
import 'package:dns_test/registration/domain/registration_service.dart';
import 'package:dns_test/splash.dart';
import 'package:dns_test/task/domain/task_card_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  final FirebaseAuth _auth;
  final FirebaseFirestore db;
  const App(this._auth, this.db, {super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GlobalKey<NavigatorState> _navigatorKey;
  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    super.initState();
    _navigatorKey = GlobalKey<NavigatorState>();
    widget._auth.authStateChanges().listen(_handleAuth);
    if (widget._auth.currentUser != null) {
      _navigateToHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: _navigatorKey,
      onGenerateRoute: (_) => SplashPage.route(),

      //home: SplashPage(),
      builder: (context, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => RegistrationService(widget._auth),
            ),
            RepositoryProvider(
              create: (context) => LoginRepository(widget._auth),
            ),
            RepositoryProvider(create: (_) => TaskRepository(widget.db)),
            RepositoryProvider(create: (_) => TaskCardRepository(widget.db)),
          ],
          child: child!,
        );
      },
    );
  }

  void _handleAuth(User? user) {
    if (user != null) {
      _navigateToHome();
      log('123');
      return;
    }
    _navigateToLogin();
  }

  Future<void> _navigateToHome() async {
    log('11');
    await _navigator?.pushAndRemoveUntil(HomePage.route(key: UniqueKey()), (route) => false);
  }

  void _navigateToLogin() {
    log('22');
    _navigator?.pushAndRemoveUntil(LoginPage.route(), (route) => false);
  }
}
