class Coin {
  final String symbol;
  String name;
  String shortName;
  String price;
  String? percentChange;
  String faceValue;

  Coin({
    required this.symbol,
    required this.shortName,
    required this.name,
    required this.price,
    required this.faceValue,
  });
}
