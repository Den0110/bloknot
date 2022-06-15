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
    ref.read(authProvider).isSignedIn().then((signed) {
      Navigator.pushNamedAndRemoveUntil(context, signed ? '/todo' : '/login', (route) => true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Icon(
          Icons.note,
          size: 150,
          color: Colors.red,
        ),
      ),
    );
  }
}
