
import 'dart:convert';

import 'package:arraid/config/exceptions.dart';
import 'package:arraid/models/userModel.dart';
import 'package:arraid/services/apiService.dart';

import 'package:arraid/services/localService.dart';

class AuthRepository {
  final ApiService apiService = ApiService("https://alrraid.com");
//final ApiService apiService = ApiService("http://192.168.1.65:3002");
 // final ApiService apiService = ApiService("https://4934-105-235-130-74.ngrok-free.app");

  AuthRepository(ApiService find);
   User? currentUser;


 // AuthRepository(this.apiService);

 

 Future<User> login(String email, String password) async {
  final response = await apiService.postRequest('/api/users/login', {
    'email': email,
    'password': password,
  });


  if (response.statusCode == 200) {
    String token = response.data['token'];
    await LocalService.saveToken(token);

    User user = User.fromJson(response.data);
   // print(user.id);
    await LocalService.saveUser(user); 
  
    // Save user locally
    
    currentUser = user; // Store in memory as well
    return user;
  } else {
    throw AuthException(response.data['error'] ?? 'Unknown error', response.statusCode);
  }
}


    Future<User> signUp(String email, String password, String firstName, String lastName) async {
    final response = await apiService.postRequest('/api/users/add', {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    });

    if (response.statusCode == 200) { 
       String token = response.data['token'];
      await LocalService.saveToken(token);// Assuming 200 is the success status for creation
      return User.fromJson(response.data);
    } else {
       throw AuthException(response.data['error'] ?? 'Unknown error', response.statusCode);
    }
  }
    // Verify code
  Future<void> verifyCode(String code, String token) async {
    final response = await apiService.postRequest('/api/users/verify-code', {
      'code': code,
      'token': token,
    });
   //print(response);
    if (response.statusCode == 201) {
      // Code verified successfully
       String token = response.data['token'];
      await LocalService.saveToken(token);
      return response.data; // Optionally return token or user data
    } else if (response.statusCode == 401) {
      // Incorrect code
      throw AuthException(response.data['msg'] ?? 'Code incorrect', response.statusCode);
    } else {
      // Handle other error cases
      throw AuthException('Unknown error during code verification', response.statusCode);
    }
  }

}
