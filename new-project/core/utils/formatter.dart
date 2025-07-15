import 'package:intl/intl.dart';

class Formatter {
  /// Formats a monetary amount with currency support
  static String formatMoney(
    double amount, {
    String currency = 'USD',
    bool showDecimals = true,
  }) {
    // Determine the number of decimal places
    String formatted =
        showDecimals ? amount.toStringAsFixed(2) : amount.toStringAsFixed(0);
    // Remove trailing zeros after the decimal point if necessary
    formatted = formatted.replaceAll(RegExp(r'\.0+$'), '');
    // Add thousand separators
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    formatted = formatted.replaceAllMapped(reg, (Match m) => '${m[1]},');
    // Add currency symbol
    return currency.isNotEmpty ? '$formatted $currency' : formatted;
  }

  /// Formats a date to a specified pattern
  static String formatDate(DateTime date, {String pattern = 'dd/MM/yyyy'}) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(date);
  }

  /// Formats a time to a specified pattern
  static String formatTime(DateTime time, {String pattern = 'HH:mm'}) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(time);
  }

  /// Formats a date and time together
  static String formatDateTime(
    DateTime dateTime, {
    String pattern = 'dd/MM/yyyy HH:mm',
  }) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(dateTime);
  }

  /// Formats a phone number
  static String formatPhoneNumber(String phoneNumber) {
    // Remove non-digit characters
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    // Format the number if it has a valid length (e.g., +1234567890 -> +123 456 7890)
    if (cleaned.startsWith('+') && cleaned.length >= 10) {
      cleaned = cleaned.replaceFirst(
        RegExp(r'(\+\d{1,3})(\d{3})(\d{3})(\d+)'),
        r'$1 $2 $3 $4',
      );
    }
    return cleaned;
  }

  /// Capitalizes the first letter of a text
  static String formatCapitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Formats text to title case (capitalizes first letter of each word)
  static String formatTitleCase(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map(
          (word) =>
              word.isNotEmpty
                  ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                  : '',
        )
        .join(' ');
  }

  /// Formats a number to a compact form (e.g., 1000 -> 1K, 1000000 -> 1M)
  static String formatNumberCompact(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }

  /// Formats a value as a percentage
  static String formatPercentage(double value, {int decimalPlaces = 2}) {
    return '${(value * 100).toStringAsFixed(decimalPlaces)}%';
  }

  /// Formats file size (e.g., KB, MB, GB)
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    int i = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(2)} ${suffixes[i]}';
  }

  /// Truncates text if it exceeds a specified length
  static String formatTruncateText(
    String text,
    int maxLength, {
    String suffix = '...',
  }) {
    if (text.length <= maxLength) return text;
    return text.substring(0, maxLength) + suffix;
  }
}
