import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../models/user_model.dart';
import 'user_details_screen.dart';

class ManualSignupScreen extends StatefulWidget {
  const ManualSignupScreen({super.key});

  @override
  State<ManualSignupScreen> createState() => _ManualSignupScreenState();
}

class _ManualSignupScreenState extends State<ManualSignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final instagramController = TextEditingController();
  final youtubeController = TextEditingController();

  DateTime? selectedDOB;
  String? gender;

  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      initialDate: DateTime(2000),
    );

    if (date != null) {
      setState(() => selectedDOB = date);
    }
  }

  bool isAgeValid(DateTime dob) {
    int age = DateTime.now().difference(dob).inDays ~/ 365;
    return age >= 13;
  }

  bool isFormValid() {
    return fullNameController.text.isNotEmpty &&
        usernameController.text.length >= 3 &&
        selectedDOB != null &&
        gender != null &&
        instagramController.text.isNotEmpty &&
        youtubeController.text.isNotEmpty;
  }

  void submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedDOB == null || !isAgeValid(selectedDOB!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User must be 13+ years old")),
      );
      return;
    }

    final user = UserModel(
      fullName: fullNameController.text,
      username: usernameController.text,
      dob: DateFormat('yyyy-MM-dd').format(selectedDOB!),
      gender: gender!,
      instagram: instagramController.text,
      youtube: youtubeController.text,
      signupType: "Manual",
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserDetailsScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manual Signup")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (_) => setState(() {}),
                validator: (v) =>
                v!.isEmpty ? "Full name cannot be empty" : null,
              ),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                onChanged: (_) => setState(() {}),
                validator: (v) =>
                v!.length < 3 ? "Minimum 3 characters required" : null,
              ),
              ListTile(
                title: Text(selectedDOB == null
                    ? "Select DOB"
                    : DateFormat('yyyy-MM-dd').format(selectedDOB!)),
                trailing: const Icon(Icons.calendar_today),
                onTap: pickDate,
              ),
              DropdownButtonFormField<String>(
                hint: const Text("Select Gender"),
                value: gender,
                items: ["Male", "Female", "Other"]
                    .map((e) =>
                    DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) {
                  setState(() => gender = v);
                },
                validator: (v) => v == null ? "Gender required" : null,
              ),
              TextFormField(
                controller: instagramController,
                decoration: const InputDecoration(
                  labelText: "Instagram Username",
                  prefixIcon: Icon(Icons.camera_alt),
                ),
                onChanged: (_) => setState(() {}),
                validator: (v) =>
                v!.isEmpty ? "Instagram required" : null,
              ),
              TextFormField(
                controller: youtubeController,
                decoration: const InputDecoration(
                  labelText: "YouTube Username",
                  prefixIcon: Icon(Icons.video_call),
                ),
                onChanged: (_) => setState(() {}),
                validator: (v) =>
                v!.isEmpty ? "YouTube required" : null,
              ),
              const SizedBox(height: 30),
              SlideAction(
                text: "Swipe to Submit",
                outerColor: Colors.blue,
                innerColor: Colors.white,
                enabled: isFormValid(),
                onSubmit: () async{
                  await Future.delayed(const Duration(seconds: 1));
                  submitForm();
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
