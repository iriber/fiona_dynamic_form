
class Province{
  final String name;
  final int id;
  final int countryId;
  Province(this.id, this.name, this.countryId);
  @override
  String toString() {
    return name;
  }

}
