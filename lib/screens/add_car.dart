import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/api_service.dart'; // adaptează această cale dacă e necesar


class AddCarScreen extends StatefulWidget {
  final Function(Car) onAddCar;

  AddCarScreen({required this.onAddCar});

  @override
  _AddCarScreenState createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();

  final List<String> carMakes = [
    'Audi',
    'BMW',
    'Ford',
    'Mercedes',
    'Toyota',
    'Volkswagen'
  ];

  final Map<String, List<String>> carModels = {
    'Audi': ['A3', 'A4', 'A6', 'Q5', 'Q7'],
    'BMW': ['X1', 'X3', 'X5', '3 Series', '5 Series'],
    'Ford': ['Focus', 'Fiesta', 'Mustang', 'Explorer'],
    'Mercedes': ['C-Class', 'E-Class', 'GLA', 'GLE'],
    'Toyota': ['Corolla', 'Camry', 'RAV4', 'Highlander'],
    'Volkswagen': ['Golf', 'Passat', 'Tiguan', 'Touareg'],
  };

  final List<String> fuelTypes = ['Petrol', 'Diesel', 'Electric', 'Hybrid'];
  String? selectedFuelType;

  List<String> getYearsList() {
    int currentYear = DateTime.now().year;
    return List.generate(currentYear - 1950 + 1, (index) => (currentYear - index).toString());
  }

  void clearFields() {
    makeController.clear();
    modelController.clear();
    yearController.clear();
    mileageController.clear();
    setState(() {
      selectedFuelType = null;
    });
  }

  void addCar(BuildContext context) async {
    final String make = makeController.text.trim();
    final String model = modelController.text.trim();
    final String yearInput = yearController.text.trim();
    final String mileage = mileageController.text.trim();

    if (make.isEmpty || model.isEmpty || yearInput.isEmpty || mileage.isEmpty || selectedFuelType == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill out all fields')));
      return;
    }

    final int year = int.tryParse(yearInput) ?? 0;
    if (year <= 1886 || year > DateTime.now().year) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid year')));
      return;
    }

    final int mileageValue = int.tryParse(mileage) ?? -1;
    if (mileageValue < 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid mileage')));
      return;
    }

    final Car newCar = Car(
      make: make,
      model: model,
      year: year,
      mileage: mileageValue,
      fuelType: selectedFuelType!,
    );

    // Salvează vehiculul în baza de date prin API
    try {
      await ApiService().addVehicle(make, model, year, mileageValue, selectedFuelType!);
      widget.onAddCar(newCar);
      clearFields();

      // Afișează mesaj de succes și închide ecranul
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Car added successfully')));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add car')));
      print('Eroare la adăugarea vehiculului: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Add Car")),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }
                  return carMakes.where((String option) {
                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  makeController.text = selection;
                  modelController.clear();
                },
                fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
                    FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: "Brand",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  );
                },
              ),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (makeController.text.isEmpty || carModels[makeController.text] == null) {
                    return const Iterable<String>.empty();
                  }
                  final List<String> models = carModels[makeController.text]!;
                  return models.where((String option) {
                    return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String selection) {
                  modelController.text = selection;
                },
                fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
                    FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: "Model",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  );
                },
              ),
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return getYearsList();
                  }
                  return getYearsList().where((String option) {
                    return option.contains(textEditingValue.text);
                  });
                },
                onSelected: (String selection) {
                  yearController.text = selection;
                },
                fieldViewBuilder: (BuildContext context, TextEditingController textEditingController,
                    FocusNode focusNode, VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelText: "Year",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  );
                },
              ),
              TextField(
                controller: mileageController,
                decoration: InputDecoration(
                  labelText: "Mileage",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                value: selectedFuelType,
                hint: Text("Select Fuel Type"),
                items: fuelTypes.map((String fuelType) {
                  return DropdownMenuItem<String>(
                    value: fuelType,
                    child: Text(fuelType),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedFuelType = newValue;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => addCar(context),
                child: Text("Add"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                ).copyWith(elevation: ButtonStyleButton.allOrNull(10)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
