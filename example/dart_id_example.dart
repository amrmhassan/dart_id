import 'package:dart_id/dart_id.dart';

void main() {
  // all these parameters are optional
  String id = DartID(
    idLength: 20,
    allowCapitalLetters: true,
    allowNumbers: true,
    allowSmallLetters: true,
    allowSymbols: false,
    swapParts: true,
  ).generate();
  print(id);

  DateTime createdAt = DartID().parseId(id);
  print(createdAt);
}
