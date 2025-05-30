class friendModel {
  final String userId;
  String userName;
  String userEmail;
  String? profilePicture;
  String? bio;

  friendModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.profilePicture,
    this.bio,
  });
}
