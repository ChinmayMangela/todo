

class EndUser {
  String id;
  final String email;

  EndUser({required this.id, required this.email});

  factory EndUser.fromJson(Map<String, dynamic> json, String id) {
    return EndUser(
      id: id,
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }

}