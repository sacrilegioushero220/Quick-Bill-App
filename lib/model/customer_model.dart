class Customer {
  String name;
  String address;
  String phone;
  String email;

  Customer({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
    };
  }

  // JSON deserialization
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  @override
  String toString() {
    return 'Customer(name: $name, address: $address, phone: $phone, email: $email)';
  }
}
