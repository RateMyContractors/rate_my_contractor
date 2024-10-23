class Contractor {
  final int id;
  final String companyName;
  final String ownerName;
  final String image;
  final double rating;
  final List<String> tags;

  const Contractor({
    required this.id,
    required this.companyName,
    required this.ownerName,
    required this.image,
    required this.rating,
    required this.tags, 
  });
}