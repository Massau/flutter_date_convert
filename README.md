# DateConvert

DateConvert is a package for the Dart language used to perform date conversions

Abstracts the logic of converting between dates of different types (or the same type, such as converting from String 'dd/MM/yy' to 'yyyy-MM-dd,' for example), requiring only the input date and the expected format after conversion

![](https://github.com/Massau/flutter_date_convert/blob/main/assets/date_convert.jpg)

### Install

This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get)

```yaml
  dependencies:
    date_convert:
      git:
        url: https://github.com/Massau/flutter_date_convert.git
        ref: '0.0.1' # branch name
```

### Getting Started

Provide a date in the form of DateTime, int, or String as input and obtain the converted date in the desired data type.

Throw an exception if an invalid value is provided for any parameter.

If the input and output date types are the same, no conversion will occur, except for String and String, when the input date format differs from the expected format.


### Parameters

- date is required and can be provided in the following formats: DateTime, int, or String
- expectedTypeOrFormat is required. If you want the converted date to be a String, you can either provide the String class as the parameter or specify the desired format for the String after conversion. If the class is provided without specifying the format, a default DateFormat will be assigned
- currentStringFormat is required when the input date is of type String. Dates in other formats will not be affected. The following options are valid to inform in this parameter: 'dmy', 'mdy', 'ymd'. Providing the incorrect order of day, month, and year in the String may result in an incorrect output or an exception
- locale is optional and can be provided or omitted when the output type is String. Different output types will not be affected by this parameter. If nothing is provided, the default value is assumed to be 'en_US'


### Conversions

This package can perform the following date conversions:

#### String to String Conversion (with different formats)

The input date has the format "yMd", and the expected output date format is 'yMMMMd'.

```dart
  Parser _parser = Parser();
  
  Widget build(BuildContext context) {
    return Text(
      _parser.dateConvert(
        '25/06/2023',
        expectedTypeOrFormat: 'yMMMMd',
        currentStringFormat: 'dmy',
      ),
      textAlign: TextAlign.center,
    );
  }
```

The code snippet above produces the following result:

```
'June 25, 2023'
```

#### String to String Conversion (Specifying Locale as a parameter)

It is possible to specify the locale of the date after conversion.

This parameter is optional and can be provided when the output type is String. Different output types will not be affected by it.

If the parameter is not provided for a String conversion, the default value is 'en_US'. Below is an example that specifies the locale:

```dart
  Parser _parser = Parser();
  
  Widget build(BuildContext context) {
    return Text(
      _parser.dateConvert(
        '25/06/2023',
        expectedTypeOrFormat: 'yMMMMd',
        currentStringFormat: 'dmy',
        locale: 'pt_BR'
      ),
      textAlign: TextAlign.center,
    );
  }
```

The code snippet above produces the following result:


```
'25 de junho de 2023'
```

To identify if a locale is valid, consult [this link](https://pub.dev/documentation/intl/latest/date_symbol_data_http_request/availableLocalesForDateFormatting.html)

#### int to int Conversion

No conversion is performed when the data types are the same, and the number itself is returned:

```dart
  Parser _parser = Parser();
  
  Widget build(BuildContext context) {
    return Text(
      _parser.dateConvert(
        1687662000000,
        expectedTypeOrFormat: int
      ).toString(),
      textAlign: TextAlign.center,
    );
  }
```

The code snippet above produces the following result:

```
1687662000000
```

#### DateTime to int Conversion

```dart
  Parser _parser = Parser();
  
  Widget build(BuildContext context) {
    return Text(
      _parser.dateConvert(
        DateTime(2023, 06, 24),
        expectedTypeOrFormat: int
      ).toString(),
      textAlign: TextAlign.center,
    );
  }
```

The code snippet above produces the following result:

```
1687575600000"
```
