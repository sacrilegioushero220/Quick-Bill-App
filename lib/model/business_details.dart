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
  @override
  String toString() {
    return 'BusinessDetails(name: $name, address: $address, phone: $phone, email: $email, website: $website, logo: $logo)';
  }
}
