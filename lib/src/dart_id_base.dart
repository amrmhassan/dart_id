import 'dart:math';

String _smallLetters = 'abcdefghijklmnopqrstuvwxyz';
String _capitalLetters = _smallLetters.toUpperCase();
String _numbers = '1234567890';
String _symbols = '`~!@#\$%^&*()-=_+[]\\{}|;\':",./<>?';

class DartID {
  final int idLength;
  final bool allowSymbols;
  final bool allowNumbers;
  final bool allowCapitalLetters;
  final bool allowSmallLetters;
  final bool swapParts;
  final bool allowDateTime;

  const DartID({
    /// this is the length of the id part(the second part)
    this.idLength = 20,
    this.allowSymbols = false,
    this.allowNumbers = true,
    this.allowCapitalLetters = true,
    this.allowSmallLetters = true,
    this.swapParts = true,
    this.allowDateTime = true,
  });

  String generate() {
    String letters = '';
    if (allowSymbols) {
      letters += _symbols;
    }
    if (allowNumbers) {
      letters += _numbers;
    }
    if (allowSmallLetters) {
      letters += _smallLetters;
    }
    if (allowCapitalLetters) {
      letters += _capitalLetters;
    }
    if (letters.isEmpty) {
      throw Exception('You must allow at least one group of chars');
    }
    final chars = letters.split('');
    String id = _randomId(chars, idLength);
    if (allowDateTime) {
      String dateTime = DateTime.now().microsecondsSinceEpoch.toString();
      return combineId(dateTime, id, swapParts);
    } else {
      return id;
    }
  }

  String _randomId(List<String> chars, int length) {
    Random random = Random.secure();
    String id = '';
    for (var i = 0; i < length; i++) {
      int index = random.nextInt(chars.length);
      id += chars[index];
    }
    return id;
  }

  DateTime parseId(String id) {
    try {
      String dateTimeString = id.split('-').first;
      int microsecondsSinceEpoch = int.parse(dateTimeString);
      DateTime dateTime =
          DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
      return dateTime;
    } catch (e) {
      return _parseSwapped(id);
    }
  }

  DateTime _parseSwapped(String id) {
    try {
      String dateTimeString = id.split('-').last;
      int microsecondsSinceEpoch = int.parse(dateTimeString);
      DateTime dateTime =
          DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
      return dateTime;
    } catch (e) {
      throw Exception('This is not a valid id');
    }
  }

  String combineId(String dateTime, String id, bool swapParts) {
    String finalId = '';
    if (!swapParts) {
      finalId = dateTime;
      if (id.isNotEmpty) {
        finalId += '-$id';
      }
    } else {
      if (id.isNotEmpty) {
        finalId = '$id-';
      }
      finalId += dateTime;
    }
    return finalId;
  }
}
