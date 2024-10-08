class User {
  final String id;
  final String email;
  late final String firstName;
  late final String lastName;
  late final String? isEmployee; // Nullable since `isEmployee` may be optional
  final String? token; // Token can also be optional

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.isEmployee,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '', // Provide a default empty string if id is missing
      email: json['email'] ?? '', // Similarly for email
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      isEmployee: json['isEmployee'], // Nullable field, no need for a default value
      token: json['token'], // Nullable field, no need for a default value
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isEmployee': isEmployee,
    };
  }
}
