class TableDebit {
  static const tbName = 'debit';
  static const id = 'id_debit';
  static const idUser = 'id_user';
  static const nama = 'nama';
  static const jumlah = 'jumlah';
  static const tipe = 'tipe';
  static const keterangan = 'keterangan';
  static const tanggalPinjam = 'tanggal_pinjam';
  static const tanggalKembali = 'tanggal_kembali';

  static const createTable = "CREATE TABLE $tbName($id INTEGER PRIMARY KEY, "
      "$idUser INTEGER, "
      "$nama TEXT, "
      "$jumlah INTEGER, "
      "$tipe TEXT, "
      "$keterangan TEXT, "
      "$tanggalPinjam TEXT, "
      "$tanggalKembali TEXT)";
}
