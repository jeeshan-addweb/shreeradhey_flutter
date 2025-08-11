class NetworkFunctions {
  static String? extractFirstValidationError(Map<String, dynamic> data) {
    if (data.isNotEmpty) {
      for (final key in data.keys) {
        final value = data[key];
        if (value is List && value.isNotEmpty && value.first is String) {
          return value.first;
        }
      }
    }
    return null;
  }
}
