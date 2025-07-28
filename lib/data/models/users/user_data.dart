

class UserData {
  String? id;
  String? uid;
  String name;
  String userIcon;
  String email;
  String location;
  String dob;


  UserData({
    required this.id,
    required this.uid,
    required this.name,
    required this.userIcon,
    required this.email,
    required this.location,
    required this.dob,

  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'].toString(),
      name: json['name'],
      uid: json['uid'],
      userIcon: json['user_icon'],
      email: json['email'],
      location: json['location'],
      dob: json['dob'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'uid': uid,
      'user_icon': userIcon,
      'email': email,
      'location': location,
      'dob': dob,

    };
  }
}
