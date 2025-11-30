# Login Screen - API Integration Reference

## API Endpoints Used

### 1. Login Authentication

**Endpoint:** `POST /dine-ease/api/v1/member/secure/login`

**Full URL:** `http://localhost:9000/dine-ease/api/v1/member/secure/login`

**Headers:**
```
Content-Type: application/json
Accept: application/json
```

**Request Body:**
```json
{
  "phoneNumber": "01726967760",
  "password": "tuhin123"
}
```

**Success Response (200 OK):**
```json
{
  "status": true,
  "message": "Login successful",
  "data": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "memberResponse": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "phoneNumber": "01726967760",
      "name": "John Doe",
      "email": "john@example.com",
      "roles": ["ROLE_USER"]
    }
  },
  "httpStatusCode": 200,
  "apiResponseCode": "SUCCESS"
}
```

**Error Response - User Not Found (404 Not Found):**
```json
{
  "status": false,
  "message": "User not found",
  "apiResponseCode": "NO_USER_EXIST",
  "httpStatusCode": 404
}
```
**Flutter Error Message:** "User not found. Please check your phone number or sign up."

**Error Response - Invalid Credentials (401 Unauthorized):**
```json
{
  "status": false,
  "message": "Invalid credentials",
  "apiResponseCode": "INVALID_CREDENTIALS",
  "httpStatusCode": 401
}
```
**Flutter Error Message:** "Invalid phone number or password. Please try again."

**Error Response - Server Error (500 Internal Server Error):**
```json
{
  "status": false,
  "message": "Internal server error",
  "apiResponseCode": "SERVER_ERROR",
  "httpStatusCode": 500
}
```
**Flutter Error Message:** "Login failed. Please try again."

---

### 2. Fetch Dine Information

**Endpoint:** `POST /dine-ease/api/v1/dine/member-associate`

**Full URL:** `http://localhost:9000/dine-ease/api/v1/dine/member-associate`

**Headers:**
```
Content-Type: application/json
Accept: application/json
```

**Request Body:**
```json
{
  "phoneNumber": "01726967760"
}
```

**Success Response (200 OK):**
```json
{
  "status": true,
  "data": {
    "id": "660e8400-e29b-41d4-a716-446655440001",
    "dineName": "My Mess Hall",
    "createdDate": "2024-01-01T00:00:00Z"
  }
}
```

**Error Response (404 Not Found):**
```json
{
  "status": false,
  "message": "No dine association found for this member"
}
```
**Note:** This error is logged but does not block user login.

---

## Request/Response Flow

### Login Flow
```
1. User enters phone number and password
2. Flutter validates input (11 digits, min 6 chars)
3. Flutter sends POST to /member/secure/login
4. Backend validates credentials
5. Backend returns JWT tokens + user data
6. Flutter saves to secure storage:
   - Access token → Secure Storage
   - Refresh token → Secure Storage
   - Member data → Secure Storage (JSON)
   - Phone number → Shared Preferences
   - User name → Shared Preferences
   - User ID → Shared Preferences
7. Flutter sends POST to /dine/member-associate
8. Backend returns dine information
9. Flutter saves dine ID → Shared Preferences
10. Flutter navigates to home screen
```

### Error Handling Flow
```
1. Network error occurs
2. Dio catches DioException
3. Flutter maps exception to user message
4. Display in global error alert (red box)
5. User can retry with same data
```

---

## Flutter Data Models

### AuthenticationRequest
```dart
class AuthenticationRequest {
  final String phoneNumber;
  final String password;
  
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}
```

### AuthenticationResponse
```dart
class AuthenticationResponse {
  final bool status;
  final String message;
  final AuthenticationData? data;
  final int httpStatusCode;
  final String apiResponseCode;
}

class AuthenticationData {
  final String accessToken;
  final String refreshToken;
  final MemberResponse memberResponse;
}

class MemberResponse {
  final String id;
  final String phoneNumber;
  final String name;
  final String? email;
  final List<String> roles;
}
```

### DineInfoSearchDto
```dart
class DineInfoSearchDto {
  final String phoneNumber;
  
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
    };
  }
}
```

### DineInfoResponse
```dart
class DineInfoResponse {
  final bool status;
  final DineData? data;
}

class DineData {
  final String id;
  final String dineName;
  final String createdDate;
}
```

---

## HTTP Client Configuration

### Dio Setup
```dart
final Dio _dio = Dio(BaseOptions(
  baseUrl: 'http://localhost:9000/dine-ease/api/v1',
  connectTimeout: Duration(seconds: 30),
  receiveTimeout: Duration(seconds: 30),
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  },
));
```

### Timeout Settings
- **Connect Timeout:** 30 seconds
- **Receive Timeout:** 30 seconds
- If exceeded, Flutter shows: "Network error. Please check your connection and try again."

---

## Error Code Mapping

| Backend Code | HTTP Status | Flutter Message |
|--------------|-------------|-----------------|
| `NO_USER_EXIST` | 404 | "User not found. Please check your phone number or sign up." |
| `INVALID_CREDENTIALS` | 401 | "Invalid phone number or password. Please try again." |
| `SERVER_ERROR` | 500 | "Login failed. Please try again." |
| Connection Timeout | - | "Network error. Please check your connection and try again." |
| Connection Error | - | "Network error. Please check your connection and try again." |
| Unknown Error | - | "Login failed. Please try again." |

---

## Storage Keys

