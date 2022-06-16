import 'package:bloknot/navigation/routes.dart';
import 'package:bloknot/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    ref.read(authProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final authState = ref.watch(authStateProvider);
          if (authState == AuthState.signedIn) {
            Future.delayed(Duration.zero,
                () => Navigator.pushReplacementNamed(context, Routes.todo));
          } else if (authState == AuthState.signedOut) {
            Future.delayed(Duration.zero,
                () => Navigator.pushReplacementNamed(context, Routes.login));
          }
          return const Center(
            child: Icon(
              Icons.note,
              size: 150,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
