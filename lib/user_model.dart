class User {
  int exp;
  List<int> roles;
  String studentCode;
  int userId;

  User({required this.exp, required this.roles, required this.studentCode, required this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      exp: json['exp'] as int,
      roles: List<int>.from(json['roles'] as List<dynamic>),
      studentCode: json['studentCode'] as String,
      userId: json['userId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exp'] = exp;
    data['roles'] = roles;
    data['studentCode'] = studentCode;
    data['userId'] = userId;
    return data;
  }
}