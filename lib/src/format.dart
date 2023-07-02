import 'package:flutter_date_convert/src/convert.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'utils.dart';

class Format {
  typeOrFormatIsString(typeOrFormat) =>
      typeOrFormat == String || typeOrFormat is String;

  _regularExpression(date) {
    bool _regularExpressionValid = false;
    var _amountCharacters = {
      'day': '[0-3][0-9]',
      'month': '[01][1-9]',
      'year': '[0-9]{4}',
    };
    List<RegExp> _dateFormats = [
      RegExp(
          '^${_amountCharacters["day"]}[-\\\/]${_amountCharacters["month"]}[-\\\/]${_amountCharacters["year"]}\$'),
      RegExp(
          '^${_amountCharacters["year"]}[-\\\/]${_amountCharacters["month"]}[-\\\/]${_amountCharacters["day"]}\$'),
    ];

    for (var i = 0; i < _dateFormats.length; i++) {
      if (_dateFormats[i].hasMatch(date)) {
        _regularExpressionValid = true;
        break;
      }
    }

    return _regularExpressionValid;
  }

  _validStringDay(List date, String format) {
    Convert _convert = Convert();
    format = format.toString().toLowerCase();
    bool _valid = false;

    if (format == 'dmy') {
      _valid = _convert.fromInt(date[0]) > 0 &&
          _convert.fromInt(date[0]) <=
              mounthsNonLeapYear[_convert.fromInt(date[1])]['days'];
    }

    if (format == 'ymd') {
      _valid = _convert.fromInt(date[2]) > 0 &&
          _convert.fromInt(date[2]) <=
              mounthsNonLeapYear[_convert.fromInt(date[1])]['days'];
    }

    if (format == 'mdy') {
      _valid = _convert.fromInt(date[1]) > 0 &&
          _convert.fromInt(date[1]) <=
              mounthsNonLeapYear[_convert.fromInt(date[1])]['days'];
    }

    return _valid;
  }

  _validStringMonth(month) {
    Convert _convert = Convert();

    return _convert.fromInt(month) > 0 && _convert.fromInt(month) <= 12;
  }

  bool _validString(date, currentFormat) {
    bool _validDate = false;

    if (date is String) {
      if (_regularExpression(date)) {
        _validDate = true;
        List<String> _dateParts = date.split(RegExp(r'[-\\\/]'));

        _validDate = _validStringMonth(_dateParts[1]) &&
            _validStringDay(_dateParts, currentFormat);
      }
    }

    return _validDate;
  }

  bool validDateTime(date) {
    bool _valid = false;

    if (date is DateTime) {
      _valid = _validStringMonth(date.month) &&
          _validStringDay([date.day, date.month], 'dmy');
    }

    return _valid;
  }

  bool _validInt(date) {
    bool _valid = false;

    if (date is int) {
      _valid = true;
    }

    return _valid;
  }

  bool _validLocale(locale) => DateFormat.localeExists(locale);

  assingExpectedFormat(expectedTypeOrFormat) {
    String _availableFormat = 'yMd';

    if (expectedTypeOrFormat == String) {
      expectedTypeOrFormat = _availableFormat;
    }

    return expectedTypeOrFormat;
  }

  void assingLocale(locale) {
    String _locale = 'en_US';

    initializeDateFormatting(_locale, null);
    Intl.defaultLocale = _locale;

    if (_validLocale(locale)) {
      _locale = locale;

      initializeDateFormatting(_locale, null);
      Intl.defaultLocale = _locale;
    }
  }

  bool _validexpectedTypeOrFormat({expectedTypeOrFormat, currentStringFormat}) {
    bool _valid = false;

    if (expectedTypeOrFormat != null) {
      if (_validDateTypes(expectedTypeOrFormat)) {
        _valid = true;
        if (!(expectedTypeOrFormat == String &&
            validFormats.contains(expectedTypeOrFormat))) {
          _valid = true;
        }
      }
    }

    if (currentStringFormat != null) {
      if (currentStringFormat.runtimeType == String &&
          ['mdy', 'dmy', 'ymd']
              .contains(currentStringFormat.toString().toLowerCase())) {
        _valid = true;
      }
    } else {
      _valid = true;
    }

    return _valid;
  }

  bool _validDateTypes(dateOrDateType) {
    List _generalValidFormats = [DateTime, String, int];

    return _generalValidFormats.contains(dateOrDateType.runtimeType) ||
        dateOrDateType == String;
  }

  bool _validDateByType(date, currentStringFormat) {
    Map<dynamic, bool> _treatmentByTypes = {
      DateTime: validDateTime(date),
      String: _validString(date, currentStringFormat),
      int: _validInt(date),
    };

    return _treatmentByTypes[date.runtimeType]!;
  }

  bool validDate(date, expectedTypeOrFormat, currentStringFormat, locale) {
    bool _valid = false;

    if (_validexpectedTypeOrFormat(
        expectedTypeOrFormat: expectedTypeOrFormat)) {
      _valid = true;
    } else {
      throw ArgumentError('Invalid expected format');
    }

    if (!_validexpectedTypeOrFormat(currentStringFormat: currentStringFormat)) {
      throw ArgumentError('Invalid current string format');
    }

    if (!_validDateTypes(date)) {
      throw ArgumentError(
          'Invalid date type. Allowed formats are: DateTime, String, int');
    }

    if (!_validDateByType(date, currentStringFormat)) {
      throw ArgumentError('The date entered is invalid');
    }

    return _valid;
  }
}
