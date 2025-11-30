# DineEase Enums Quick Reference

This file provides a quick reference for all enums in the DineEase Flutter application.

## 📋 Import Statement

```dart
import 'package:trying_flutter/models/models.dart';
```

---

## 🏪 Purchase & Expense Enums

### PurchaseTypeEnum
```dart
PurchaseTypeEnum.grocery      // 'GROCERY' → 'Grocery'
PurchaseTypeEnum.utility      // 'UTILITY' → 'Utility'
```

### PurchaseSubTypeEnum
```dart
PurchaseSubTypeEnum.electricityBill    // 'ELECTRICITY_BILL' → 'Electricity Bill'
PurchaseSubTypeEnum.houseKeeperBill    // 'HOUSE_KEEPER_BILL' → 'House Keeper Bill'
PurchaseSubTypeEnum.internetBill       // 'INTERNET_BILL' → 'Internet Bill'
PurchaseSubTypeEnum.gasBill            // 'GAS_BILL' → 'Gas Bill'
PurchaseSubTypeEnum.waterBill          // 'WATER_BILL' → 'Water Bill'
PurchaseSubTypeEnum.dishBill           // 'DISH_BILL' → 'Dish Bill'
PurchaseSubTypeEnum.newsPaperBill      // 'NEWS_PAPER_BILL' → 'News Paper Bill'
PurchaseSubTypeEnum.othersBill         // 'OTHERS_BILL' → 'Other Bill'
```

---

## 👥 User & Role Enums

### RoleTypeEnum
```dart
RoleTypeEnum.normalUser       // 'NORMAL_USER' → 'Normal User'
RoleTypeEnum.admin            // 'ADMIN' → 'Admin'
```

### MemberTypeEnum
```dart
MemberTypeEnum.normalUser     // 'NORMAL_USER' → 'Normal User'
MemberTypeEnum.superAdmin     // 'SUPER_ADMIN' → 'Super Admin'
MemberTypeEnum.admin          // 'ADMIN' → 'Admin'
```

---

## 🏠 Dine/Mess Enums

### DineStatusEnum
```dart
DineStatusEnum.active         // 'ACTIVE' → 'Active'
DineStatusEnum.deactivate     // 'DEACTIVATE' → 'Deactivate'
DineStatusEnum.deleted        // 'DELETED' → 'Deleted'
```

### MemberInDineStatusEnum
```dart
MemberInDineStatusEnum.pending           // 'PENDING' → 'Pending'
MemberInDineStatusEnum.joined            // 'JOINED' → 'Joined'
MemberInDineStatusEnum.goAwayFromDine    // 'GO_AWAY_FROM_DINE' → 'Go Away From Dine'
```

---

## 💳 Subscription Enum

### SubscriptionTypeEnum
```dart
SubscriptionTypeEnum.freeTrial             // 'FREE_TRIAL' → 'Free Trial'
SubscriptionTypeEnum.subscribed            // 'SUBSCRIBED' → 'Subscribed'
SubscriptionTypeEnum.subscriptionExpired   // 'SUBSCRIPTION_EXPIRED' → 'Subscription Expired'
SubscriptionTypeEnum.currentlyActive       // 'CURRENTLY_ACTIVE' → 'Currently Active'
SubscriptionTypeEnum.leaved                // 'LEAVED' → 'Leaved'
```

---

## 🔔 Notification Enums

### NotificationTypeEnum
```dart
NotificationTypeEnum.invitationSent          // 'INVITATION_SENT' → 'Mess Join Invitation Sent.'
NotificationTypeEnum.invitationAccepted      // 'INVITATION_ACCEPTED' → 'Mess Join Invitation Accepted.'
NotificationTypeEnum.invitationRejected      // 'INVITATION_REJECTED' → 'Mess Join Invitation Rejected.'
NotificationTypeEnum.messLeft                // 'MESS_LEFT' → 'Leave from Other Mess.'
NotificationTypeEnum.messCreated             // 'MESS_CREATED' → 'New Mess Created.'
NotificationTypeEnum.messDeleted             // 'MESS_DELETED' → 'Mess Deleted.'
NotificationTypeEnum.messUpdated             // 'MESS_UPDATED' → 'Mess Updated.'
NotificationTypeEnum.mealAdded               // 'MEAL_ADDED' → 'New Meal Added.'
NotificationTypeEnum.mealUpdated             // 'MEAL_UPDATED' → 'Meal Information Updated.'
NotificationTypeEnum.mealDeleted             // 'MEAL_DELETED' → 'Meal Deleted.'
NotificationTypeEnum.expenseAdded            // 'EXPENSE_ADDED' → 'Expense cost added.'
NotificationTypeEnum.expenseUpdated          // 'EXPENSE_UPDATED' → 'Expense Updated.'
NotificationTypeEnum.expenseDeleted          // 'EXPENSE_DELETED' → 'Expense Deleted.'
NotificationTypeEnum.paymentMade             // 'PAYMENT_MADE' → 'Payment Made to the Mess.'
NotificationTypeEnum.paymentUpdated          // 'PAYMENT_UPDATED' → 'Mess Payment Updated.'
NotificationTypeEnum.paymentDeleted          // 'PAYMENT_DELETED' → 'Mess Payment Deleted.'
NotificationTypeEnum.subscriptionPaymentMade // 'SUBSCRIPTION_PAYMENT_MADE' → 'Subscription Payment Made.'
NotificationTypeEnum.active                  // 'ACTIVE' → 'Active'
```

