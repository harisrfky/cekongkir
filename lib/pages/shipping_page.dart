import 'package:flutter/material.dart';
import 'package:rajaongkir/services/api_service.dart';
import 'package:rajaongkir/pages/result_page.dart';

class ShippingPage extends StatefulWidget {
  @override
  _ShippingPageState createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  String? originId;
  String? destinationId;
  String? originCityName;
  String? destinationCityName;
  String courier = 'jne';
  final TextEditingController weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final RajaOngkirService apiService = RajaOngkirService();

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Ongkos Kirim"),
        backgroundColor: Color(0xFFF9B904), // Warna HEX #f9b904
      ),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.getCities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final cities = snapshot.data!;
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Dropdown untuk Kota Asal
                      DropdownButtonFormField(
                        value: originId,
                        decoration: InputDecoration(
                          labelText: "Kota Asal",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: Icon(Icons.location_city),
                        ),
                        isExpanded: true,
                        items: cities
                            .map((city) => DropdownMenuItem(
                                  value: city['city_id'],
                                  child: Text(city['city_name']),
                                  onTap: () {
                                    originCityName = city['city_name'];
                                  },
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            originId = value as String?;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      // Dropdown untuk Kota Tujuan
                      DropdownButtonFormField(
                        value: destinationId,
                        decoration: InputDecoration(
                          labelText: "Kota Tujuan",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: Icon(Icons.location_city_outlined),
                        ),
                        isExpanded: true,
                        items: cities
                            .map((city) => DropdownMenuItem(
                                  value: city['city_id'],
                                  child: Text(city['city_name']),
                                  onTap: () {
                                    destinationCityName = city['city_name'];
                                  },
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            destinationId = value as String?;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      // TextField untuk Berat Barang
                      TextFormField(
                        controller: weightController,
                        decoration: InputDecoration(
                          labelText: "Berat Barang (gram)",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: Icon(Icons.line_weight),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Berat barang harus diisi";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      // Dropdown untuk Kurir
                      DropdownButtonFormField(
                        value: courier,
                        decoration: InputDecoration(
                          labelText: "Ekspedisi",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: Icon(Icons.local_shipping),
                        ),
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(value: "jne", child: Text("JNE")),
                          DropdownMenuItem(value: "pos", child: Text("POS")),
                          DropdownMenuItem(value: "tiki", child: Text("TIKI")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            courier = value as String;
                          });
                        },
                      ),
                      SizedBox(height: 30),
                      // Tombol Cek Ongkir
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final weight = int.parse(weightController.text);
                            final result = await apiService.calculateShipping(
                              originId!,
                              destinationId!,
                              weight,
                              courier,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                  result: result,
                                  originCity: originCityName!,
                                  destinationCity: destinationCityName!,
                                  weight: weight,
                                  courier: courier,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Cek Ongkir",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF9B904),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
