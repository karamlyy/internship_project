extension StringValidation on String {
  bool wordAdded() {
    return length >= 2;
  }

  bool isValidEmail() {
    return RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(this);
  }

  bool isValidPassword() {
    return length >= 8 && contains(RegExp(r'[A-Z]'));
  }
}
