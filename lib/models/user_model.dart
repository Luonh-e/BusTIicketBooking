class UserModel {
  final String? id;
  final String fullName;
  final String phoneNo;
  final String email;
  final String password;

  const UserModel({
    this.id,
    this.email = '',
    this.password = '',
    this.fullName = '',
    this.phoneNo = '',
  });

  toJson() {
    return {
      "FullName": fullName,
      "Phone": phoneNo,
      "Email": email,
      'Admin': 0,
    };
  }
}
