import 'dart:convert';
import 'package:http/http.dart' as http;

const String localhost = 'http://192.168.56.1:3000';

class ApiService {
  final String apiUrl = 'http://192.168.56.1:3000';


  Future<void> addVehicle(String brand, String model, int year, int mileage, String fuelType) async {
    final response = await http.post(
      Uri.parse('$apiUrl/add-vehicle'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'brand': brand, 'model': model, 'year': year, 'mileage': mileage, 'fuelType': fuelType}),
    );

    if (response.statusCode != 201) {
      throw Exception('Eroare la adăugarea vehiculului');
    }
  }


  Future<List<dynamic>> getVehicles() async {
    final response = await http.get(Uri.parse('$apiUrl/get-vehicles'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Eroare la preluarea vehiculelor');
    }
  }


  Future<void> addExpense(double cost, String date, String description) async {
    final response = await http.post(
      Uri.parse('$apiUrl/add-expense'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'cost': cost, 'date': date, 'description': description}),
    );

    if (response.statusCode != 201) {
      throw Exception('Eroare la adăugarea cheltuielii');
    }
  }

  Future<List<dynamic>> getExpenses() async {
    final response = await http.get(Uri.parse('$apiUrl/get-expenses'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Eroare la preluarea cheltuielilor');
    }
  }
}

