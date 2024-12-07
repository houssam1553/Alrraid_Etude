class Command {
  final String status;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Command({
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  // Factory method to create a Command instance from JSON
  factory Command.fromJson(Map<String, dynamic> json) {
    return Command(
      status: json['status'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  // Method to convert a Command instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}
