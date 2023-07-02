import 'package:flutter_date_convert/flutter_date_convert.dart';
import 'package:flutter_date_convert/src/parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Format Class', () {
    test('Valid dates', () {
      final Format format = Format();

      expect(format.validDateTime(DateTime(2023, 9, 30)), true);
      expect(format.validDateTime(DateTime(2023, 12, 31)), true);
    });
  });

  group('Parser', () {
    test('Convert dates', () {
      Parser _parser = Parser();

      expect(
        _parser.dateConvert(DateTime(2023, 06, 24),
            expectedTypeOrFormat: DateTime),
        DateTime(2023, 06, 24),
      );
      expect(
        _parser.dateConvert(1687575600000, expectedTypeOrFormat: DateTime),
        DateTime(2023, 06, 24),
      );
      expect(
        _parser.dateConvert(
          1687575600000,
          expectedTypeOrFormat: DateTime,
          currentStringFormat: 'dmy',
        ),
        DateTime(2023, 06, 24),
      );
      expect(
        _parser.dateConvert(
          1687575600000,
          expectedTypeOrFormat: DateTime,
          currentStringFormat: 'dmy',
          locale: 'pt_BR',
        ),
        DateTime(2023, 06, 24),
      );
      expect(
        _parser.dateConvert(1687662000000,
            expectedTypeOrFormat: 'yMd', currentStringFormat: 'dmy'),
        '6/25/2023',
      );
      expect(
        _parser.dateConvert(1687662000000, expectedTypeOrFormat: int),
        1687662000000,
      );
      expect(
        _parser.dateConvert(
          1687662000000,
          expectedTypeOrFormat: 'yMd',
          currentStringFormat: 'dmy',
          locale: 'pt_BR',
        ),
        '25/06/2023',
      );
      expect(
        _parser.dateConvert('25/06/2023',
            expectedTypeOrFormat: 'yMd', currentStringFormat: 'dmy'),
        '6/25/2023',
      );
      expect(
        _parser.dateConvert(
          '25/06/2023',
          expectedTypeOrFormat: 'yMd',
          currentStringFormat: 'dmy',
          locale: 'pt_BR',
        ),
        '25/06/2023',
      );
      expect(
        _parser.dateConvert('25/06/2023',
            expectedTypeOrFormat: 'yMMMMd',
            currentStringFormat: 'dmy',
            locale: 'pt_BR'),
        '25 de junho de 2023',
      );
      expect(
        _parser.dateConvert('25/06/2023',
            expectedTypeOrFormat: String, currentStringFormat: 'dmy'),
        '6/25/2023',
      );
      expect(
        _parser.dateConvert(DateTime(2023, 06, 25),
            expectedTypeOrFormat: String),
        '6/25/2023',
      );
      expect(
        _parser.dateConvert(1687662000000, expectedTypeOrFormat: String),
        '6/25/2023',
      );
    });
  });
}
