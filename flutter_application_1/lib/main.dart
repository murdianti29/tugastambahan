import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BBMCalculator(),
    );
  }
}

class BBMCalculator extends StatefulWidget {
  @override
  _BBMCalculatorState createState() => _BBMCalculatorState();
}

class _BBMCalculatorState extends State<BBMCalculator> {
  final TextEditingController _kotaTujuanController = TextEditingController();
  final TextEditingController _jarakController = TextEditingController();

  String _selectedBBM = 'Pertalite';
  String _selectedKendaraan = 'Avanza';

  Map<String, double> bbmPrices = {
    'Pertalite': 8000.0,
    'Pertamax': 9000.0,
    'Solar': 7000.0,
  };

  Map<String, double> consumptionRatios = {
    'Avanza': 12.0,
    'Xenia': 11.0,
    'Sigra': 15.0,
    'Brio': 14.0,
  };

  double _result = 0.0;

  void _calculateBBM() {
    double jarak = double.parse(_jarakController.text);
    double hargaBBM = bbmPrices[_selectedBBM]!;
    double konsumsiBBM = consumptionRatios[_selectedKendaraan]!;

    _result = (jarak / konsumsiBBM) * hargaBBM;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator BBM'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Kalkulator BBM',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _kotaTujuanController,
              decoration: InputDecoration(labelText: 'Kota Tujuan'),
            ),
            TextField(
              controller: _jarakController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jarak (km)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BBM', style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: _selectedBBM,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedBBM = newValue!;
                    });
                  },
                  items: bbmPrices.keys.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            DropdownButton<String>(
              value: _selectedKendaraan,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedKendaraan = newValue!;
                });
              },
              items: consumptionRatios.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                _calculateBBM();
              },
              child: Text('Hitung BBM'),
            ),
            SizedBox(height: 20),
            Text(
              'Perjalanan Menuju: ${_kotaTujuanController.text}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
             Text(
              'Jarak: ${_jarakController.text} km',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
             Text(
              ' Menggunakan mobil: $_selectedKendaraan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Memerlukan BBM: ${(_result / bbmPrices[_selectedBBM]!).toStringAsFixed(2)} liter',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Harga per liter: ${bbmPrices[_selectedBBM]}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total Biaya BBM: ${_result.round()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
