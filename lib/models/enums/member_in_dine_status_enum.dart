/// Member status within a dine
enum MemberInDineStatusEnum {
  pending('PENDING', 'Pending'),
  joined('JOINED', 'Joined'),
  goAwayFromDine('GO_AWAY_FROM_DINE', 'Go Away From Dine');

  final String key;
  final String value;

  const MemberInDineStatusEnum(this.key, this.value);

  /// Get enum from key
  static MemberInDineStatusEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return MemberInDineStatusEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return MemberInDineStatusEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
