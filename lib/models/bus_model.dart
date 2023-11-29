class UserModel {
  final String busNumber;
  final String nameBus;

  UserModel({
    this.busNumber = '',
    this.nameBus = '',
  });

  toJson() {
    return {
      "id": busNumber,
      "city": nameBus,
    };
  }
}
