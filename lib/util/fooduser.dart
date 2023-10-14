class FoodUsers {
  final String id;
  final String name;
  final String password;
  final String email;
  final String phone;
  final String date;

  FoodUsers({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'password': password,
        'email': email,
        'phone': phone,
        'date': date,
      };

  static FoodUsers fromJson(Map<String, dynamic> json) => FoodUsers(
        id: json['id'],
        name: json['name'],
        password: json['password'],
        email: json['email'],
        phone: json['phone'],
        date: json['date'],
      );
}
