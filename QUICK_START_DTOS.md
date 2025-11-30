# 🚀 DTOs & Enums Quick Start Guide

## Import Statement

```dart
import 'package:trying_flutter/models/models.dart';
```

This single import gives you access to all DTOs and Enums!

---

## 📖 Quick Examples

### 1. Login Request

```dart
// Create request
final request = AuthenticationRequest(
  phoneNumber: '01726967760',
  password: 'MySecurePass123',
);

// Validate before sending
if (request.validate()) {
  // Convert to JSON
  final json = request.toJson();
  
  // Send to API
  final response = await dio.post('/api/auth/login', data: json);
}
```

### 2. Parse API Response

```dart
// Generic API response parsing
final apiResponse = ApiResponse<AuthenticationResponse>.fromJson(
  jsonData,
  (data) => AuthenticationResponse.fromJson(data as Map<String, dynamic>),
);

if (apiResponse.isSuccess && apiResponse.hasData) {
  final authData = apiResponse.data!;
  final token = authData.accessToken;
  final user = authData.memberResponse;
  
  print('Welcome ${user?.name}!');
}
```

### 3. Member Registration

```dart
final registerDto = MemberRegisterDto(
  phoneNumber: '01726967760',
  fullName: 'John Doe',
  email: 'john@example.com',
  password: 'SecurePass123',
  confirmPassword: 'SecurePass123',
  address: 'Dhaka, Bangladesh',
  isAcceptTermsAndCondition: true,
);

// Comprehensive validation
if (registerDto.validate()) {
  // All checks passed:
  // - Phone number is 11 digits
  // - Name is not empty
  // - Email format is valid
  // - Password is at least 8 characters
  // - Passwords match
  // - Terms accepted
  
  final json = registerDto.toJson();
  // Send to API...
}
```

### 4. Using Enums

```dart
// Parse from API response
final statusKey = dineDto.dineStatusEnumKey; // 'ACTIVE'
final status = DineStatusEnum.fromKey(statusKey);

// Display value
Text(status?.value ?? 'Unknown'); // Shows: 'Active'

// Check enum value
if (status == DineStatusEnum.active) {
  // Dine is active
}

// Switch statement
switch (status) {
  case DineStatusEnum.active:
    return Icon(Icons.check_circle, color: Colors.green);
  case DineStatusEnum.deactivate:
    return Icon(Icons.pause_circle, color: Colors.orange);
  case DineStatusEnum.deleted:
    return Icon(Icons.cancel, color: Colors.red);
  default:
    return Icon(Icons.help, color: Colors.grey);
}
```

### 5. Dropdown with Enums

```dart
// Get all enum values for dropdown
final purchaseTypes = PurchaseSubTypeEnum.getAllEnumList();

DropdownButtonFormField<String>(
  decoration: InputDecoration(labelText: 'Bill Type'),
  items: purchaseTypes.map((item) {
    return DropdownMenuItem<String>(
      value: item['key'],
      child: Text(item['value']!),
    );
  }).toList(),
  onChanged: (key) {
    final selected = PurchaseSubTypeEnum.fromKey(key);
    print('Selected: ${selected?.value}');
  },
)
```

### 6. Pagination

```dart
// Parse paginated response
final page = Page<MemberInfoDto>.fromJson(
  jsonData,
  (data) => MemberInfoDto.fromJson(data as Map<String, dynamic>),
);

print('Total: ${page.totalElements}');
print('Current page: ${page.number}');
print('Total pages: ${page.totalPages}');
print('Has next: ${page.hasNext}');
print('Has previous: ${page.hasPrevious}');

// Access data
for (final member in page.content) {
  print(member.fullName);
}
```

### 7. Date Handling

```dart
// SMS DTO with expiry check
final smsDto = SMSDto.fromJson(jsonData);

// Get expiry as DateTime
final expiryDate = smsDto.expiryDateTime;

// Check if expired
if (smsDto.isExpired) {
  print('OTP has expired');
} else {
  print('OTP valid until: $expiryDate');
}
```

### 8. Meal Cost Calculation

```dart
// Create meal cost items
final items = [
  MealCostData(itemName: 'Rice', quantity: 5, itemCost: 60.0),
  MealCostData(itemName: 'Chicken', quantity: 2, itemCost: 180.0),
  MealCostData(itemName: 'Vegetables', quantity: 3, itemCost: 40.0),
];

final mealCost = MealCostJsonData(mealCostDataList: items);

// Automatic total calculation
print('Total items: ${mealCost.totalItems}'); // 3
print('Total cost: ${mealCost.totalCost}'); // 780.0
```

### 9. Notification Status

