import 'package:arraid/services/apiService.dart';
import 'package:get/get.dart';

class DevisRepository {
   // final ApiService apiService = ApiService("https://229e-105-235-134-86.ngrok-free.app");
    final ApiService apiService = ApiService("https://etude.alrraid.com");



  // Constructor to inject the ApiService
  DevisRepository(ApiService find);

  // Method to submit devis
  Future<Map<String, dynamic>> submitDevis(Map<String, dynamic> data) async {
    try {
      final response = await apiService.postRequest('/api/devis', data);

      if (response.statusCode == 200) {
        print('Devis submitted successfully!');
        return response.data; // Return the entire response (devis + command)
      } else {
        throw Exception('Failed to submit devis: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error submitting devis: $e');
    }
  }
   Future<void> activateProject(String projectId, bool isActive) async {
    try {
      final endpoint = '/api/projects/$projectId/activate';
      await apiService.postRequest(endpoint, {});
        
    } catch (e) {
      throw Exception('Error activating project: $e');
    }
  }
    Future<void> subscribeProject(String projectId, bool isSubscribe) async {
    try {
      final endpoint = '/api/projects/$projectId/subscribe';
      await apiService.postRequest(endpoint, {});
        
    } catch (e) {
      throw Exception('Error forcing subscripe project: $e');
    }
  }

  // Method to update command
  Future<void> updateCommand(Map<String, dynamic> data) async {
    try {
      final response = await apiService.postRequest('/api/commands', data);

      if (response.statusCode == 200) {
        print('Command updated successfully!');
      } else {
        throw Exception('Failed to update command: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error updating command: $e');
    }
  }
Future<List<Map<String, dynamic>>> fetchProjects() async {
  try {
    final response = await apiService.getRequest('/api/projects');

    if (response.statusCode == 200) {
      print('Projects fetched successfully!');
      print(response.data);

      // Access the 'projects' key in the response
      var projectData = response.data['projects'];

      // Ensure the 'projects' key contains a list
      if (projectData is List) {
        // Map through the list to extract the necessary fields
        return projectData.map((project) {
          return {
            '_id': project['_id'],

            'title': project['title'],
            'description': project['description'],
            'thumbnail': project['thumbnail'],
            'address': project['address'],
            'vr': project['vr'], // Add this only if it exists in your API
            'vues': project['vues'],
            'status': project['status'],
            'url': project['url'],
            'subscribe': project['subscribe'], // Add this only if it exists in your API
          };
        }).toList();
      } else {
        throw Exception('Invalid response format: "projects" is not a list');
      }
    } else {
      throw Exception('Failed to fetch projects: ${response.data}');
    }
  } catch (e) {
    throw Exception('Error fetching projects: $e');
  }
}
Future<List<Map<String, dynamic>>> fetchViews() async {
  try {
    final response = await apiService.getRequest('/api/views');

    if (response.statusCode == 200) {
      print('Views fetched successfully!');
      print(response.data);

      // Access the 'views' key in the response
      var viewsData = response.data['views'];

      // Ensure the 'views' key contains a list
      if (viewsData is List) {
        // Map through the list to extract the necessary fields
        return viewsData.map((view) {
          return {
            '_id': view['_id'], // Ensure this field exists in the API response
            'email': view['email'],
            'fullname': view['fullname'],
            'phone': view['phone'],
            'idProject': view['idProject'],
            'createdAt': view['createdAt'],
            'updatedAt':view['updatedAt'],
            '__v': view['__v'], // Optional, depending on your needs
          };
        }).toList();
      } else {
        throw Exception('Invalid response format: "views" is not a list');
      }
    } else {
      throw Exception('Failed to fetch views: ${response.data}');
    }
  } catch (e) {
    throw Exception('Error fetching views: $e');
  }
}
Future<Map<String, List<Map<String, dynamic>>>> fetchAndCategorizeCommands() async {
  try {
    // Make the GET request to the /api/commands endpoint
    final response = await apiService.getRequest('/api/commands');

    if (response.statusCode == 200) {
      print('Commands fetched successfully!');
      print(response.data);

      // Access the 'commands' key in the response
      var commandData = response.data['commands'];

      // Ensure the 'commands' key contains a list
      if (commandData is List) {
        final devis = <Map<String, dynamic>>[];
        final commands = <Map<String, dynamic>>[];

        for (var item in commandData) {
          // Common fields
          final parsedCommand = {
            'id': item['_id'],
            'status': item['status'],
            'createdAt': item['createdAt'],
            'updatedAt': item['updatedAt'],
            'data': item['data'] ?? {}, // Handle missing 'data' field
          };

          // Additional fields for commands
          if (item['status'] == 'command') {
            parsedCommand.addAll({
              'email': item['email'] ?? '',
              'fullname': item['fullname'] ?? '',
              'phone': item['phone'] ?? '',
            });
            commands.add(parsedCommand);
          } else if (item['status'] == 'devis') {
            devis.add(parsedCommand);
          }
        }

        return {
          'devis': devis,
          'commands': commands,
        };
      } else {
        throw Exception('Invalid response format: "commands" is not a list');
      }
    } else {
      throw Exception('Failed to fetch commands: ${response.data}');
    }
  } catch (e) {
    throw Exception('Error fetching commands: $e');
  }
}


void loadAndPrintCommands() async {
  try {
    final categorizedCommands = await fetchAndCategorizeCommands();

    // Safe null checks to avoid runtime errors
    final devisList = categorizedCommands['devis'];
    final commandsList = categorizedCommands['commands'];

    // Print 'Devis' list if not null
    if (devisList != null) {
      print('Devis: $devisList');
      for (var devis in devisList) {
        print(devis);
      }
    } else {
      print('No devis found');
    }

    // Print 'Commands' list if not null
    if (commandsList != null) {
      print('\nCommands:');
      for (var command in commandsList) {
        print(command);
      }
    } else {
      print('No commands found');
    }
  } catch (e) {
    print('Error loading commands: $e');
  }
}


}
