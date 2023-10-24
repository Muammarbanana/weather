class Helpers {
  static validateEmail({required String email}) {
    const String emailPattern =
        r'^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*\.)+[a-z]{2,4}$';
    final RegExp emailRegex = RegExp(emailPattern);

    return emailRegex.hasMatch(email);
  }
}
