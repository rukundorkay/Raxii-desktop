extension StringX on String {
  String get avatar {
    // Split the string by space and remove any empty strings
    var parts = split(' ').where((part) => part.isNotEmpty).toList();

    // Return an empty string if no valid parts are found
    if (parts.isEmpty) return "";

    // Build the avatar by taking the first character of the first two valid parts
    return "${parts[0][0].toUpperCase()}${parts.length > 1 ? parts[1][0].toUpperCase() : ''}";
  }

  String formatAmount({String currency = 'RWF '}) {
    try {
      double value = double.parse(this);
      String formatted = value.toStringAsFixed(2).replaceAllMapped(
            RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          );

      // Remove .00 if it's a whole number
      if (formatted.endsWith('.00')) {
        formatted = formatted.substring(0, formatted.length - 3);
      }

      return '$currency$formatted';
    } catch (e) {
      return this; // Return original if parsing fails
    }
  }

  String get identifierFormatter {
    if (startsWith('250')) {
      return this;
    } else if (startsWith('0')) {
      return '250${substring(1)}';
    } else {
      return '250$this';
    }
  }
}
