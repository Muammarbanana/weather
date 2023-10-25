class Helpers {
  static validateEmail({required String email}) {
    const String emailPattern =
        r'^[\w-]+(\.[\w-]+)*@([a-z0-9-]+(\.[a-z0-9-]+)*\.)+[a-z]{2,4}$';
    final RegExp emailRegex = RegExp(emailPattern);

    return emailRegex.hasMatch(email);
  }

  static String getErrorMessageFromEndpoint(
      dynamic dynamicErrorMessage, String httpErrorMessage, int statusCode) {
    if (dynamicErrorMessage is Map &&
        dynamicErrorMessage.containsKey('reason') &&
        dynamicErrorMessage['reason'].isNotEmpty) {
      return 'status code : $statusCode | error: ${dynamicErrorMessage['reason']}';
    } else if (dynamicErrorMessage is Map &&
        dynamicErrorMessage.containsKey('message') &&
        dynamicErrorMessage['message'].isNotEmpty) {
      return 'status code : $statusCode | error: ${dynamicErrorMessage['message']}';
    } else if (dynamicErrorMessage is String) {
      return httpErrorMessage;
    } else {
      return httpErrorMessage;
    }
  }
}
