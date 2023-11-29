class UserModel {
  final String? id;
  final String cityName;

  UserModel({
    this.id = '',
    this.cityName = '',
  });

  toJson() {
    return {
      "id": id,
      "city": cityName,
    };
  }
}
