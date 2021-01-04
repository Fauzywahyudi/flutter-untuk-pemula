class UserValidation {
  String validateName(String value) {
    if (value.isEmpty) return 'Required';
    return null;
  }

  String validatePassword(String value, String name) {
    List nameWords = name.split(" ");
    if (value.isEmpty) return 'Required';
    if (value.length < 8) return 'Password Minimal 8 Karakter';
    for (String word in nameWords) {
      if (value.toLowerCase().contains(word.toLowerCase()))
        return 'Password Tidak Boleh Mengandung Nama';
    }
    return null;
  }

  String validateMoney(String value) {
    if (value.isEmpty) return 'Required';
    return null;
  }
}
