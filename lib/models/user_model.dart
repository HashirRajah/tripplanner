class UserModel {
  String uid;
  String username;
  String email;
  String photoURL;
  //
  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.photoURL,
  });
  //
  static Map<String, dynamic> getUserSchema() {
    return {
      'preferences': [],
      'trips': [],
      'liked_destinations': [],
      'liked_POIs': [],
      'connections': [],
    };
  }
}
