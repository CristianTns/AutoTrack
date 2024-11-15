import 'package:flutter/material.dart';
import '../models/car.dart';
import 'add_car.dart';
import '../services/api_service.dart';

class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

/*class _CarListScreenState extends State<CarListScreen> {
  List<Car> _cars = [];

  // Funcția pentru adăugarea unei noi mașini
  void _addNewCar(Car newCar) {
    setState(() {
      _cars.add(newCar);
    });
  }

  void _startAddNewCar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => AddCarScreen(onAddCar: _addNewCar)),
    );
  }*/

class _CarListScreenState extends State<CarListScreen> {
  List<Car> _cars = [];

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  void _loadCars() async {
    try {
      // Preia lista de vehicule din baza de date prin API
      final List<dynamic> fetchedCars = await ApiService().getVehicles();
      setState(() {
        // Convertește datele într-o listă de obiecte `Car`
        _cars = fetchedCars.map((data) => Car.fromMap(data)).toList();
      });
    } catch (e) {
      print('Eroare la încărcarea vehiculelor: $e');
    }
  }

  void _addNewCar(Car newCar) {
    setState(() {
      _cars.add(newCar);
    });
  }

  void _startAddNewCar(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => AddCarScreen(onAddCar: _addNewCar)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cars.isEmpty
          ? Center(
        child: Text(
          "The list is empty. Press + to add a vehicle.",
          style: TextStyle(fontSize: 16, color: Colors.blue[800]),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _cars.length,
        itemBuilder: (ctx, index) {
          final car = _cars[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.blue[800]!, width: 2),
            ),
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(15.0),
              leading: Icon(Icons.directions_car, size: 40, color: Colors.green[600]),
              title: Text(
                "${car.make} ${car.model}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              subtitle: Text(
                "Year: ${car.year},Mileage: ${car.mileage} km",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.green[600]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewCar(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.green[600],
      ),
    );
  }
}





/*import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/api_service.dart';

class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  List<Car> _cars = []; // Lista vehiculelor

  @override
  void initState() {
    super.initState();
    _loadCars(); // Încarcă vehiculele când ecranul este inițializat
  }

  // Funcție pentru a prelua vehiculele din baza de date
  void _loadCars() async {
    try {
      final List<dynamic> fetchedCars = await ApiService().getVehicles();
      setState(() {
        _cars = fetchedCars.map((data) => Car.fromMap(data)).toList();
      });
    } catch (e) {
      print('Eroare la încărcarea vehiculelor: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Vehicles"),
        backgroundColor: Colors.blue[800],
      ),
      body: _cars.isEmpty
          ? Center(
        child: Text(
          "No vehicles found. Press + to add a vehicle.",
          style: TextStyle(fontSize: 16, color: Colors.blue[800]),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _cars.length,
        itemBuilder: (ctx, index) {
          final car = _cars[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.blue[800]!, width: 2),
            ),
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(15.0),
              leading: Icon(Icons.directions_car, size: 40, color: Colors.green[600]),
              title: Text(
                "${car.make} ${car.model}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              subtitle: Text(
                "Year: ${car.year}, Mileage: ${car.mileage} km",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.green[600]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aici poți adăuga logica pentru a deschide ecranul de adăugare a vehiculului
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[600],
      ),
    );
  }
}*/

