/// Notification categories
enum NotificationCategoryEnum {
  transactional(
    'TRANSACTIONAL',
    'Transactional (e.g., confirmations, receipts)',
  ),
  promotional('PROMOTIONAL', 'Promotional (e.g., marketing, offers)'),
  social('SOCIAL', 'Social (e.g., likes, comments, follows)'),
  system('SYSTEM', 'System (e.g., app updates, maintenance)'),
  reminder('REMINDER', 'Reminder (e.g., scheduled alerts)');

  final String key;
  final String value;

  const NotificationCategoryEnum(this.key, this.value);

  /// Get enum from key
  static NotificationCategoryEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return NotificationCategoryEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return NotificationCategoryEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
