import 'dart:convert';
import 'package:arraid/config/exceptions.dart';
import 'package:arraid/models/userListModel.dart';

import 'package:arraid/services/apiService.dart';
import 'package:arraid/services/localService.dart';

class Homerepository {
  final ApiService apiService = ApiService("http://192.168.1.65:3002");
   Homerepository(ApiService find);
  List<Userlistmodel> users = []; // List to store User objects

 

  Future<List<Userlistmodel>> fetchUsers() async {
    try {
      final response = await apiService.getRequest('/api/users'); // Adjust endpoint as necessary

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data; 
        print(responseData);// The API response is a map
        // Assuming the user data is nested in a 'data' key (adjust this as necessary)
         if (responseData['users'] != null && responseData['users'] is List) {
        List<dynamic> usersData = responseData['users'] as List<dynamic>;

        // Map the list of user data to Userlistmodel instances
        return usersData.map((user) => Userlistmodel.fromJson(user)).toList();
      } else {
        throw Exception('No valid data found in the response');
      }
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading users: $e');
    }
  }

    Future<void> updatedUsers(List<Userlistmodel> users) async {
    // Collect the ids of the users who became employees
    List<String> employeeIds = users
        .where((user) => user.isEmployee == 'true') // Filter for new employees
        .map((user) => user.id) // Get their _id
        .toList();

    try {
      // Prepare the data for the PUT request
      Map<String, dynamic> data = {
        'ids': employeeIds,
      };
      print(data);

      // Send the PUT request with the employee IDs
      await apiService.putRequest('/api/users/employee/add', data);
    } catch (e) {
      print("Error updating users: $e");
      // Handle error
    }
  }
    
  /* if (response.statusCode == 200) {
    print("Raw response: ${response.data}");

    try {
      String rawResponse = response.data.toString();

      // Fix the response format
      rawResponse = rawResponse.replaceAllMapped(
          RegExp(r'(\w+):'), (match) => '"${match.group(1)}":'); // Add quotes to keys

      // Fix unquoted string values
      rawResponse = rawResponse.replaceAllMapped(
          RegExp(r': ([a-zA-Z0-9_]+)'), (match) => ': "${match.group(1)}"'); // Add quotes to values

      // Fix the email addresses
rawResponse = rawResponse.replaceAllMapped(
    RegExp(r'"email": "([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+)"'),
    (match) => '"email": "${match.group(1)}@${match.group(2)}"');

      // Fix the imageUrl
      rawResponse = rawResponse.replaceAll(
          'imageUrl": "https"://', 'imageUrl": "https://');

      // Fix date formats
    
      // Remove extra commas
      rawResponse = rawResponse.replaceAll('},,', '},');

      print("Modified response for parsing: $rawResponse"); // Log the modified response

      // Decode the cleaned-up string
      Map<String, dynamic> jsonResponse = jsonDecode(rawResponse);
      List<dynamic> userList = jsonResponse['users']; // Get the users list

      // Map the JSON list to a list of User objects
      users = userList.map((userJson) => Userlistmodel.fromJson(userJson)).toList();
      return users; // Return the list of User objects
    } catch (e) {
      print("Parsing error: $e"); // Log any parsing errors
      throw Exception('Failed to parse user data: $e');
    }
  } else {
    throw Exception('Failed to load users: ${response.statusCode}');
  } */



}
