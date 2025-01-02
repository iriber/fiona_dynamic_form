class City {
  final String name;
  final int id;
  final int stateId;
  City(this.id, this.name, this.stateId);
  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    // Check if other is a Paddock and if names are equal
    if (identical(this, other)) return true;
    return other is City && id == other.id;
  }
}
