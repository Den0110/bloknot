import 'package:bloknot/constants/colors.dart';
import 'package:bloknot/providers/auth_provider.dart';
import 'package:bloknot/widgets/bloknot_button.dart';
import 'package:bloknot/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String email = '';
  String password = '';

  _onLoginPressed() {
    ref
        .read(authProvider)
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((_) {
      Navigator.pushReplacementNamed(context, '/todo');
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width * 0.8,
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final authState = ref.watch(authStateProvider);
              if(authState == AuthState.loading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.red));
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Войти",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextInput(
                      icon: Icons.email,
                      hint: 'Email',
                      onChanged: (s) {
                        setState(() {
                          email = s.trim();
                        });
                      },
                    ),
                    TextInput(
                      icon: Icons.email,
                      hint: 'Пароль',
                      onChanged: (s) {
                        setState(() {
                          password = s.trim();
                        });
                      },
                      obscuringEnabled: true,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: BloknotButton(
                        text: 'Войти',
                        onPressed: _onLoginPressed,
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
