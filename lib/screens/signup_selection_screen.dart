import 'package:flutter/material.dart';
import 'manual_signup_screen.dart';
import '../services/google_auth_service.dart';
import 'user_details_screen.dart';

class SignupSelectionScreen extends StatelessWidget {
  const SignupSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final user = await GoogleAuthService().signInWithGoogle();
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserDetailsScreen(user: user),
                      ),
                    );
                  }
                },
                child: const Text("Continue with Google"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ManualSignupScreen(),
                    ),
                  );
                },
                child: const Text("Sign up Manually"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
