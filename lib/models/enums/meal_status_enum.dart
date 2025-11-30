enum MealStatusEnum {
  PENDING('PENDING', 'Pending'),
  APPROVED('APPROVED', 'Approved'),
  DISABLED('DISABLED', 'Disabled'),
  DELETED('DELETED', 'Deleted');

  final String key;
  final String value;

  const MealStatusEnum(this.key, this.value);

  static MealStatusEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return MealStatusEnum.values.firstWhere((e) => e.key == key);
    } catch (_) {
      return null;
    }
  }

  @override
  String toString() => value;
}
