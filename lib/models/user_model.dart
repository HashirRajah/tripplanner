class UserModel {
  String uid;
  String username;
  String email;
  String? photoURL;
  //
  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.photoURL,
  });
  //
  Map<String, dynamic> getUserSchema() {
    return {
      'email': email,
      'username': username,
      'photo_url': photoURL,
      'preferences': [],
      'trips': [],
      'liked_destinations': [],
      'liked_POIs': [],
      'connections': [],
      'invitations': [],
    };
  }
}
