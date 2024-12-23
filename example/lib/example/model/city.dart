class City{
  final String name;
  final int id;
  final int stateId;
  City(this.id, this.name, this.stateId);
  @override
  String toString() {
    return name;
  }

}
