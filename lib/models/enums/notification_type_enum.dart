/// Notification event types
enum NotificationTypeEnum {
  invitationSent('INVITATION_SENT', 'Mess Join Invitation Sent.'),
  invitationAccepted('INVITATION_ACCEPTED', 'Mess Join Invitation Accepted.'),
  invitationRejected('INVITATION_REJECTED', 'Mess Join Invitation Rejected.'),
  messLeft('MESS_LEFT', 'Leave from Other Mess.'),
  messCreated('MESS_CREATED', 'New Mess Created.'),
  messDeleted('MESS_DELETED', 'Mess Deleted.'),
  messUpdated('MESS_UPDATED', 'Mess Updated.'),
  mealAdded('MEAL_ADDED', 'New Meal Added.'),
  mealUpdated('MEAL_UPDATED', 'Meal Information Updated.'),
  mealDeleted('MEAL_DELETED', 'Meal Deleted.'),
  expenseAdded('EXPENSE_ADDED', 'Expense cost added.'),
  expenseUpdated('EXPENSE_UPDATED', 'Expense Updated.'),
  expenseDeleted('EXPENSE_DELETED', 'Expense Deleted.'),
  paymentMade('PAYMENT_MADE', 'Payment Made to the Mess.'),
  paymentUpdated('PAYMENT_UPDATED', 'Mess Payment Updated.'),
  paymentDeleted('PAYMENT_DELETED', 'Mess Payment Deleted.'),
  subscriptionPaymentMade(
    'SUBSCRIPTION_PAYMENT_MADE',
    'Subscription Payment Made.',
  ),
  active('ACTIVE', 'Active');

  final String key;
  final String value;

  const NotificationTypeEnum(this.key, this.value);

  /// Get enum from key
  static NotificationTypeEnum? fromKey(String? key) {
    if (key == null) return null;
    try {
      return NotificationTypeEnum.values.firstWhere((e) => e.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get all enum values as a list
  static List<Map<String, String>> getAllEnumList() {
    return NotificationTypeEnum.values
        .map((e) => {'key': e.key, 'value': e.value})
        .toList();
  }

  @override
  String toString() => value;
}
