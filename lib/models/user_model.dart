class UserModel {
  String fullName;
  String? email;
  String? username;
  String dob;
  String gender;
  String instagram;
  String youtube;
  String signupType;

  UserModel({
    required this.fullName,
    this.email,
    this.username,
    required this.dob,
    required this.gender,
    required this.instagram,
    required this.youtube,
    required this.signupType,
  });
}
