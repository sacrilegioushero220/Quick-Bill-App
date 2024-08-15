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
  @override
  String toString() {
    return 'Customer(name: $name, address: $address, phone: $phone, email: $email)';
  }
}