```dart
final summary = NotificationSummaryDto.fromJson(jsonData);

// Check unread count
if (summary.hasUnread) {
  print('You have ${summary.unreadCount} unread notifications');
  
  // Show badge
  Badge(
    label: Text('${summary.unreadCount}'),
    child: Icon(Icons.notifications),
  );
}
```

### 10. Form with Search

```dart
class MealSearchDto extends FormStatusWithPage {
  final String? mealDateTime;
  final String? memberInfoId;
  
  MealSearchDto({
    this.mealDateTime,
    this.memberInfoId,
    int? page,
    int? size,
  }) : super(
    page: page,
    size: size ?? 10, // default from base class
  );
}
```

---

## 🎨 UI Integration Examples

### Login Screen

```dart
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final request = AuthenticationRequest(
      phoneNumber: _phoneController.text,
      password: _passwordController.text,
    );

    if (!request.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid credentials')),
      );
      return;
    }

    try {
      final response = await authService.login(request);
      
      if (response.isSuccess) {
        // Navigate to home
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Login failed')),
        );
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    // UI implementation...
  }
}
```

### Expense Type Selector

```dart
class ExpenseTypeSelector extends StatefulWidget {
  @override
  _ExpenseTypeSelectorState createState() => _ExpenseTypeSelectorState();
}

class _ExpenseTypeSelectorState extends State<ExpenseTypeSelector> {
  PurchaseSubTypeEnum? selectedType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dropdown
        DropdownButtonFormField<PurchaseSubTypeEnum>(
          decoration: InputDecoration(
            labelText: 'Select Bill Type',
            border: OutlineInputBorder(),
          ),
          value: selectedType,
          items: PurchaseSubTypeEnum.values.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Row(
                children: [
                  _getIconForType(type),
                  SizedBox(width: 8),
                  Text(type.value),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => selectedType = value);
          },
        ),
        
        // Display selected
        if (selectedType != null)
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Selected: ${selectedType!.value}'),
          ),
      ],
    );
  }
  
  Icon _getIconForType(PurchaseSubTypeEnum type) {
    switch (type) {
      case PurchaseSubTypeEnum.electricityBill:
        return Icon(Icons.bolt);
      case PurchaseSubTypeEnum.internetBill:
        return Icon(Icons.wifi);
      case PurchaseSubTypeEnum.gasBill:
        return Icon(Icons.local_fire_department);
      case PurchaseSubTypeEnum.waterBill:
        return Icon(Icons.water_drop);
      default:
        return Icon(Icons.receipt);
    }
  }
}
```

---

## 🔍 Common Patterns

### Pattern 1: Safe Parsing

```dart
// Always handle null from fromKey()
final status = DineStatusEnum.fromKey(apiKey);
if (status != null) {
  // Use status safely
  print(status.value);
} else {
  // Handle unknown status
  print('Unknown status: $apiKey');
}
```

### Pattern 2: Validation Before Submit

```dart
void submitForm() {
  final dto = MyDto(...);
  
  if (!dto.validate()) {
    showError('Please check your input');
    return;
  }
  
  // Proceed with valid data
  sendToApi(dto);
}
```

### Pattern 3: Type-Safe API Calls

```dart
Future<ApiResponse<T>> apiCall<T>(
  String endpoint,
  T Function(Map<String, dynamic>) fromJson,
) async {
  try {
    final response = await dio.get(endpoint);
    return ApiResponse<T>.fromJson(
      response.data,
      (data) => fromJson(data as Map<String, dynamic>),
    );
  } catch (e) {
    return ApiResponse<T>(
      status: false,
      message: e.toString(),
    );
  }
}

// Usage
final result = await apiCall<AuthenticationResponse>(
  '/api/auth/login',
  AuthenticationResponse.fromJson,
);
```

---

## 📚 Reference Documents

- **Full DTO Reference**: See `/DTO_IMPLEMENTATION.md`
- **Enum Reference**: See `/ENUMS_REFERENCE.md`
- **Summary**: See `/DTO_SUMMARY.md`
- **API Spec**: See original document provided

---

## ⚡ Pro Tips

1. **Always import from `models.dart`** - Never import individual files
2. **Use `.validate()`** before sending DTOs to API
3. **Handle null returns** from `fromKey()` gracefully
4. **Use enums in switch statements** for type safety
5. **Leverage helper methods** like `isExpired`, `hasValidToken`, `totalCost`
6. **Type your generics** properly: `ApiResponse<MyDto>`, not just `ApiResponse`
7. **Check `isSuccess` and `hasData`** before accessing `response.data`

---

**Happy Coding!** 🎉
