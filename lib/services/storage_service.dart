import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../models/models.dart';
import '../config/constants.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final _secureStorage = const FlutterSecureStorage();
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Secure Storage Methods (for sensitive data)

  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: StorageKeys.accessToken, value: token);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: StorageKeys.accessToken);
  }

  Future<void> saveRefreshToken(String token) async {
    await _secureStorage.write(key: StorageKeys.refreshToken, value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: StorageKeys.refreshToken);
  }

  Future<void> saveMemberData(MemberResponse member) async {
    final jsonString = jsonEncode(member.toJson());
    await _secureStorage.write(key: StorageKeys.memberData, value: jsonString);
  }

  Future<MemberResponse?> getMemberData() async {
    final jsonString = await _secureStorage.read(key: StorageKeys.memberData);
    if (jsonString != null) {
      final json = jsonDecode(jsonString);
      return MemberResponse.fromJson(json);
    }
    return null;
  }

  // Local Storage Methods (for non-sensitive data)

  Future<void> savePhoneNumber(String phoneNumber) async {
    await _prefs?.setString(StorageKeys.phoneNumber, phoneNumber);
  }

  String? getPhoneNumber() {
    return _prefs?.getString(StorageKeys.phoneNumber);
  }

  Future<void> saveUserName(String name) async {
    await _prefs?.setString(StorageKeys.userName, name);
  }

  String? getUserName() {
    return _prefs?.getString(StorageKeys.userName);
  }

  Future<void> saveUserId(String id) async {
    await _prefs?.setString(StorageKeys.userId, id);
  }

  String? getUserId() {
    return _prefs?.getString(StorageKeys.userId);
  }

  Future<void> saveDineId(String dineId) async {
    await _prefs?.setString(StorageKeys.dineId, dineId);
  }

  String? getDineId() {
    return _prefs?.getString(StorageKeys.dineId);
  }

  // Authentication State Methods

  Future<void> saveAuthenticationData(AuthenticationResponse authData) async {
    if (authData.accessToken != null) {
      await saveAccessToken(authData.accessToken!);
    }
    if (authData.refreshToken != null) {
      await saveRefreshToken(authData.refreshToken!);
    }
    if (authData.memberResponse != null) {
      await saveMemberData(authData.memberResponse!);
      if (authData.memberResponse!.phoneNumber != null) {
        await savePhoneNumber(authData.memberResponse!.phoneNumber!);
      }
      if (authData.memberResponse!.name != null) {
        await saveUserName(authData.memberResponse!.name!);
      }
      if (authData.memberResponse!.id != null) {
        await saveUserId(authData.memberResponse!.id!);
      }
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    await _prefs?.clear();
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: StorageKeys.accessToken);
    await _secureStorage.delete(key: StorageKeys.refreshToken);
    await _secureStorage.delete(key: StorageKeys.memberData);
    await _prefs?.remove(StorageKeys.phoneNumber);
    await _prefs?.remove(StorageKeys.userName);
    await _prefs?.remove(StorageKeys.userId);
    await _prefs?.remove(StorageKeys.dineId);
  }
}
