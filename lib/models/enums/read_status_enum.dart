/// Notification read status
enum ReadStatusEnum {
  unreadNotifications('UNREAD_NOTIFICATIONS', 'Unread Notification.'),
  readNotifications('READ_NOTIFICATIONS', 'Read Notification.'),
  archivedNotifications('ARCHIVED_NOTIFICATIONS', 'Archived Notification.');

  final String key;
  final String value;

  const ReadStatusEnum(this.key, this.value);

  /// Get enum from key
  static ReadStatusEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return ReadStatusEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return ReadStatusEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
