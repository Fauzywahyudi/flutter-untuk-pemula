import 'dart:convert';

List<Debt> debtFromJson(String str) =>
    List<Debt>.from(json.decode(str).map((x) => Debt.fromJson(x)));

String debtToJson(List<Debt> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Debt {
  Debt({
    this.idDebit,
    this.idUser,
    this.nama,
    this.jumlah,
    this.tipe,
    this.keterangan,
    this.tanggalPinjam,
    this.tanggalKembali,
  });

  int idDebit;
  int idUser;
  String nama;
  int jumlah;
  String tipe;
  String keterangan;
  String tanggalPinjam;
  String tanggalKembali;

  factory Debt.fromJson(Map<String, dynamic> json) => Debt(
        idDebit: json["id_debit"],
        idUser: json["id_user"],
        nama: json["nama"],
        jumlah: json["jumlah"],
        tipe: json["tipe"],
        keterangan: json["keterangan"],
        tanggalPinjam: json["tanggal_pinjam"],
        tanggalKembali: json["tanggal_kembali"],
      );

  Map<String, dynamic> toJson() => {
        "id_debit": idDebit,
        "id_user": idUser,
        "nama": nama,
        "jumlah": jumlah,
        "tipe": tipe,
        "keterangan": keterangan,
        "tanggal_pinjam": tanggalPinjam,
        "tanggal_kembali": tanggalKembali,
      };
}
