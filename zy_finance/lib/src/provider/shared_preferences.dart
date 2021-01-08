import 'package:shared_preferences/shared_preferences.dart';
import 'package:zy_finance/src/model/user.dart';

class DataShared {
  static const _isNew = 'isNew';
  static const _idUser = 'idUser';
  static const _nama = 'nama';
  static const _uang = 'uang';
  // static const _data = 'data';
  // static const _idPenjual = 'idPenjual';
  // static const _buyNow = 'buyNow';

  Future<bool> getIsNew() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final isNew = sharedPreferences.getBool(_isNew);
    return isNew;
  }

  Future<int> getIdUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final idUser = sharedPreferences.getInt(_idUser);
    return idUser;
  }

  Future setIsNew(bool value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_isNew, value);
  }

  Future setUser(User user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(_idUser, user.idUser);
    sharedPreferences.setString(_nama, user.nama);
    sharedPreferences.setInt(_uang, user.uang);
  }

  Future<int> getId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(_idUser);
  }

  // Future<int> getValue() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   int value = sharedPreferences.getInt(_value);
  //   return value;
  // }

  // Future<String> getNama() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String value = sharedPreferences.getString(_nama);
  //   return value;
  // }

  // Future<String> getData() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String value = sharedPreferences.getString(_data);
  //   return value;
  // }

  // Future<String> getAktor() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String value = sharedPreferences.getString("aktor");
  //   return value;
  // }

  // Future<int> getIdPenjual() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   int value = sharedPreferences.getInt(_idPenjual);
  //   return value;
  // }

  // Future<String> getBuyNow() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String value = sharedPreferences.getString(_buyNow);
  //   return value;
  // }

  // Future clearAll() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setInt(_value, null);
  //   sharedPreferences.setInt(_id, null);
  //   sharedPreferences.setString(_nama, null);
  //   sharedPreferences.setString(_data, null);
  // }

  // Future<bool> getValueOnboarding() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   bool value = sharedPreferences.getBool("onboarding");
  //   return value;
  // }

  // Future setValueOnboarding(bool value) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool("onboarding", value);
  // }

  // Future setBuyNow(DataKeranjang data) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String value = dataKeranjangToJson(data);
  //   sharedPreferences.setString(_buyNow, value);
  // }

  // Future setUserPref(ResponseSign response) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String data = userToJson([response.user]);
  //   sharedPreferences.setInt(_value, response.value);
  //   sharedPreferences.setInt(_id, int.parse(response.user.idUser));
  //   sharedPreferences.setString(_nama, response.user.namaUser);
  //   sharedPreferences.setString(_data, data);
  // }

  // Future setIdPenjual(int id) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setInt(_idPenjual, id);
  // }

  // Future setAdminPref(ResponseSign response) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String data = adminToJson([response.admin]);
  //   sharedPreferences.setInt(_value, response.value);
  //   sharedPreferences.setInt(_id, int.parse(response.admin.idAdmin));
  //   sharedPreferences.setString(_nama, response.admin.namaAdmin);
  //   sharedPreferences.setString(_data, data);
  // }

  // Future saveDataPrefDosen(int value, Dosen dosen) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setInt("value", value);
  //   sharedPreferences.setString("aktor", "Dosen");
  //   sharedPreferences.setInt("id", dosen.idDosen);
  //   sharedPreferences.setString("username", dosen.nidn);
  //   sharedPreferences.setString("nama", dosen.nama);
  //   sharedPreferences.setString("gelar", dosen.gelar);
  //   sharedPreferences.setString("jk", dosen.jk);
  //   sharedPreferences.setString("jabatan", dosen.jabatan);
  //   sharedPreferences.setString("alamat", dosen.alamat);
  //   sharedPreferences.setString("nohp", dosen.nohp);
  // }

  // Future<Dosen> getDataPrefDosen() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Dosen dosen;
  //   int id = sharedPreferences.getInt("id");
  //   String username = sharedPreferences.getString("username");
  //   String nama = sharedPreferences.getString("nama");
  //   String gelar = sharedPreferences.getString("gelar");
  //   String jk = sharedPreferences.getString("jk");
  //   String jabatan = sharedPreferences.getString("jabatan");
  //   String alamat = sharedPreferences.getString("alamat");
  //   String nohp = sharedPreferences.getString("nohp");
  //   dosen = Dosen(id, username, nama, gelar, jk, jabatan, alamat, nohp);

  //   return dosen;
  // }

  // Future<Mahasiswa> getDataPrefMahasiswa() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   Mahasiswa mahasiswa;
  //   int id = sharedPreferences.getInt("id");
  //   String username = sharedPreferences.getString("username");
  //   String nama = sharedPreferences.getString("nama");
  //   String jk = sharedPreferences.getString("jk");
  //   String jurusan = sharedPreferences.getString("jurusan");
  //   String alamat = sharedPreferences.getString("alamat");
  //   String nohp = sharedPreferences.getString("nohp");
  //   mahasiswa = Mahasiswa(id, username, nama, jk, jurusan, alamat, nohp);

  //   return mahasiswa;
  // }

  // Future saveDataPrefDosen(int value, Dosen dosen) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setInt("value", value);
  //   sharedPreferences.setString("aktor", "Dosen");
  //   sharedPreferences.setInt("id", dosen.idDosen);
  //   sharedPreferences.setString("username", dosen.nidn);
  //   sharedPreferences.setString("nama", dosen.nama);
  //   sharedPreferences.setString("gelar", dosen.gelar);
  //   sharedPreferences.setString("jk", dosen.jk);
  //   sharedPreferences.setString("jabatan", dosen.jabatan);
  //   sharedPreferences.setString("alamat", dosen.alamat);
  //   sharedPreferences.setString("nohp", dosen.nohp);
  // }

  // Future saveDataPrefMahasiswa(int value, Mahasiswa mahasiswa) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setInt("value", value);
  //   sharedPreferences.setString("aktor", "Mahasiswa");
  //   sharedPreferences.setInt("id", mahasiswa.idMahasiswa);
  //   sharedPreferences.setString("username", mahasiswa.nim);
  //   sharedPreferences.setString("nama", mahasiswa.nama);
  //   sharedPreferences.setString("jk", mahasiswa.jk);
  //   sharedPreferences.setString("jurusan", mahasiswa.jurusan);
  //   sharedPreferences.setString("alamat", mahasiswa.alamat);
  //   sharedPreferences.setString("nohp", mahasiswa.nohp);
  // }

  // Future logout() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setInt("value", null);
  // }
}
