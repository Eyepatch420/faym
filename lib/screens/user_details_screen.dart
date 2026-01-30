import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Details")),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(20),
          child: ListView(
            children: [
              Text("Signup Type: ${user.signupType}"),
              Text("Full Name: ${user.fullName}"),
              if (user.username != null)
                Text("Username: ${user.username}"),
              if (user.email != null)
                Text("Email: ${user.email}"),
              if (user.dob.isNotEmpty)
                Text("DOB: ${user.dob}"),
              if (user.gender.isNotEmpty)
                Text("Gender: ${user.gender}"),
              if (user.instagram.isNotEmpty)
                Text("Instagram: ${user.instagram}"),
              if (user.youtube.isNotEmpty)
                Text("YouTube: ${user.youtube}"),
            ],
          ),
        ),
      ),
    );
  }
}
