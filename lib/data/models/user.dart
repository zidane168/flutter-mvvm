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

class User {
  int id;
  String email;
  String? name_vi;
  String? name_en;

  List<UserLanguage>? userLanguages;

  User({required this.id, required this.email,   this.userLanguages, this.name_vi, this.name_en});

  factory User.fromJson(Map<String, dynamic> json) {
    List<UserLanguage> userLanguages = (json['member_languages'] as List<dynamic>)
        .map((languageJson) => UserLanguage.fromJson(languageJson))
        .toList();

    return User(
      id: json['id'],
      email: json['email'],
      userLanguages: userLanguages,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name_vi'] = this.name_vi;
    data['name_en'] = this.name_en;
    if (this.userLanguages != null) {
      data['member_languages'] = this.userLanguages!.map((v) => v.toJson()).toList();
    } else {
      data['member_languages'] = null;
    }
    return data;
  }
}

class UserLanguage {
  int? id;
  String? name;
  String? alias;

  UserLanguage({this.id, this.name, this.alias});

  UserLanguage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alias'] = this.alias;
    return data;
  }
}