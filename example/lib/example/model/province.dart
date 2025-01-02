class Province {
  final String name;
  final int id;
  final int countryId;
  Province(this.id, this.name, this.countryId);
  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    // Check if other is a Paddock and if names are equal
    if (identical(this, other)) return true;
    return other is Province && id == other.id;
  }
}
