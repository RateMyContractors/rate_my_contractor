class Contractor {
  final int id;
  final String companyName;
  final String ownerName;
  final String image;
  final double rating;
  final List<String> tags;
  final String phone;
  final String email;
  final String aboutUs;

  const Contractor({
    required this.id,
    required this.companyName,
    required this.ownerName,
    required this.image,
    required this.rating,
    required this.tags, 
    required this.phone,
    required this.email,
    required this.aboutUs,
  });
}