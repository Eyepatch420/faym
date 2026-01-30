import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserModel?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) return null;

      return UserModel(
        fullName: account.displayName ?? "",
        email: account.email,
        dob: "",
        gender: "",
        instagram: "",
        youtube: "",
        signupType: "Google",
      );
    } catch (e) {
      print("Google Sign-in error: $e");
      return null;
    }
  }
}
