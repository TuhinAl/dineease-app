/// Subscription status types
enum SubscriptionTypeEnum {
  freeTrial('FREE_TRIAL', 'Free Trial'),
  subscribed('SUBSCRIBED', 'Subscribed'),
  subscriptionExpired('SUBSCRIPTION_EXPIRED', 'Subscription Expired'),
  currentlyActive('CURRENTLY_ACTIVE', 'Currently Active'),
  leaved('LEAVED', 'Leaved');

  final String key;
  final String value;

  const SubscriptionTypeEnum(this.key, this.value);

  /// Get enum from key
  static SubscriptionTypeEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return SubscriptionTypeEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return SubscriptionTypeEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
