class TableTransaksi {
  static const tbName = 'transaksi';
  static const id = 'id_transaksi';
  static const idUser = 'id_user';
  static const nama = 'nama_transaksi';
  static const jumlah = 'jumlah';
  static const tipe = 'tipe';
  static const keterangan = 'keterangan';
  static const tanggal = 'tanggal';

  static const createTable = "CREATE TABLE $tbName($id INTEGER PRIMARY KEY, "
      "$idUser INTEGER, "
      "$nama TEXT, "
      "$jumlah INTEGER, "
      "$tipe TEXT,"
      "$keterangan TEXT, "
      "$tanggal TEXT)";
}
