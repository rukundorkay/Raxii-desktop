class CheckinCard {
  final String identifier;
  final CardType type;

  CheckinCard({
    required this.identifier,
    required this.type,
  });

  factory CheckinCard.fromJson(Map<String, dynamic> json) {
    return CheckinCard(
      identifier: json['identifier'].toString(),
      type: cardTypeFromString(json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'type': type.name,
    };
  }
}

enum CardType {
  BAR_CODE_CARD,
  // Add other card types here if needed
}

CardType cardTypeFromString(String typeString) {
  return CardType.values.firstWhere(
    (type) => type.name == typeString,
    orElse: () => CardType.BAR_CODE_CARD,
  );
}
