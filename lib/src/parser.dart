import 'package:flutter_date_convert/flutter_date_convert.dart';
import 'package:flutter_date_convert/src/convert.dart';

class Parser {
  Format _format = Format();
  Convert _convert = Convert();

  /// Receives a date as input in the format [DateTime], [int], or [String], and returns the converted date in the desired data type
  ///
  /// Throws an exception if an invalid value is provided for any parameter
  ///
  /// If the input and output types are the same, no conversion will occur, except for [String] to [String] when the input date format is different from the expected format:
  ///
  /// ```dart
  /// Parser _parser = Parser();
  ///
  /// Widget build(BuildContext context) {
  ///   return Text(
  ///     _parser.dateConvert(
  ///       '25/06/2023',
  ///       expectedTypeOrFormat: 'yMMMMd',
  ///       currentStringFormat: 'dmy',
  ///     ),
  ///     textAlign: TextAlign.center,
  ///   );
  /// }
  /// ```
  ///
  /// When converting a date to [String], the [expectedTypeOrFormat] parameter can be either of type [String]
  /// or a String specifying the accepted formats, with the latter option being preferred:
  ///
  /// ```dart
  /// Parser _parser = Parser();
  ///
  /// Widget build(BuildContext context) {
  ///   return Text(
  ///     _parser.dateConvert(
  ///       '25/06/2023',
  ///       expectedTypeOrFormat: String, // 'yMMMMd'
  ///       currentStringFormat: 'dmy',
  ///     ),
  ///     textAlign: TextAlign.center,
  ///   );
  /// }
  /// ```
  ///
  /// The [currentStringFormat] parameter is REQUIRED when the input date is of type [String]
  /// Dates in other formats will not be affected by this parameter
  /// The following options are valid to inform in this parameter: 'dmy', 'mdy', 'ymd'
  /// Providing the incorrect order of day, month, and year in the String may result in an incorrect output or an exception
  ///
  /// The [locale] parameter is optional and can be provided when the output type is [String]. Different output types will not be affected by this parameter
  /// If nothing is provided, the default [locale] value is assumed to be 'en_US'
  /// To identify if a [locale] is valid, refer to: https://pub.dev/documentation/intl/latest/date_symbol_data_http_request/availableLocalesForDateFormatting.html
  ///
  dateConvert(
    date, {
    required expectedTypeOrFormat,
    currentStringFormat,
    String locale = 'en_US',
  }) {
    _format.assingLocale(locale);

    if (_format.validDate(
        date, expectedTypeOrFormat, currentStringFormat, locale)) {
      date = _convert.byExpected(
          date, expectedTypeOrFormat, currentStringFormat, locale);
    }

    return date;
  }
}
