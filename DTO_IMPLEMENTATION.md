# DineEase Flutter DTOs and Enums - Implementation Summary

This document provides an overview of all DTOs (Data Transfer Objects) and Enums created for the DineEase Flutter application based on the Angular application specifications.

## 📁 File Structure

```
lib/models/
├── models.dart                 # Main export file
├── common/                     # Base/Common DTOs
│   ├── api_response.dart
│   ├── enum_dto.dart
│   ├── form_status_with_page.dart
│   └── page.dart
├── auth/                       # Authentication DTOs
│   ├── authentication_request.dart
│   ├── authentication_response.dart
│   ├── member_response.dart
│   └── refresh_token_request.dart
├── sms/                        # SMS & OTP DTOs
│   └── sms_dto.dart
├── member/                     # Member DTOs
│   └── member_register_dto.dart
├── meal/                       # Meal DTOs
│   └── today_overview.dart
├── purchase/                   # Purchase DTOs
│   ├── meal_cost_data.dart
│   └── meal_cost_json_data.dart
├── summary/                    # Summary DTOs
│   └── dine_monthly_overview.dart
├── notification/               # Notification DTOs
│   ├── notification_data.dart
│   └── notification_summary_dto.dart
└── enums/                      # All Enums
    ├── dine_status_enum.dart
    ├── member_in_dine_status_enum.dart
    ├── member_type_enum.dart
    ├── notification_category_enum.dart
    ├── notification_type_enum.dart
    ├── purchase_sub_type_enum.dart
    ├── purchase_type_enum.dart
    ├── read_status_enum.dart
    ├── role_type_enum.dart
    ├── status_enum.dart
    └── subscription_type_enum.dart
```

## ✅ Created DTOs

### Common DTOs (4)
- ✅ `EnumDto` - Generic enum wrapper
- ✅ `ApiResponse<T>` - Generic API response wrapper with type safety
- ✅ `Page<T>` - Generic pagination wrapper
- ✅ `FormStatusWithPage` - Base class for search/pagination

### Authentication DTOs (4)
- ✅ `AuthenticationRequest` - Login request with validation
- ✅ `AuthenticationResponse` - Login response with token management
- ✅ `MemberResponse` - User info in auth response
- ✅ `RefreshTokenRequest` - Token refresh request

### SMS & OTP DTOs (1)
- ✅ `SMSDto` - SMS and OTP handling with expiry checks

### Member DTOs (1)
- ✅ `MemberRegisterDto` - Registration data (extends SMSDto) with full validation

### Meal DTOs (1)
- ✅ `TodayOverview` - Today's meal summary

### Purchase DTOs (2)
- ✅ `MealCostData` - Individual cost item
- ✅ `MealCostJsonData` - Cost breakdown with calculations

### Summary DTOs (1)
- ✅ `DineMonthlyOverview` - Monthly dine statistics

### Notification DTOs (2)
- ✅ `NotificationData` - Notification metadata
- ✅ `NotificationSummaryDto` - Notification summary stats

## ✅ Created Enums (11)

All enums include:
- String key and value pairs
- `fromKey()` static method for parsing
- `getAllEnumList()` for dropdown/list population
- Proper `toString()` override

### Business Logic Enums
- ✅ `PurchaseTypeEnum` (2 values) - Grocery, Utility
- ✅ `PurchaseSubTypeEnum` (8 values) - Electricity, Gas, Water, etc.
- ✅ `StatusEnum` (4 values) - Running, Disabled, Pending, Approved

### User & Access Enums
- ✅ `RoleTypeEnum` (2 values) - Normal User, Admin
- ✅ `MemberTypeEnum` (3 values) - Normal User, Super Admin, Admin
- ✅ `MemberInDineStatusEnum` (3 values) - Pending, Joined, Go Away

### Dine Management Enums
- ✅ `DineStatusEnum` (3 values) - Active, Deactivate, Deleted
- ✅ `SubscriptionTypeEnum` (5 values) - Free Trial, Subscribed, etc.

### Notification Enums
- ✅ `NotificationTypeEnum` (18 values) - All notification event types
- ✅ `NotificationCategoryEnum` (5 values) - Transactional, Promotional, etc.
- ✅ `ReadStatusEnum` (3 values) - Unread, Read, Archived

## 🔧 Features Implemented

### 1. **JSON Serialization**
All DTOs use `json_serializable` for automatic JSON conversion:
```dart
@JsonSerializable()
class MyDto {
  factory MyDto.fromJson(Map<String, dynamic> json) => _$MyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MyDtoToJson(this);
}
```

### 2. **Type Safety with Generics**
Generic classes support any data type:
```dart
ApiResponse<AuthenticationResponse> response;
Page<MemberInfoDto> members;
```

### 3. **Nullable Properties**
All properties are nullable (`?`) to handle missing API data safely.

