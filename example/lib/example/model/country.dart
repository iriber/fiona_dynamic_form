class Country {
  final String name;
  final int id;
  Country(this.id, this.name);
  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    // Check if other is a Paddock and if names are equal
    if (identical(this, other)) return true;
    return other is Country && id == other.id;
  }
}
