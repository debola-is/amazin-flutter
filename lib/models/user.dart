import 'dart:convert';

class User {
  final String
      id; //not present in user schema in backend because mongodb creates it automatically;
  final String name;
  final String password;
  final String type;
  final String token;
  final String address;
  final String email;
  final List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.type,
    required this.token,
    required this.address,
    required this.email,
    required this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'email': email,
      'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      type: map['userType'] ?? '',
      token: map['token'] ?? '',
      address: map['address'] ?? '',
      email: map['email'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? password,
    String? type,
    String? token,
    String? address,
    String? email,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      type: type ?? this.type,
      token: token ?? this.token,
      address: address ?? this.address,
      email: email ?? this.email,
      cart: cart ?? this.cart,
    );
  }
}
