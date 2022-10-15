class UserModel {
  String? uid;
  String? name;
  String? email;
  String? profile;
  int?dateTime;
  UserModel({this.uid, this.name, this.email, this.profile,this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profile': profile,
      'dateTime': dateTime,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profile: map['profile'] as String,
      dateTime: map['profile'] as int,
    );
  }
}