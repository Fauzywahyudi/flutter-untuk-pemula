import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.idUser,
    this.pass,
    this.nama,
    this.uang,
    this.hutang,
    this.piutang,
    this.status,
  });

  String idUser;
  String nama;
  String pass;
  String uang;
  String hutang;
  String piutang;
  String status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"],
        nama: json["nama"],
        pass: json["pass"],
        uang: json["uang"],
        hutang: json["hutang"],
        piutang: json["piutang"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama": nama,
        "pass": pass,
        "uang": uang,
        "hutang": hutang,
        "piutang": piutang,
        "status": status,
      };
}