### Secure Storage (Keychain/Keystore)
| Key | Value | Example |
|-----|-------|---------|
| `access_token` | JWT string | "eyJhbGciOiJIUzI1..." |
| `refresh_token` | JWT string | "eyJhbGciOiJIUzI1..." |
| `member_data` | JSON string | '{"id":"550e8400-...",...}' |

### Shared Preferences (Local Storage)
| Key | Value | Example |
|-----|-------|---------|
| `phoneNumber` | String | "01726967760" |
| `name` | String | "John Doe" |
| `id` | String (UUID) | "550e8400-e29b-41d4-a716-446655440000" |
| `dineId` | String (UUID) | "660e8400-e29b-41d4-a716-446655440001" |

---

## Backend Requirements

### Required Endpoints
1. ✅ `POST /member/secure/login` - Authentication
2. ✅ `POST /dine/member-associate` - Dine info retrieval

### Response Format Requirements
- All responses must include `status` boolean
- Success responses must include `data` object
- Error responses must include:
  - `message` string
  - `apiResponseCode` string
  - `httpStatusCode` integer

### CORS Configuration (If Backend on Different Port)
```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: POST, GET, OPTIONS
Access-Control-Allow-Headers: Content-Type, Accept
```

---

## Testing with Backend

### Using Postman/Insomnia

#### Test Login
```
POST http://localhost:9000/dine-ease/api/v1/member/secure/login
Content-Type: application/json

Body:
{
  "phoneNumber": "01726967760",
  "password": "tuhin123"
}
```

#### Test Dine Info
```
POST http://localhost:9000/dine-ease/api/v1/dine/member-associate
Content-Type: application/json

Body:
{
  "phoneNumber": "01726967760"
}
```

### Using cURL

#### Login Request
```bash
curl -X POST http://localhost:9000/dine-ease/api/v1/member/secure/login \
  -H "Content-Type: application/json" \
  -d '{"phoneNumber":"01726967760","password":"tuhin123"}'
```

#### Dine Info Request
```bash
curl -X POST http://localhost:9000/dine-ease/api/v1/dine/member-associate \
  -H "Content-Type: application/json" \
  -d '{"phoneNumber":"01726967760"}'
```

---

## Android Emulator Network Configuration

### Issue: localhost doesn't work on Android emulator

**Solution:** Use `10.0.2.2` instead of `localhost`

Update `lib/config/environment.dart`:
```dart
static const String memberAuthService = 'http://10.0.2.2:9000';
```

### Network Access Permissions
Already configured in `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

---

## iOS Simulator Network Configuration

### Issue: localhost doesn't work on iOS simulator

**Solution:** iOS simulator can access `localhost` directly, but you can also use:
- Machine's IP address: `http://192.168.x.x:9000`
- Or keep using: `http://localhost:9000`

### Network Access Permissions
Already configured in `ios/Runner/Info.plist`:
```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

---

## Security Considerations

### Token Storage
- Access token → `FlutterSecureStorage` (encrypted)
- Refresh token → `FlutterSecureStorage` (encrypted)
- Never stored in `SharedPreferences` or plain text

### Password Handling
- Password only sent once during login
- Never stored anywhere on device
- Transmitted over HTTPS in production

### Production Checklist
- [ ] Use HTTPS URLs (`https://api.yourserver.com`)
- [ ] Remove pre-filled credentials
- [ ] Enable certificate pinning (recommended)
- [ ] Implement token refresh logic
- [ ] Add request/response encryption (if needed)
- [ ] Enable ProGuard for Android
- [ ] Enable code obfuscation for iOS

---

## Future Enhancements

### Token Refresh
When access token expires:
```dart
Future<void> refreshToken() async {
  final refreshToken = await StorageService().getRefreshToken();
  
  final response = await _dio.post(
    '/member/secure/refresh-token',
    data: {'refreshToken': refreshToken},
  );
  
  await StorageService().saveAccessToken(response.data['accessToken']);
}
```

### Authenticated Requests
For subsequent API calls after login:
```dart
final token = await StorageService().getAccessToken();

final response = await _dio.get(
  '/protected/endpoint',
  options: Options(
    headers: {'Authorization': 'Bearer $token'},
  ),
);
```

---

## Debugging API Issues

### Enable Dio Logging
```dart
_dio.interceptors.add(LogInterceptor(
  request: true,
  requestHeader: true,
  requestBody: true,
  responseHeader: true,
  responseBody: true,
  error: true,
));
```

### Common Issues
1. **Connection Refused:**
   - Backend not running
   - Wrong port number
   - Firewall blocking

2. **Timeout:**
   - Backend slow to respond
   - Network congestion
   - Increase timeout duration

3. **404 Not Found:**
   - Wrong endpoint URL
   - Backend route not configured
   - Context path mismatch

4. **CORS Error (Web only):**
   - Backend not allowing cross-origin requests
   - Configure CORS on backend

---

## Contact Backend Team

Provide this information when reporting issues:
1. Request URL: `http://localhost:9000/dine-ease/api/v1/member/secure/login`
2. Request body: `{"phoneNumber":"01726967760","password":"tuhin123"}`
3. Expected response format (see above)
4. Error code mapping requirements
5. Timeout requirements (30 seconds)

---

## Summary

The Flutter login screen is fully configured to work with the backend API. Ensure:
1. Backend is running on `http://localhost:9000`
2. Endpoints return correct response format
3. Error codes match mapping table
4. CORS is configured (if needed)
5. Test data exists in database:
   - Phone: 01726967760
   - Password: tuhin123
