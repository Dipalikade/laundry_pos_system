import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundry_pos_system_app/model/user_model.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Auth State Notifier
class AuthState {
  final bool isLoading;
  final String? error;
  final UserModel? user;
  final String? token;
  final bool isAuthenticated;

  AuthState({
    this.isLoading = false,
    this.error,
    this.user,
    this.token,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    UserModel? user,
    String? token,
    bool? isAuthenticated,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
      token: token ?? this.token,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState());

 // In auth_provider.dart
Future<void> login(String email, String password, bool rememberMe) async {
  state = state.copyWith(isLoading: true, error: null);

  try {
    final response = await _authService.login(email, password);

    // Save token if remember me is checked
    if (rememberMe) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);
      await prefs.setString('user', jsonEncode(response.user.toJson()));
    }

    state = state.copyWith(
      isLoading: false,
      user: response.user,
      token: response.token,
      isAuthenticated: true,
      error: null,
    );
  } catch (e) {
    state = state.copyWith(
      isLoading: false,
      error: e.toString().replaceAll('Exception: ', ''),
      isAuthenticated: false,
    );
  }
}

  Future<void> checkSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    if (token != null) {
      // You might want to validate token here
      state = state.copyWith(
        token: token,
        isAuthenticated: true,
      );
    }
  }

  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true);

      final token = state.token;

      if (token != null) {
        await _authService.logout(token);
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('user');

      state = AuthState(); // Reset state
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}

final authServiceProvider = Provider((ref) => AuthService());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authServiceProvider));
});