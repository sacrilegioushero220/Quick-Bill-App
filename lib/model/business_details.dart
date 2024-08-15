class BusinessDetails {
  final String name;
  final String address;
  final String? website;
  final String phone;
  final String email;
  final String logo;

  BusinessDetails({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.logo,
    this.website,
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'website': website,
      'phone': phone,
      'email': email,
      'logo': logo,
    };
  }

  // JSON deserialization
  factory BusinessDetails.fromJson(Map<String, dynamic> json) {
    return BusinessDetails(
      name: json['name'],
      address: json['address'],
      website: json['website'],
      phone: json['phone'],
      email: json['email'],
      logo: json['logo'],
    );
  }

  @override
  String toString() {
    return 'BusinessDetails(name: $name, address: $address, phone: $phone, email: $email, website: $website, logo: $logo)';
  }
}
