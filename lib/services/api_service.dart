import 'dart:convert';
import 'package:http/http.dart' as http;

class RajaOngkirService {
  final String apiKey = "4a5986d8a17a24c53421aa5fb587ea13";
  final String baseUrl = "https://api.rajaongkir.com/starter";

  Future<List<dynamic>> getCities() async {
    final response = await http.get(
      Uri.parse("$baseUrl/city"),
      headers: {"key": apiKey},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['rajaongkir']['results'];
    } else {
      throw Exception("Failed to load cities");
    }
  }

  Future<Map<String, dynamic>> calculateShipping(
      String origin, String destination, int weight, String courier) async {
    final response = await http.post(
      Uri.parse("$baseUrl/cost"),
      headers: {"key": apiKey, "Content-Type": "application/json"},
      body: jsonEncode({
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "courier": courier
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to calculate shipping");
    }
  }
}
