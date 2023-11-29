import 'package:cloud_firestore/cloud_firestore.dart';

void addData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    Map<String, Map<String, dynamic>> locations = {
      "CX03112023233814": {
        "busNumber": "1111",
        "departureDate": "03/11/2023",
        "departureTime": "23:38",
        "endPoint": "DD02",
        "priceTicket": "140000VND",
        "startPoint": "DD01"
      },
      "CX04112023000918": {
        "busNumber": "1111",
        "departureDate": "10/11/2023",
        "departureTime": "04:09",
        "endPoint": "DD03",
        "priceTicket": "33333VND",
        "startPoint": "DD04"
      },
      "CX06112023221408": {
        "busNumber": "37FX-1234",
        "departureDate": "07/11/2023",
        "departureTime": "18:00",
        "endPoint": "DD02",
        "priceTicket": "1500000VND",
        "startPoint": "DD01"
      },
      "CX07112023221542": {
        "busNumber": "37FX-1234",
        "departureDate": "08/11/2023",
        "departureTime": "18:15",
        "endPoint": "DD03",
        "priceTicket": "100000VND",
        "startPoint": "DD01"
      }
    };

    for (var locationId in locations.keys) {
      await firestore
          .collection('Routes')
          .doc(locationId)
          .set(locations[locationId]!);
    }

    print("Multiple locations added successfully");
  } catch (e) {
    print("Error adding multiple locations: $e");
  }
}
