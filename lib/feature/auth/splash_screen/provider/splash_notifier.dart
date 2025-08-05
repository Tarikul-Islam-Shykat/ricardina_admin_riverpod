import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ricardina_admin_riverpod/feature/auth/login/ui/login_ui.dart';

class SplashNotifier extends StateNotifier<void> {
  final BuildContext context;

  SplashNotifier(this.context) : super(null) {
    _init();
  }

  Future<void> _init() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
}

// provider
final splashProvider = Provider.family<void, BuildContext>((ref, context) {
  SplashNotifier(context);
});

/*
.family Provider here?

Provider.family lets you pass parameters to the provider at read time.
  In this case, you need to pass the BuildContext into the notifier (to do navigation).
  StateNotifierProvider does not support passing parameters directly when you read it.

When you do ref.read(splashProvider(context)), you provide the BuildContext needed for navigation.
The provider creates a new SplashNotifier instance with that context.

StateNotifierProvider is designed to create and manage a state notifier instance, 
expose its state, and manage lifecycle.


*/
