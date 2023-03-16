class Origin {
  final int id;
  final String name;
  final Location location;

  Origin({
    required this.id,
    required this.name,
    required this.location,
  });
}

class Location {
  final String type;
  final List<dynamic> coordinates;

  Location({required this.type, required this.coordinates});
}