### 4. **Helper Methods**
Many DTOs include useful helper methods:
- `validate()` - Data validation
- `isExpired` - Check expiry status
- `totalCost` - Calculate totals
- `hasUnread` - Boolean checks

### 5. **Date Handling**
DTOs parse ISO 8601 date strings to `DateTime`:
```dart
DateTime? get expiryDateTime {
  if (expiryTime == null) return null;
  return DateTime.parse(expiryTime!);
}
```

### 6. **Enum Utilities**
All enums provide:
- Key-based lookup: `fromKey('GROCERY')`
- List generation: `getAllEnumList()`
- Display values: `enum.value` or `enum.toString()`

## 📦 Dependencies Added

```yaml
dependencies:
  json_annotation: ^4.9.0

dev_dependencies:
  build_runner: ^2.4.0
  json_serializable: ^6.8.0
```

## 🚀 Usage Examples

### Import All Models
```dart
import 'package:trying_flutter/models/models.dart';
```

### Using DTOs
```dart
// Create request
final request = AuthenticationRequest(
  phoneNumber: '01726967760',
  password: 'password123',
);

// Validate
if (request.validate()) {
  final json = request.toJson();
  // Send to API...
}

// Parse response
final response = ApiResponse<AuthenticationResponse>.fromJson(
  jsonData,
  (data) => AuthenticationResponse.fromJson(data as Map<String, dynamic>),
);

if (response.isSuccess && response.hasData) {
  final token = response.data!.accessToken;
}
```

### Using Enums
```dart
// Get enum value
final type = PurchaseTypeEnum.grocery;
print(type.key);   // 'GROCERY'
print(type.value); // 'Grocery'

// Parse from API
final status = DineStatusEnum.fromKey('ACTIVE'); // DineStatusEnum.active

// For dropdowns
final items = PurchaseSubTypeEnum.getAllEnumList();
// Returns: [{'key': 'ELECTRICITY_BILL', 'value': 'Electricity Bill'}, ...]
```

### Inheritance Example
```dart
// MemberRegisterDto extends SMSDto
final registerDto = MemberRegisterDto(
  // SMSDto properties
  phoneNumber: '01726967760',
  otp: '123456',
  // MemberRegisterDto properties
  fullName: 'John Doe',
  email: 'john@example.com',
  password: 'securePass123',
  confirmPassword: 'securePass123',
  isAcceptTermsAndCondition: true,
);

if (registerDto.validate()) {
  // All validation passed
  final json = registerDto.toJson();
}
```

## ⚙️ Code Generation

After creating/modifying DTOs, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates all `*.g.dart` files for JSON serialization.

## 📝 Remaining DTOs to Create

The following complex DTOs with circular dependencies should be created next:

### High Priority (Referenced by many)
- `MemberInfoDto` - Complete member information
- `DineInfoDto` - Complete dine/mess information
- `DineMemberMappingDto` - Member-Dine relationship

### Meal Management
- `MealHistoryDetailsDto` - Meal entry details
- `MealHistoryDetailsSearchDto` - Meal search criteria

### Purchase Management
- `PurchaseHistoryDto` - Purchase record
- `PurchaseHistoryDetailsDto` - Purchase details
- `PurchaseHistorySearchDto` - Purchase search
- `PurchaserMemberInfos` - Purchaser reference

### Payment Management
- `DinePaymentHistoryDetailsDto` - Payment transaction
- `DinePaymentHistoryDetailsSearchDto` - Payment search

### Summary & Overview
- `DineSummaryDto` - Monthly summary
- `MemberMonthlyOverview` - Member statistics

### Subscription
- `SubscriptionHistoryDto` - Subscription record

### Notification
- `NotificationDto` - Individual notification
- `NotificationPageDto` - Paginated notifications

### Dine Details
- `PersonalDineInformation` - Personal dine info
- `OtherAssociateDineInformation` - Associated dine info

## 🎯 Best Practices

1. **Always run build_runner** after creating/modifying DTOs
2. **Use the models.dart export** for cleaner imports
3. **Validate data** before sending to API using `validate()` methods
4. **Handle nulls** - All properties are nullable
5. **Use enums** instead of string constants
6. **Parse dates** using helper methods like `expiryDateTime`
7. **Type-safe generics** for `ApiResponse<T>` and `Page<T>`

## 🔍 Error Handling

All DTOs are designed to handle:
- Missing fields from API (nullable properties)
- Invalid date formats (try-catch in DateTime parsing)
- Null safety throughout
- Validation failures (explicit `validate()` methods)

## 📚 Additional Resources

- Reference: `/API_REFERENCE.md` - Full DTO specifications
- Implementation: `/IMPLEMENTATION_SUMMARY.md` - Project overview
- Login Flow: `/LOGIN_IMPLEMENTATION.md` - Auth implementation guide

---

**Status**: Core DTOs and all Enums created ✅  
**Next Steps**: Create complex inter-dependent DTOs and update existing screens to use them  
**Code Generation**: In progress - run `dart run build_runner build` to complete
