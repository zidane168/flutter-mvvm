/*
"params": [
  {
    "id": 1,
    "email": "whoami@gmail.com",
    "enabled": true,
    "created": null,
    "modified": null,
    "member_languages": [
      {
      "id": 2,
      "alias": "en_US",
      "name": "Who am I",
      "member_id": 1
      }
    ]
  }, {}, {}, ...
];
*/

class UpdateUser {
  int id;
  String email;
  String name_vi;
  String name_en;

  UpdateUser({required this.id, required this.email, required this.name_vi, required this.name_en});

  factory UpdateUser.fromJson(Map<String, dynamic> json) {

    return UpdateUser(
      id: json['id'],
      email: json['email'],
      name_vi: json['name_vi'],
      name_en: json['name_en'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name_vi'] = this.name_vi;
    data['name_en'] = this.name_en;
    return data;
  }
}