
import 'dart:convert';

import 'package:arraid/models/userModel.dart';
import 'package:arraid/services/apiService.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<User> fetchUser(String id) async {
    final response = await apiService.getRequest('/users/$id');
    
    if (response.statusCode == 200) {
      // Parse the response using your User model
      return User.fromJson(response.data);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<User> login(String email, String password) async {
    final response = await apiService.postRequest('/login', {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      // Parse and return the logged-in user
      return User.fromJson(response.data);
    } else {
      throw Exception('Failed to login');
    }
  }
    Future<User> signUp(String email, String password, String firstName, String lastName) async {
    final response = await apiService.postRequest('/signup', {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
    });

    if (response.statusCode == 201) { // Assuming 201 is the success status for creation
      return User.fromJson(response.data);
    } else {
      throw Exception('Failed to sign up: ${response.data['error'] ?? 'Unknown error'}');
    }
  }

  // Add more authentication-related methods here (e.g., signup, logout, etc.)
}
