class Userlistmodel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? isEmployee; // Nullable field
  final String? token; // Nullable field
  final String? type; // Nullable field for user type
  final String? imageUrl; // Nullable field for image URL
  final String? phone; // Nullable field for phone number
  final List<String>? privileges; // Nullable field for privileges
  final List<String>? platforms; // Array of strings for platforms
  final DateTime? createdAt; // Nullable field for creation date

  Userlistmodel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.isEmployee,
    this.token,
    this.type,
    this.imageUrl,
    this.phone,
    this.privileges,
    this.platforms,
    this.createdAt,
  });

  // Add the copyWith method
  Userlistmodel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? isEmployee,
    String? token,
    String? type,
    String? imageUrl,
    String? phone,
    List<String>? privileges,
    List<String>? platforms,
    DateTime? createdAt,
  }) {
    return Userlistmodel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isEmployee: isEmployee ?? this.isEmployee,
      token: token ?? this.token,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      phone: phone ?? this.phone,
      privileges: privileges ?? this.privileges,
      platforms: platforms ?? this.platforms,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Userlistmodel.fromJson(Map<String, dynamic> json) {
    return Userlistmodel(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      isEmployee: json['isEmployee'],
      token: json['token'],
      type: json['type'],
      imageUrl: json['imageUrl'],
      phone: json['phone'],
      privileges: json['privileges'] != null 
          ? List<String>.from(json['privileges']) 
          : null, // Convert to List<String> if not null
      platforms: json['platforms'] != null 
          ? List<String>.from(json['platforms']) 
          : null, // Convert to List<String> if not null
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null, // Parse DateTime if not null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isEmployee': isEmployee,
      'token': token,
      'type': type,
      'imageUrl': imageUrl,
      'phone': phone,
      'privileges': privileges,
      'platforms': platforms,
      'createdAt': createdAt?.toIso8601String(), // Convert DateTime to String
    };
  }
}
