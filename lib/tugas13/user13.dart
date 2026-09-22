class User13 {
  final int? id;
  final String name;
  final String email;
  final String phone;

  User13({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory User13.fromMap(Map<String, dynamic> map) {
    return User13(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}