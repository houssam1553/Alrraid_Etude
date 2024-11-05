class User {
  final String id;
  final String email;
  late final String firstName;
  late final String lastName;
  late final String? isEmployee; 
   final String type; // Nullable since `isEmployee` may be optional
  // Nullable since `isEmployee` may be optional
  final String? token; // Token can also be optional

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.type,
    this.isEmployee,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '', // Provide a default empty string if id is missing
      email: json['email'] ?? '', // Similarly for email
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      isEmployee: json['isEmployee'],
      type: json['type']??'',

       // Nullable field, no need for a default value
      token: json['token'], // Nullable field, no need for a default value
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isEmployee': isEmployee,
      'type':type,

    };
  }
}
