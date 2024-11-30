import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> result;
  final String originCity;
  final String destinationCity;
  final int weight;
  final String courier;

  ResultPage({
    required this.result,
    required this.originCity,
    required this.destinationCity,
    required this.weight,
    required this.courier,
  });

  @override
  Widget build(BuildContext context) {
    final costs = result['rajaongkir']['results'][0]['costs'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Hasil Ongkos Kirim"),
        backgroundColor: Color(0xFFF9B904),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Pengecekan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildDetailRow("Kota Asal", originCity),
                    _buildDetailRow("Kota Tujuan", destinationCity),
                    _buildDetailRow("Berat Barang", "$weight gram"),
                    _buildDetailRow("Ekspedisi", courier.toUpperCase()),
                  ],
                ),
              ),
            ),
            Text(
              "Hasil Ongkos Kirim",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: costs.length,
                itemBuilder: (context, index) {
                  final cost = costs[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cost['service'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Rp ${cost['cost'][0]['value']}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF9B904),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Estimasi Waktu: ${cost['cost'][0]['etd']} hari",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
