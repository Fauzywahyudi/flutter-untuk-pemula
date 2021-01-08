import 'dart:convert';

List<Transaksi> transaksiFromJson(String str) =>
    List<Transaksi>.from(json.decode(str).map((x) => Transaksi.fromMap(x)));

String transaksiToJson(List<Transaksi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Transaksi {
  Transaksi({
    this.idTransaksi,
    this.idUser,
    this.namaTransaksi,
    this.jumlah,
    this.tipe,
    this.keterangan,
    this.tanggal,
  });

  int idTransaksi;
  int idUser;
  String namaTransaksi;
  int jumlah;
  String tipe;
  String keterangan;
  String tanggal;

  factory Transaksi.fromMap(Map<String, dynamic> json) => Transaksi(
        idTransaksi: json["id_transaksi"],
        idUser: json["id_user"],
        namaTransaksi: json["nama_transaksi"],
        jumlah: json["jumlah"],
        tipe: json["tipe"],
        keterangan: json["keterangan"],
        tanggal: json["tanggal"],
      );

  Map<String, dynamic> toJson() => {
        "id_transaksi": idTransaksi,
        "id_user": idUser,
        "nama_transaksi": namaTransaksi,
        "jumlah": jumlah,
        "tipe": tipe,
        "keterangan": keterangan,
        "tanggal": tanggal,
      };
}
