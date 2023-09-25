# Dart ID
this is a fast way to create ids with data inside them about when they are created

# How to use
```dart
  // all these parameters are optional
  String id = DartID().generate(
    idLength: 20,
    allowCapitalLetters: true,
    allowNumbers: true,
    allowSmallLetters: true,
    allowSymbols: false,
    swapParts: true,
  );
  print(id);

  DateTime createdAt = DartID().parseId(id);
  print(createdAt);

```

# As easy as that