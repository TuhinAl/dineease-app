/// Utility purchase subcategories
enum PurchaseSubTypeEnum {
  electricityBill('ELECTRICITY_BILL', 'Electricity Bill'),
  houseKeeperBill('HOUSE_KEEPER_BILL', 'House Keeper Bill'),
  internetBill('INTERNET_BILL', 'Internet Bill'),
  gasBill('GAS_BILL', 'Gas Bill'),
  waterBill('WATER_BILL', 'Water Bill'),
  dishBill('DISH_BILL', 'Dish Bill'),
  newsPaperBill('NEWS_PAPER_BILL', 'News Paper Bill'),
  othersBill('OTHERS_BILL', 'Other Bill');

  final String key;
  final String value;

  const PurchaseSubTypeEnum(this.key, this.value);

  /// Get enum from key
  static PurchaseSubTypeEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return PurchaseSubTypeEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return PurchaseSubTypeEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
