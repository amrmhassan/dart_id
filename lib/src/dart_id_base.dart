import 'dart:math';

String _smallLetters = 'abcdefghijklmnopqrstuvwxyz';
String _capitalLetters = _smallLetters.toUpperCase();
String _numbers = '1234567890';
String _symbols = '`~!@#\$%^&*()-=_+[]\\{}|;\':",./<>?';

class DartID {
  final int idLength = 20;
  final bool allowSymbols = false;
  final bool allowNumbers = true;
  final bool allowCapitalLetters = true;
  final bool allowSmallLetters = true;
  final bool swapParts = true;

  const DartID({
    /// this is the length of the id part(the second part)
    int idLength = 20,
    bool allowSymbols = false,
    bool allowNumbers = true,
    bool allowCapitalLetters = true,
    bool allowSmallLetters = true,
    bool swapParts = true,
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
    String dateTime = DateTime.now().microsecondsSinceEpoch.toString();
    return combineId(dateTime, id, swapParts);
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
