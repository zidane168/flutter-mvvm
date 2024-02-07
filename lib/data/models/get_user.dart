
class GetUser {
  int id;
  String email;
  String name;

  GetUser( {required this.id, required this.email, required this.name} );

  factory GetUser.fromJson(Map<String, dynamic> json) {

    return GetUser(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}