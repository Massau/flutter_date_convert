import 'package:flutter_date_convert/flutter_date_convert.dart';
import 'package:intl/intl.dart';

class Convert {
  Format _format = Format();

  _convertDateTimeToTimestamp(date, expectedTypeOrFormat) {
    if (date is DateTime && expectedTypeOrFormat is int) {
      date = date.millisecondsSinceEpoch;
    }

    return date;
  }

  _convertDateTimeToString(date, expectedTypeOrFormat, locale) {
    if (date is DateTime &&
        _format.typeOrFormatIsString(expectedTypeOrFormat)) {
      expectedTypeOrFormat = _format.assingExpectedFormat(expectedTypeOrFormat);

      date = DateFormat(expectedTypeOrFormat).format(date);
    }

    return date;
  }

  _convertStringToDateTime(date, expectedTypeOrFormat) {
    if (date is String && expectedTypeOrFormat == DateTime) {
      date = DateTime.parse(date.split(RegExp(r'[-\\\/]')).reversed.join());
    }

    return date;
  }

  _convertStringToString(date, expectedTypeOrFormat, locale) {
    if (date is String && _format.typeOrFormatIsString(expectedTypeOrFormat)) {
      expectedTypeOrFormat = _format.assingExpectedFormat(expectedTypeOrFormat);

      date = _convertStringToDateTime(date, DateTime);

      date = _convertDateTimeToString(date, expectedTypeOrFormat, locale);
    }

    return date;
  }

  _convertStringToTimestamp(date, expectedTypeOrFormat) {
    if (date is String && expectedTypeOrFormat is int) {
      date = _convertStringToDateTime(date, expectedTypeOrFormat);

      date = _convertDateTimeToTimestamp(date, expectedTypeOrFormat);
    }

    return date;
  }

  _convertTimestampToDateTime(date, expectedTypeOrFormat) {
    if (date is int && expectedTypeOrFormat == DateTime) {
      date = DateTime.fromMillisecondsSinceEpoch(date);
    }

    return date;
  }

  _convertTimestampToString(date, expectedTypeOrFormat, locale) {
    if (date is int && _format.typeOrFormatIsString(expectedTypeOrFormat)) {
      expectedTypeOrFormat = _format.assingExpectedFormat(expectedTypeOrFormat);
      date = _convertTimestampToDateTime(date, DateTime);

      date = _convertDateTimeToString(date, expectedTypeOrFormat, locale);
    }

    return date;
  }

  _fromDateTime(date, expectedTypeOrFormat, locale) {
    Map<dynamic, dynamic> _treatmentByFormat = {
      int: _convertDateTimeToTimestamp(date, expectedTypeOrFormat),
      String: _convertDateTimeToString(date, expectedTypeOrFormat, locale),
    };

    return _treatmentByFormat[expectedTypeOrFormat];
  }

  _fromString(date, expectedTypeOrFormat, locale) {
    var _typeOrFormat = expectedTypeOrFormat.runtimeType == String
        ? String
        : expectedTypeOrFormat;

    Map<dynamic, dynamic> _treatmentByFormat = {
      DateTime: _convertStringToDateTime(date, expectedTypeOrFormat),
      String: _convertStringToString(date, expectedTypeOrFormat, locale),
      int: _convertStringToTimestamp(date, expectedTypeOrFormat),
    };

    return _treatmentByFormat[_typeOrFormat];
  }

  _fromTimestamp(date, expectedTypeOrFormat, locale) {
    var _typeOrFormat = expectedTypeOrFormat.runtimeType == String
        ? String
        : expectedTypeOrFormat;

    Map<dynamic, dynamic> _treatmentByFormat = {
      DateTime: _convertTimestampToDateTime(date, expectedTypeOrFormat),
      String: _convertTimestampToString(date, expectedTypeOrFormat, locale),
    };

    return _treatmentByFormat[_typeOrFormat];
  }

  fromInt(date) {
    int? _convertedDate;

    if (date != null) {
      if (date is int) {
        _convertedDate = date;
      }

      if (date is String) {
        _convertedDate = int.parse(date);
      }
    }

    return _convertedDate;
  }

  byExpected(date, expectedTypeOrFormat, currentStringFormat, locale) {
    var _convertedDate = date;

    if (date is DateTime && expectedTypeOrFormat != DateTime) {
      _convertedDate = _fromDateTime(date, expectedTypeOrFormat, locale);
    }

    if (date is String) {
      _convertedDate = _fromString(date, expectedTypeOrFormat, locale);
    }

    if (date is int && expectedTypeOrFormat != int) {
      _convertedDate = _fromTimestamp(date, expectedTypeOrFormat, locale);
    }

    return _convertedDate;
  }
}
