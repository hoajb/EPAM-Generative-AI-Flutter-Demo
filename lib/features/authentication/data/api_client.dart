import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client client;

  ApiClient({required this.baseUrl, http.Client? client})
      : this.client = client ?? http.Client();

  //Simulate
  Future<String> login(String email, String password) async {
    // simulating API call
    await Future.delayed(Duration(seconds: 2));

    if (email == 'epam' && password == 'epam') {
      return 'success-token';
    } else {
      throw Exception('Incorrect email or password');
    }
  }

  Future<String> register(String email, String password) async {
    // Simulating API call
    await Future.delayed(Duration(seconds: 2));

    // In this example, we are simulating a register success by returning a mock token
    return 'success-token';
  }

  Future<void> forgotPassword(String email) async {
    // Simulating API call
    await Future.delayed(Duration(seconds: 2));

    // In this example, we assume the forgotPassword API call was successful
  }

  //Real
  // Future<String> login(String email, String password) async {
  //   final response = await client.post(
  //     Uri.parse('$baseUrl/login'),
  //     body: json.encode({"email": email, "password": password}),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final decodedResponse = json.decode(response.body);
  //     return decodedResponse["token"];
  //   } else {
  //     throw Exception('Failed to login');
  //   }
  // }
  //
  // Future<String> register(String email, String password) async {
  //   final response = await client.post(
  //     Uri.parse('$baseUrl/register'),
  //     body: json.encode({"email": email, "password": password}),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final decodedResponse = json.decode(response.body);
  //     return decodedResponse["token"];
  //   } else {
  //     throw Exception('Failed to register');
  //   }
  // }
  //
  // Future<void> forgotPassword(String email) async {
  //   final response = await client.post(
  //     Uri.parse('$baseUrl/forgot-password'),
  //     body: json.encode({"email": email}),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to request password reset');
  //   }
  // }
}