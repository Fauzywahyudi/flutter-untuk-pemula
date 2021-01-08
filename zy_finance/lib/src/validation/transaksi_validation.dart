class TransaksiValidation {
  String validateName(String value) {
    if (value.isEmpty) return 'Required';
    return null;
  }

  String validateMoney(String value) {
    if (value.isEmpty) return 'Required';
    return null;
  }
}
