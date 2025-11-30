/// Purchase category types
enum PurchaseTypeEnum {
  grocery('GROCERY', 'Grocery'),
  utility('UTILITY', 'Utility');

  final String key;
  final String value;

  const PurchaseTypeEnum(this.key, this.value);

  /// Get enum from key
  static PurchaseTypeEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return PurchaseTypeEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return PurchaseTypeEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
