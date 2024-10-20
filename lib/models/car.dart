import 'package:flutter/material.dart';
import 'package:autotrack/db_helper.dart';


class Car {
  String make;
  String model;
  int year;
  int mileage;
  String fuelType;

  Car({required this.make, required this.model, required this.year, required this.mileage, required this.fuelType});


  // Conversie de la Map la Car
  static Car fromMap(Map<String, dynamic> map) {
    return Car(
      make: map['make'],
      model: map['model'],
      year: map['year'],
      mileage: map['mileage'],
      fuelType: map['fuel'],
    );
  }

  // Conversie de la Car la Map
  Map<String, dynamic> toMap() {
    return {
      'make': make,
      'model': model,
      'year': year,
      'mileage': mileage,
    };
  }
}

class MyCarApp extends StatefulWidget {
  @override
  _MyCarAppState createState() => _MyCarAppState();
}

class _MyCarAppState extends State<MyCarApp> {
  List<Car> _cars = [];

  void _addCar(String make, String model, int year, int mileage,
      String fuel) async {
    final newCar = Car(make: make,
        model: model,
        year: year,
        mileage: mileage,
        fuelType: fuel);
    await DBHelper().insertCar(newCar.toMap());
    _getCars();
  }

  void _getCars() async {
    final cars = await DBHelper().getCars();
    setState(() {
      _cars = cars.map((car) => Car.fromMap(car)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _getCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car List')),
      body: ListView.builder(
        itemCount: _cars.length,
        itemBuilder: (ctx, index) {
          final car = _cars[index];
          return ListTile(
            title: Text('${car.make} ${car.model}'),
            subtitle: Text('Year: ${car.year}, Mileage: ${car.mileage} km'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aici poți deschide un formular pentru a adăuga o mașină nouă,
          // în loc de a adăuga un exemplu fix.
          // Deocamdată, nu face nimic.
        },
        child: Icon(Icons.add),
      ),
    );
  }

}