### NotificationCategoryEnum
```dart
NotificationCategoryEnum.transactional  // 'TRANSACTIONAL' → 'Transactional (e.g., confirmations, receipts)'
NotificationCategoryEnum.promotional    // 'PROMOTIONAL' → 'Promotional (e.g., marketing, offers)'
NotificationCategoryEnum.social         // 'SOCIAL' → 'Social (e.g., likes, comments, follows)'
NotificationCategoryEnum.system         // 'SYSTEM' → 'System (e.g., app updates, maintenance)'
NotificationCategoryEnum.reminder       // 'REMINDER' → 'Reminder (e.g., scheduled alerts)'
```

### ReadStatusEnum
```dart
ReadStatusEnum.unreadNotifications      // 'UNREAD_NOTIFICATIONS' → 'Unread Notification.'
ReadStatusEnum.readNotifications        // 'READ_NOTIFICATIONS' → 'Read Notification.'
ReadStatusEnum.archivedNotifications    // 'ARCHIVED_NOTIFICATIONS' → 'Archived Notification.'
```

---

## ⚙️ General Status Enum

### StatusEnum
```dart
StatusEnum.running        // 'RUNNING' → 'Running'
StatusEnum.disabled       // 'DISABLED' → 'Disabled'
StatusEnum.pending        // 'PENDING' → 'Pending'
StatusEnum.approved       // 'APPROVED' → 'Approved'
```

---

## 🔧 Common Enum Methods

All enums support these methods:

### Get Key and Value
```dart
final type = PurchaseTypeEnum.grocery;
print(type.key);    // 'GROCERY'
print(type.value);  // 'Grocery'
print(type);        // 'Grocery' (toString override)
```

### Parse from Key
```dart
final status = DineStatusEnum.fromKey('ACTIVE');
if (status != null) {
  print(status.value); // 'Active'
}
```

### Get All Values for Dropdowns
```dart
final allTypes = PurchaseSubTypeEnum.getAllEnumList();
// Returns: [
//   {'key': 'ELECTRICITY_BILL', 'value': 'Electricity Bill'},
//   {'key': 'HOUSE_KEEPER_BILL', 'value': 'House Keeper Bill'},
//   ...
// ]

// Use in DropdownButton
DropdownButton<String>(
  items: allTypes.map((item) {
    return DropdownMenuItem<String>(
      value: item['key'],
      child: Text(item['value']!),
    );
  }).toList(),
  onChanged: (value) {
    final enumValue = PurchaseSubTypeEnum.fromKey(value);
  },
)
```

---

## 💡 Usage Examples

### Checking User Role
```dart
final member = memberResponse; // from API
final roleKey = member.roles?.first;
final role = RoleTypeEnum.fromKey(roleKey);

if (role == RoleTypeEnum.admin) {
  // Show admin features
}
```

### Purchase Type Selection
```dart
// In a form
PurchaseTypeEnum? selectedType;

DropdownButton<PurchaseTypeEnum>(
  value: selectedType,
  items: PurchaseTypeEnum.values.map((type) {
    return DropdownMenuItem(
      value: type,
      child: Text(type.value),
    );
  }).toList(),
  onChanged: (type) {
    setState(() => selectedType = type);
  },
)

// Send to API
final json = {
  'purchaseTypeKey': selectedType?.key,
};
```

### Notification Filtering
```dart
// Filter by category
final category = NotificationCategoryEnum.transactional;
final filteredNotifications = allNotifications.where(
  (n) => n.notificationCategoryEnumKey == category.key,
).toList();

// Check read status
final status = ReadStatusEnum.fromKey(notification.readStatusEnumKey);
if (status == ReadStatusEnum.unreadNotifications) {
  // Show unread indicator
}
```

### Dine Status Check
```dart
final dineStatus = DineStatusEnum.fromKey(dine.dineStatusEnumKey);

switch (dineStatus) {
  case DineStatusEnum.active:
    // Allow operations
    break;
  case DineStatusEnum.deactivate:
    // Show reactivation option
    break;
  case DineStatusEnum.deleted:
    // Hide from list
    break;
  default:
    // Handle unknown status
}
```

---

## 📊 Enum Statistics

- **Total Enums**: 11
- **Total Enum Values**: 49
- **Categories**: Purchase (2), User Management (2), Dine Management (2), Subscription (1), Notifications (3), General (1)

---

## ✨ Tips

1. **Always use enums** instead of hardcoded strings
2. **Use `fromKey()`** when parsing API responses
3. **Use `getAllEnumList()`** for dropdown/picker widgets
4. **Handle null returns** from `fromKey()` gracefully
5. **Use `toString()`** for display values in UI
6. **Switch statements** work great with enums for exhaustive checks
7. **Compare with `==`** operator, not string comparison

---

## 🔗 Related Files

- `/lib/models/enums/` - All enum source files
- `/lib/models/models.dart` - Main export file
- `/DTO_IMPLEMENTATION.md` - Full DTO documentation
