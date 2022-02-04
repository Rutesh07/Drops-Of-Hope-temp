class UserModel{
  String? Uid;
  String? Email;
  String? FirstName;
  String? LastName;

  UserModel({this.Uid, this.Email, this.FirstName, this.LastName});

  // receiving data from server
  factory UserModel.fromMap(map)
  {
    return UserModel(
      Uid: map['Uid'],
      Email: map['Email'],
      FirstName: map['FirstName'],
      LastName: map['LastName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
   return {
      'Uid': Uid,
      'Email': Email,
      'FirstName': FirstName,
      'LastName': LastName,
    };
  }
}
